#!/bin/bash

# 配置
LATEST_RELEASE="https://api.github.com/repos/v2fly/v2ray-core/releases/latest"
INSTALL_DIR="/opt/v2ray"
DEFAULT_PORT=58
DEFAULT_PASSWORD="XinDongDeVPN123"  # 默认 Shadowsocks 密码，可替换
SERVICE_FILE="/etc/systemd/system/v2ray.service"

# 确保以 root 用户运行脚本
if [ "$(id -u)" != "0" ]; then
  echo "此脚本必须以 root 用户运行" 1>&2
  exit 1
fi

# 检测系统架构
ARCH=$(uname -m)
case $ARCH in
  x86_64) ARCH="64" ;;
  aarch64) ARCH="arm64-v8a" ;;
  arm*) ARCH="arm32-v7a" ;;
  *) echo "不支持的系统架构"; exit 1 ;;
esac

# 获取最新版本信息
echo -e "\n\033[1;36mV2Ray 自动安装脚本\033[0m"
echo "正在获取最新版本..."
RELEASE_DATA=$(curl -sL $LATEST_RELEASE)
VERSION=$(echo $RELEASE_DATA | grep -Po '"tag_name": "\K.*?(?=")')
DOWNLOAD_URL=$(echo "$RELEASE_DATA" | jq -r ".assets[] | select(.name | endswith(\"linux-$ARCH.zip\")) | .browser_download_url")
ZIP_FILE="v2ray-linux-$ARCH.zip"
echo "下载地址: $DOWNLOAD_URL"

# 用户配置
read -p "是否使用默认配置? [Y/n] (端口: $DEFAULT_PORT, 密码: $DEFAULT_PASSWORD) " USE_DEFAULTS
USE_DEFAULTS=${USE_DEFAULTS:-Y}

if [[ "$USE_DEFAULTS" =~ [Yy] ]]; then
  PORT=$DEFAULT_PORT
  SS_PASSWORD=$DEFAULT_PASSWORD
else
  # 输入端口号
  while true; do
    read -p "请输入端口号 (1024-65535): " PORT
    [[ $PORT =~ ^[0-9]+$ ]] && [ $PORT -ge 1024 ] && [ $PORT -le 65535 ] && break
    echo "端口号无效！"
  done

  # 输入 Shadowsocks 密码
  while true; do
    read -sp "请输入 Shadowsocks 密码: " SS_PASSWORD
    [[ -n "$SS_PASSWORD" ]] && break
    echo -e "\n密码不能为空！"
  done
  echo
fi

# 检查端口是否被占用
if lsof -i :$PORT >/dev/null; then
  echo "端口 $PORT 已被占用！"
  exit 1
fi

# 安装依赖
echo -e "\n正在安装依赖..."
apt-get update && apt-get install -y unzip curl qrencode jq

# 创建安装目录
echo "在 $INSTALL_DIR 设置 V2Ray..."
mkdir -p "$INSTALL_DIR"
cd "$INSTALL_DIR"

# 下载并解压 V2Ray
echo "正在下载 V2Ray $VERSION..."
echo "下载地址: $DOWNLOAD_URL"
if ! curl -LO "$DOWNLOAD_URL"; then
  echo "下载失败！"
  exit 1
fi

# 解压 ZIP 文件
unzip -o "$ZIP_FILE"
if [ $? -ne 0 ]; then
  echo "解压失败！"
  exit 1
fi
rm -f "$ZIP_FILE"

# 创建 V2Ray 配置文件
echo "正在创建配置文件..."
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

# 创建系统用户 v2ray（如果不存在）
if ! id -u v2ray &>/dev/null; then
  useradd --system --home-dir "$INSTALL_DIR" --shell /bin/false v2ray
fi

# 设置文件权限
chown -R v2ray:v2ray "$INSTALL_DIR"
chmod 700 "$INSTALL_DIR"

# 创建 systemd 服务
echo "正在配置 systemd 服务..."
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

# 测试配置是否正确
echo "正在验证配置..."
"$INSTALL_DIR"/v2ray test -config "$INSTALL_DIR"/config.json
if [ $? -ne 0 ]; then
  echo "配置测试失败！请检查 config.json"
  exit 1
fi

# 启用并启动服务
systemctl daemon-reload
systemctl enable v2ray
systemctl restart v2ray

# 验证服务状态
if ! systemctl is-active --quiet v2ray; then
  echo "服务启动失败！"
  journalctl -u v2ray -n 10 --no-pager
  exit 1
fi

# 配置防火墙（如果存在 ufw）
if command -v ufw &>/dev/null; then
  echo "更新防火墙规则..."
  ufw allow $PORT/tcp
  ufw allow $PORT/udp
  ufw reload
fi

# 获取公网 IP
PUBLIC_IP=$(curl -s4 https://api.ipify.org)
if [ -z "$PUBLIC_IP" ]; then
  echo "无法获取公网 IP！"
  exit 1
fi

# 生成二维码
echo -e "\n\u001b[32m安装完成！\u001b[0m"
echo "========================"
echo "服务器 IP: $PUBLIC_IP"
echo "端口: $PORT"
echo "密码: $SS_PASSWORD"
echo "加密方法: aes-128-gcm"
echo "========================"

# 生成 Shadowsocks URL 并显示二维码
SS_URL="ss://$(echo -n "aes-128-gcm:$SS_PASSWORD@$PUBLIC_IP:$PORT" | base64 -w 0)#V2RayVPN"
echo -e "\n二维码:"
echo "$SS_URL" | qrencode -t UTF8
echo -e "\nShadowsocks URL: $SS_URL"

echo -e "\n\033[1;31m=================================================================\033[0m"
echo -e "\033[1;31m⚠️  警告: 如果使用阿里云, 请在 服务器工作台-防火墙-中添加规则!  ⚠️\033[0m"
echo -e "\033[1;31m⚠️  新增规则 协议选择TCP, 第二个规则选择协议UDP              !  ⚠️\033[0m"
echo -e "\033[1;31m⚠️  两个规则的-端口范围-输入(端口) $PORT                        !  ⚠️\033[0m"
echo -e "\033[1;31m=================================================================\033[0m\n"
