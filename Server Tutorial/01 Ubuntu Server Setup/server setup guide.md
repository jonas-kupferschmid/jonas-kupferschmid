# Buy a Server
1. add money
2. select cpu and ubuntu server
3. deploy now

# Login to Server
1. copy username root and password {{your_server_password}} and ipaddress {{your_server_ip_address}}
2. install remote explorer addon on vscode
3. vscode remote explorer add remote
4. ssh root@{{your_server_ip_address}}
  - trust fingerprint of server
5. enter password {{your_server_password}}
6. open terminal in vscode

# Security Updates
```bash
# on Server see all files
ls -a  
# update packages
sudo apt update && sudo apt upgrade -y
apt list --upgradable
# create new admin user
adduser {{your_new_user_name}} 
# create password & fill out info
usermod -aG sudo {{your_new_user_name}}
# login with new admin user by changing remote controller configuration
```

on my local mac book
1. Open terminal
```bash
# generate a new rsa key
ssh-keygen -t ed25519 -C "your_comment" -f ~/.ssh/id_ed25519_your_ssh_key_name
# leave password blank for encrypting key
# see my key under Users/your_local_user/.ssh
# upload the key to the server
ssh-copy-id -i ~/.ssh/id_ed25519_your_ssh_key_name.pub {{your_new_user_name}}@{{your_server_ip_address}}
# enter password Uv3RmC45FDyW8h
# use the correct key for login
ssh -i ~/.ssh/id_ed25519_your_ssh_key_name {{your_new_user_name}}@{{your_server_ip_address}}
#upload for root account
ssh-copy-id -i ~/.ssh/id_ed25519_your_ssh_key_name.pub root@{{your_server_ip_address}}
# type in password
ssh -i ~/.ssh/id_ed25519_your_ssh_key_name root@{{your_server_ip_address}}

# change configuration file add 
Host what-i-want-to-call-it
  HostName {{your_server_ip_address}}
  User root
  IdentityFile ~/.ssh/id_ed25519_your_ssh_key_name
# demo ssh host (login without password)
```
show open folder / to see where all the ssh key is saved

# Disable password connection for root
1. connect with vscode
2. open folder /etc
    - avoid opening large folders or vscode indexing will make it crash

```bash
# change PermitRootLogin yes to 
# change UsePAM yes
PermitRootLogin prohibit-password
UsePAM no
# PasswordAuthentication no if you want to completely deactivate password login

# uncomment and change for ddos attack prevention
LoginGraceTime 1m
MaxAuthTries 3

#in terminal validate sshd config file
sudo sshd -t
# should be empty
# restart ssh
sudo systemctl restart ssh
# control c to stop anything
# you can test and see that password login is not allowed
```

# Enable Firewall
```bash
# allow ssh !important! so you don't get locked out
sudo ufw allow OpenSSH
#dns
sudo ufw allow 53/udp
#website
sudo ufw allow 80/tcp
sudo ufw allow 443/tcp
# any other apps or services that you want to run you need to allow
sudo ufw default deny incoming
sudo ufw default allow outgoing
# after allowing ssh 
sudo ufw enable

sudo ufw status verbose


# you will see many people will try to brute force you so you should ban ip
sudo apt install fail2ban -y
# Fail2Ban's main config is at /etc/fail2ban/jail.conf, but never edit it directly. 
sudo cp /etc/fail2ban/jail.conf /etc/fail2ban/jail.local
# edit options
increase findtime, bantime, 
bantime.increment = true

# start it
sudo systemctl enable fail2ban
sudo systemctl start fail2ban
# to see what is banned already
sudo fail2ban-client status sshd


# to see auth logs
# go to folder var/log and open auth.log
```