# ===== 第一次运行 ======
# =====本地电脑=====
ssh-keygen -t ed25519 -C "aliCloudTutorial" -f ~/.ssh/id_ed25519_aliCloudTutorial -N ""
ssh-add ~/.ssh/id_ed25519_aliCloudTutorial

# ===== 每个新服务器运行 =====
# ===== 01. 服务器搭建 =====
# password: XinDongDeRuilong123!
# =====本地电脑=====
# 服务器IP地址
SERVER_IP="47.237.191.159" 
# 服务器账号
ADMIN_USER="root"
# 服务器名称（简称为了更容易的连接）
SERVER_NAME="AliCloudSingapore"
# 加密钥匙文件路径
SSH_DIR="/Users/jonas/.ssh"
SSH_CONFIG_FILE="$SSH_DIR/config"
SSH_FILE="$SSH_DIR/id_ed25519_aliCloudTutorial.pub"
SSH_PRIVATE_FILE="$SSH_DIR/id_ed25519_aliCloudTutorial"

# 上传加密钥匙到服务器
ssh-copy-id -i $SSH_FILE $ADMIN_USER@$SERVER_IP
# 需要输入服务器密码

# 编辑SSH配置文件以后可以免密码登入
echo "Editing SSH config..."
{
  echo ""
  echo "Host $SERVER_NAME"
  echo "  HostName $SERVER_IP"
  echo "  User $ADMIN_USER"
  echo "  IdentityFile $SSH_PRIVATE_FILE"
} >> $SSH_CONFIG_FILE

# 传送配置脚本到服务器
echo "Transferring setup files..."
scp server_setup.sh $SERVER_NAME:/$ADMIN_USER

# 连接服务器
ssh $SERVER_NAME

# =====服务器上=====
ls -l *.sh
chmod +x server_setup.sh
# Run server setup
./server_setup.sh
exit

# =====本地电脑=====
# 服务器账号2
SERVER_USER="ruilong"
ssh-copy-id -i $SSH_FILE $SERVER_USER@$SERVER_IP

# !!! on alicloud console need to activate firewall rule because it has its own security group
# !!! 阿里云上面需要在控制台编辑防火墙规则


# ===== 02. VPN搭建 =====
SERVER_NAME="AliCloudSingapore"
ADMIN_USER="root"
# 本地电脑=====
scp vpn_setup.sh $SERVER_NAME:/$ADMIN_USER

# 连接服务器
ssh $SERVER_NAME
# =====服务器上=====
ls -l *.sh
chmod +x vpn_setup.sh
./vpn_setup.sh
# !!! on alicloud console need to activate firewall rule because it has its own security group
# !!! 阿里云上面需要在控制台编辑防火墙规则
