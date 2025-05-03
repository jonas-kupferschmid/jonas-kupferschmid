#!/bin/bash
# Save as: server_setup.sh

DEFAULT_USER="your_username"  # Replace with your desired username
DEFAULT_PASSWORD="your_password"  # Replace with your desired password

# Ensure script is run as root
if [ "$(id -u)" != "0" ]; then
    echo "This script must be run as root" 1>&2
    exit 1
fi

echo -e "\n\033[1;36mServer Setup Configuration\033[0m\n"
read -p "Use default settings? [Y/n] (username: $DEFAULT_USER, hardened SSH) " USE_DEFAULTS
USE_DEFAULTS=${USE_DEFAULTS:-Y}

echo "Updating system packages..."
apt update && apt upgrade -y

# User configuration
if [[ "$USE_DEFAULTS" =~ [Yy] ]]; then
    ADMIN_USER=$DEFAULT_USER
    ADMIN_PASS=$DEFAULT_PASSWORD
    echo -e "\nUsing default credentials:"
    echo "Username: $ADMIN_USER"
else
    read -p "Enter admin username: " ADMIN_USER
    while [ -z "$ADMIN_USER" ]; do
        read -p "Username cannot be empty. Enter admin username: " ADMIN_USER
    done
    
    read -s -p "Enter password for $ADMIN_USER: " ADMIN_PASS
    echo
    while [ -z "$ADMIN_PASS" ]; do
        read -s -p "Password cannot be empty. Enter password: " ADMIN_PASS
        echo
    done
fi

# User creation
if id -u "$ADMIN_USER" &>/dev/null; then
    echo -e "\nUser $ADMIN_USER already exists. Skipping creation."
else
    echo -e "\nCreating new user: $ADMIN_USER"
    useradd -m -s /bin/bash "$ADMIN_USER"
    echo "$ADMIN_USER:$ADMIN_PASS" | chpasswd
    echo "Password set for $ADMIN_USER"
fi

if ! groups "$ADMIN_USER" | grep -q '\bsudo\b'; then
    usermod -aG sudo "$ADMIN_USER"
    echo "Added $ADMIN_USER to sudo group"
else
    echo "User $ADMIN_USER is already in sudo group"
fi


echo -e "\nConfiguring SSH..."
SSHD_CONFIG="/etc/ssh/sshd_config"
BACKUP_DATE=$(date +%Y%m%d%H%M%S)
cp "$SSHD_CONFIG" "$SSHD_CONFIG.backup_$BACKUP_DATE"

sed -i 's/^#?PermitRootLogin.*/PermitRootLogin prohibit-password/' "$SSHD_CONFIG"
sed -i 's/^#?PasswordAuthentication.*/PasswordAuthentication no/' "$SSHD_CONFIG"
sed -i 's/^#?UsePAM.*/UsePAM no/' "$SSHD_CONFIG"

if ! sshd -t -f "$SSHD_CONFIG"; then
    echo "Error in SSH configuration. Restoring backup..."
    cp "$SSHD_CONFIG.backup_$BACKUP_DATE" "$SSHD_CONFIG"
    exit 1
else
    # Remove backup only if configuration is valid
    rm -f "$SSHD_CONFIG.backup_$BACKUP_DATE"
fi

systemctl restart ssh

echo -e "\nConfiguring UFW firewall..."
ufw allow OpenSSH
ufw allow 53/udp
ufw allow 80/tcp
ufw allow 443/tcp
ufw default deny incoming
ufw default allow outgoing
echo "y" | ufw enable

# Fail2Ban Setup
echo -e "\nInstalling Fail2Ban..."
apt install -y fail2ban

# Configure Fail2Ban properly
cat > /etc/fail2ban/jail.d/defaults.conf <<EOL
[DEFAULT]
bantime = 1h
findtime = 10m
maxretry = 5

[sshd]
enabled = true
EOL

systemctl restart fail2ban

echo -e "\n\u001b[32mServer setup completed successfully!\u001b[0m"
echo "Admin user: $ADMIN_USER"
echo "Firewall rules:"
ufw status verbose
echo -e "\nRemember to test SSH access with your new user!"