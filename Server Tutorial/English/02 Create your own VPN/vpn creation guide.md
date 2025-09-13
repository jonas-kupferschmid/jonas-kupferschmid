# VPN v2ray Installation

1. Find v2fly v2ray core on github
2. go to releases and copy newestlink 
  - https://github.com/v2fly/v2ray-core/releases/download/v5.30.0/v2ray-linux-64.zip

  - https://github.com/v2fly/v2ray-core/releases/download/v5.30.0/v2ray-linux-64.zip
```bash
sudo apt-get install unzip

cd /opt
sudo mkdir v2ray
cd v2ray
sudo curl -LO https://github.com/v2fly/v2ray-core/releases/download/v5.30.0/v2ray-linux-64.zip
ls
sudo unzip v2ray-linux-64.zip  
code .
```
Edit v2ray/ config.json

```
{
  "log": {
    "loglevel": "warning"
  },
  "inbounds": [
    {
      "port": {{your_desired_port}},
      "protocol": "shadowsocks",
      "settings": {
        "method": "{{your_desired_encryption_method}}",
        "password": "{{your_super_secure_password}}",
        "network": "tcp,udp"
      }
    }
  ],
  "outbounds": [
    {
      "protocol": "freedom",
      "settings": {}
    }
  ]
}
```

# make sure service starts on restart
```bash
sudo cp /opt/v2ray/systemd/system/v2ray.service /etc/systemd/system/v2ray.service

# create new system user: v2ray without login that will later run v2ray
sudo useradd --system --home-dir /opt/v2ray --shell /bin/false v2ray
sudo chown -R v2ray:v2ray /opt/v2ray

code /etc/systemd/system/
```
1. open the file /etc/systemd/system/v2ray.service
2. change the User that will run v2ray
  - change User=nobody to
  - User=v2ray
3. change the path of the service because we downloaded it in /opt
  - from ExecStart=/usr/local/bin/v2ray run -config /usr/local/etc/v2ray/config.json to 
  - ExecStart=/opt/v2ray/v2ray run -config /opt/v2ray/config.json

```bash
sudo systemctl daemon-reload
sudo systemctl enable v2ray
sudo systemctl restart v2ray.service
sudo systemctl status v2ray.service
```

# Enable Firewall Connection

```bash
sudo ufw allow 58/tcp
sudo ufw allow 58/udp

sudo ufw reload
sudo ufw status verbose

```

# connect with phone
download shadowrocket

- Type: Shadowsocks
- Address: {{your_server_ip_address}}
- Port: {{your_desired_port}}
- Password: {{your_super_secure_password}}
- Method: {{your_desired_encryption_method}}
save 
test connection