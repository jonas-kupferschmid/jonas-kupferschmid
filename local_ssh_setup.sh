ssh-keygen -t ed25519 -C "aliCloud" -f ~/.ssh/id_ed25519_aliCloud -N ""


SERVER_IP="your_server_ip_here" # Replace with your server's IP address
ADMIN_USER="root"
REGION="Japan"
SSH_CONFIG_FOLDER="/Users/your_local_username/.ssh/config"

# run before install.sh and vpnsetup.sh
ssh-copy-id -i ~/.ssh/id_ed25519_aliCloud.pub $ADMIN_USER@$SERVER_IP

echo "Editing SSH config..."
{
  echo ""
  echo "Host aliCloud$REGION"
  echo "  HostName $SERVER_IP"
  echo "  User $ADMIN_USER"
  echo "  IdentityFile ~/.ssh/id_ed25519_aliCloud"
} >> $SSH_CONFIG_FOLDER
echo "Transferring setup files..."

scp server_setup.sh vpn_setup.sh aliCloud$REGION:/root

#on the server after root login
# Make scripts executable
ssh aliCloud$REGION
ls -l *.sh
chmod +x server_setup.sh vpn_setup.sh
# Run server setup
./server_setup.sh
exit 
ssh-copy-id -i ~/.ssh/id_ed25519_aliCloud.pub jonas@$SERVER_IP
# Then run VPN setup
ssh aliCloud$REGION
./vpn_setup.sh


# !!! on alicloud console need to activate firewall rule because it has its own security group






rm ./vpn_setup.sh
ls
exit

REGION="Japan"
scp vpn_setup.sh aliCloud$REGION:/root
ssh aliCloud$REGION

chmod +x vpn_setup.sh
./vpn_setup.sh


systemctl status v2ray




cat > config.json <<EOL
{
  "log": {
    "loglevel": "warning"
  },
  "inbounds": [{
    "port": 58,
    "protocol": "shadowsocks",
    "settings": {
      "method": "aes-128-gcm",
      "password": "your_vpn_password",
      "network": "tcp,udp"
    }
  }],
  "outbounds": [{
    "protocol": "freedom",
    "settings": {}
  }]
}
EOL