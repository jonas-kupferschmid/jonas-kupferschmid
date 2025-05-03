#!/bin/bash

# Configuration
LATEST_RELEASE="https://api.github.com/repos/v2fly/v2ray-core/releases/latest"
INSTALL_DIR="/opt/v2ray"
DEFAULT_PORT=58
DEFAULT_PASSWORD="your_vpn_password"  # Replace with your desired password
SERVICE_FILE="/etc/systemd/system/v2ray.service"

# Ensure script runs as root
if [ "$(id -u)" != "0" ]; then
  echo "This script must be run as root" 1>&2
  exit 1
fi

# Detect architecture
ARCH=$(uname -m)
case $ARCH in
  x86_64) ARCH="64" ;;
  aarch64) ARCH="arm64-v8a" ;;
  arm*) ARCH="arm32-v7a" ;;
  *) echo "Unsupported architecture"; exit 1 ;;
esac

# Get latest version
echo -e "\n\033[1;36mV2Ray Auto Installer\033[0m"
echo "Fetching latest version..."
RELEASE_DATA=$(curl -sL $LATEST_RELEASE)
VERSION=$(echo $RELEASE_DATA | grep -Po '"tag_name": "\K.*?(?=")')
# DOWNLOAD_URL=$(echo $RELEASE_DATA | grep -Po '"browser_download_url": "\K.*?(?=")' | grep "linux-$ARCH.zip")
DOWNLOAD_URL=$(echo "$RELEASE_DATA" | jq -r ".assets[] | select(.name | endswith(\"linux-$ARCH.zip\")) | .browser_download_url")
ZIP_FILE="v2ray-linux-$ARCH.zip"
echo "DOWNLOAD_URL: $DOWNLOAD_URL"

# User configuration
read -p "Use default settings? [Y/n] (port: $DEFAULT_PORT) " USE_DEFAULTS
USE_DEFAULTS=${USE_DEFAULTS:-Y}

if [[ "$USE_DEFAULTS" =~ [Yy] ]]; then
  PORT=$DEFAULT_PORT
  SS_PASSWORD=$DEFAULT_PASSWORD
else
  while true; do
    read -p "Enter port number (1024-65535): " PORT
    [[ $PORT =~ ^[0-9]+$ ]] && [ $PORT -ge 1024 ] && [ $PORT -le 65535 ] && break
    echo "Invalid port number!"
  done

  while true; do
    read -sp "Enter Shadowsocks password: " SS_PASSWORD
    [[ -n "$SS_PASSWORD" ]] && break
    echo -e "\nPassword cannot be empty!"
  done
  echo
fi

# Check port availability
if lsof -i :$PORT >/dev/null; then
  echo "Port $PORT is already in use!"
  exit 1
fi

# Install dependencies
echo -e "\nInstalling dependencies..."
apt-get update && apt-get install -y unzip curl qrencode jq

# Create installation directory
echo "Setting up V2Ray in $INSTALL_DIR..."
mkdir -p "$INSTALL_DIR"
cd "$INSTALL_DIR"

# Download and extract V2Ray
echo "Downloading V2Ray $VERSION..."
echo "Download URL: $DOWNLOAD_URL"
if ! curl -LO "$DOWNLOAD_URL"; then
  echo "Download failed!"
  exit 1
fi



unzip -o "$ZIP_FILE"
if [ $? -ne 0 ]; then
  echo "Extraction failed!"
  exit 1
fi
rm -f "$ZIP_FILE"

# Create config file
echo "Creating configuration..."
cat > config.json <<EOL
{
  "log": {
    "loglevel": "warning"
  },
  "inbounds": [{
    "port": $PORT,
    "protocol": "shadowsocks",
    "settings": {
      "method": "aes-128-gcm",
      "password": "$SS_PASSWORD",
      "network": "tcp,udp"
    }
  }],
  "outbounds": [{
    "protocol": "freedom",
    "settings": {}
  }]
}
EOL

# Create system user
if ! id -u v2ray &>/dev/null; then
  useradd --system --home-dir "$INSTALL_DIR" --shell /bin/false v2ray
fi

# Set permissions
chown -R v2ray:v2ray "$INSTALL_DIR"
chmod 700 "$INSTALL_DIR"

# Create systemd service
echo "Configuring systemd service..."
cat > "$SERVICE_FILE" <<EOL
[Unit]
Description=V2Ray Service
Documentation=https://www.v2fly.org/
After=network.target

[Service]
User=v2ray
CapabilityBoundingSet=CAP_NET_BIND_SERVICE
AmbientCapabilities=CAP_NET_BIND_SERVICE
NoNewPrivileges=true
ExecStart=$INSTALL_DIR/v2ray run -config $INSTALL_DIR/config.json
Restart=on-failure
RestartPreventExitStatus=23
RestartSec=5

[Install]
WantedBy=multi-user.target
EOL

# Test configuration
echo "Validating configuration..."
"$INSTALL_DIR"/v2ray test -config "$INSTALL_DIR"/config.json
if [ $? -ne 0 ]; then
  echo "Configuration test failed! Check config.json"
  exit 1
fi

# Enable and start service
systemctl daemon-reload
systemctl enable v2ray
systemctl restart v2ray

# Verify service status
if ! systemctl is-active --quiet v2ray; then
  echo "Service failed to start!"
  journalctl -u v2ray -n 10 --no-pager
  exit 1
fi

# Configure firewall
if command -v ufw &>/dev/null; then
  echo "Updating firewall rules..."
  ufw allow $PORT/tcp
  ufw allow $PORT/udp
  ufw reload
fi

# Get public IP
PUBLIC_IP=$(curl -s4 https://api.ipify.org)
if [ -z "$PUBLIC_IP" ]; then
  echo "Could not detect public IP!"
  exit 1
fi

# Generate QR code
echo -e "\n\u001b[32mInstallation complete!\u001b[0m"
echo "========================"
echo "Server: $PUBLIC_IP"
echo "Port: $PORT"
echo "Password: $SS_PASSWORD"
echo "Method: aes-128-gcm"
echo "========================"

SS_URL="ss://$(echo -n "aes-128-gcm:$SS_PASSWORD@$PUBLIC_IP:$PORT" | base64 -w 0)#V2RayVPN"
echo -e "\nQR Code:"
echo "$SS_URL" | qrencode -t UTF8
echo -e "\nSS URL: $SS_URL"