#!/bin/bash
# 保存为: server_setup.sh

DEFAULT_USER="ruilong"  # 默认用户名（可替换为你需要的）
DEFAULT_PASSWORD="XinDongDeRuilong123!"  # 默认密码（可替换为你需要的）

# 检测是否以 root 权限运行
if [ "$(id -u)" != "0" ]; then
    echo "此脚本必须以 root 用户运行" 1>&2
    exit 1
fi

# 打印标题
echo -e "\n\033[1;36m服务器初始化配置\033[0m\n"
read -p "是否使用默认配置? [Y/n] (用户名: $DEFAULT_USER, 密码：$DEFAULT_PASSWORD, 加固 SSH) " USE_DEFAULTS
USE_DEFAULTS=${USE_DEFAULTS:-Y}

# APT 源配置
APT_SOURCE_FILE="/etc/apt/sources.list"
ALICLOUD_MIRROR="http://mirrors.cloud.aliyuncs.com/ubuntu"
OFFICIAL_MIRROR="http://archive.ubuntu.com/ubuntu"

# 如果检测到阿里云源，则替换为官方源
if grep -q "$ALICLOUD_MIRROR" "$APT_SOURCE_FILE"; then
    echo "检测到阿里云镜像，正在替换为官方 Ubuntu 源..."
    sed -i "s|$ALICLOUD_MIRROR|$OFFICIAL_MIRROR|g" "$APT_SOURCE_FILE"
    apt update
else
    echo "APT 源未使用阿里云镜像，跳过替换。"
fi

# 更新系统软件包
echo "正在更新系统软件包..."
apt update && apt upgrade -y

# 用户配置
if [[ "$USE_DEFAULTS" =~ [Yy] ]]; then
    ADMIN_USER=$DEFAULT_USER
    ADMIN_PASS=$DEFAULT_PASSWORD
    echo -e "\n使用默认账户信息:"
    echo "用户名: $ADMIN_USER"
else
    # 手动输入用户名
    read -p "请输入管理员用户名: " ADMIN_USER
    while [ -z "$ADMIN_USER" ]; do
        read -p "用户名不能为空，请重新输入: " ADMIN_USER
    done
    
    # 手动输入密码（隐藏输入）
    read -s -p "请输入 $ADMIN_USER 的密码: " ADMIN_PASS
    echo
    while [ -z "$ADMIN_PASS" ]; do
        read -s -p "密码不能为空，请重新输入: " ADMIN_PASS
        echo
    done
fi

# 创建新用户（如果不存在）
if id -u "$ADMIN_USER" &>/dev/null; then
    echo -e "\n用户 $ADMIN_USER 已存在，跳过创建。"
else
    echo -e "\n正在创建新用户: $ADMIN_USER"
    useradd -m -s /bin/bash "$ADMIN_USER"
    echo "$ADMIN_USER:$ADMIN_PASS" | chpasswd
    echo "已为 $ADMIN_USER 设置密码"
fi

# 添加 sudo 权限
if ! groups "$ADMIN_USER" | grep -q '\bsudo\b'; then
    usermod -aG sudo "$ADMIN_USER"
    echo "已将 $ADMIN_USER 添加到 sudo 组"
else
    echo "用户 $ADMIN_USER 已经在 sudo 组中"
fi

# 配置 SSH
echo -e "\n正在配置 SSH..."
SSHD_CONFIG="/etc/ssh/sshd_config"
BACKUP_DATE=$(date +%Y%m%d%H%M%S)
cp "$SSHD_CONFIG" "$SSHD_CONFIG.backup_$BACKUP_DATE"  # 备份配置文件

# 修改 SSH 配置以提高安全性
sed -i 's/^\s*#\?\s*PermitRootLogin.*/PermitRootLogin prohibit-password/' "$SSHD_CONFIG"
sed -i 's/^\s*#\?\s*UsePAM.*/UsePAM no/' "$SSHD_CONFIG"

# 确保 /run/sshd 目录存在，否则 sshd -t 会报错
mkdir -p /run/sshd

# 检查 SSH 配置是否正确
if ! sshd -t -f "$SSHD_CONFIG"; then
    echo "SSH 配置错误，正在恢复备份..."
    cp "$SSHD_CONFIG.backup_$BACKUP_DATE" "$SSHD_CONFIG"
    exit 1
else
    # 如果配置有效，删除备份
    rm -f "$SSHD_CONFIG.backup_$BACKUP_DATE"
fi

# 重启 SSH 服务
systemctl restart ssh

# 配置 UFW 防火墙
echo -e "\n正在配置 UFW 防火墙..."
ufw allow OpenSSH
ufw allow 80/tcp
ufw allow 443/tcp
ufw default deny incoming
ufw default allow outgoing
echo "y" | ufw enable

# 安装并配置 Fail2Ban
echo -e "\n正在安装 Fail2Ban..."
apt install -y fail2ban

# 配置 Fail2Ban 默认规则
cat > /etc/fail2ban/jail.d/defaults.conf <<EOL
[DEFAULT]
bantime = 1h
findtime = 10m
maxretry = 5

[sshd]
enabled = true
EOL

systemctl restart fail2ban

# 脚本完成提示
echo -e "\n\u001b[32m服务器初始化配置已完成!\u001b[0m"
echo "管理员账户: $ADMIN_USER"
echo "防火墙规则:"
ufw status verbose
echo -e "\n请记得使用新用户测试 SSH 连接!"
