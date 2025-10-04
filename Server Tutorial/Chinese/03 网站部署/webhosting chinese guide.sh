# ===== 03. 网站部署 =====
# ⚠️ 已经跑完 01 服务器搭建 的 检测阿里云源,替换为官方源
# ⚠️⚠️⚠️
SERVER_NAME="AliCloudSingapore"
# 本地电脑=====
ssh $SERVER_NAME

# ===== ⚠️ 服务器上=====
# ⚠️⚠️⚠️替换为: 你的服务器上网站文件夹名
YOUR_WEBSITE_FOLDER="your_website_folder"   


echo "==> 更新 apt 并安装系统依赖 (中文注释已添加)"
# 安装 Python3、pip 与编译依赖（libssl, libffi 等）
sudo apt update
sudo apt install -y python3-pip python3-dev build-essential libssl-dev libffi-dev python3-setuptools
echo "==> 使用 pip 安装 Python 包（全局安装，建议正式环境使用虚拟环境）"
# 安装 gunicorn 与 flask、flask_login
pip3 install gunicorn --break-system-packages
pip3 install flask flask_login --break-system-packages
pip3 install --ignore-installed blinker --break-system-packages

echo "==> 创建网站根目录并设置权限"
sudo mkdir -p /opt/${YOUR_WEBSITE_FOLDER}


# =====⚠️本地电脑=====
# 本地 SSH 私钥（scp 用）          
# SSH_DIR="/Users/jonas/.ssh"
# SSH_PRIVATE_FILE="$SSH_DIR/id_ed25519_aliCloudTutorial"
# ⚠️⚠️⚠️替换为: 服务器 IP             
SERVER_IP="your_server_ip_address"   
# ⚠️⚠️⚠️替换为: 本地电脑的文件夹
YOUR_LOCAL_WEBSITE_FOLDER="your_website_folder"   

# -i "$SSH_PRIVATE_FILE"
scp -r "$YOUR_LOCAL_WEBSITE_FOLDER" root@$SERVER_IP:/opt/

SERVER_NAME="AliCloudSingapore"
ssh $SERVER_NAME

# ===== ⚠️ 服务器上=====
# 可以用 VS Code 连接，打开新的 Terminal
# ⚠️⚠️⚠️替换为: 你的服务器上网站文件夹名
YOUR_WEBSITE_FOLDER="your_website_folder"  
# ⚠️⚠️⚠️替换为: 主 python 文件名 (不带 .py)   
MAIN_PY="your_main_python_website_file_name"   
# ⚠️⚠️⚠️替换为: Flask 应用变量名 (例: app)
FLASK_APP_NAME="flask_app_name"  
# ⚠️⚠️⚠️替换为: 服务器 IP             
SERVER_IP="your_server_ip_address"    

code /opt/$YOUR_WEBSITE_FOLDER/
# 在 /opt/目录中放好你的项目后，进入并本地运行测试
python3 ${MAIN_PY}.py
# 根据网站需求下载依赖
# pip3 install shapely --break-system-packages
# pythonfile name : flask app name
gunicorn --bind 0.0.0.0:8000 ${MAIN_PY}:${FLASK_APP_NAME}

# ⚠️测试网站
# ⚠️推出应用 "Control" + "C"


# create a user that will run the app
sudo useradd --no-create-home --shell /bin/false gunicorn
sudo chown -R gunicorn:gunicorn /opt/${YOUR_WEBSITE_FOLDER}

# 注意：ExecStart 中的 gunicorn 路径可能是 /usr/bin/gunicorn 或 /usr/local/bin/gunicorn
# 请使用 `which gunicorn` 确认实际路径并替换下面的路径（如果需要）
SERVICE_FILE="/etc/systemd/system/${MAIN_PY}.service"
echo "==> 创建 systemd 服务文件: ${SERVICE_FILE}"
sudo tee ${SERVICE_FILE} > /dev/null <<EOF
[Unit]
Description=Gunicorn instance to serve Flask app
After=network.target

[Service]
User=gunicorn
Group=gunicorn
WorkingDirectory=/opt/${YOUR_WEBSITE_FOLDER}
ExecStart=/usr/local/bin/gunicorn --workers 3 --bind unix:/opt/${YOUR_WEBSITE_FOLDER}/${MAIN_PY}.sock ${MAIN_PY}:${FLASK_APP_NAME}

[Install]
WantedBy=multi-user.target
EOF

# 重新加载 systemd 并启动服务
echo "==> 重新加载 systemd 并启动服务"
sudo systemctl daemon-reload
sudo systemctl start ${MAIN_PY}
sudo systemctl enable ${MAIN_PY}

# 检查服务状态（可选）
echo "==> 检查 systemd 服务状态（建议手动查看并排查错误）"
sudo systemctl status ${MAIN_PY} --no-pager


# 安装 Nginx
echo "==> 安装并启动 Nginx"
sudo apt install -y nginx
sudo systemctl start nginx
sudo systemctl enable nginx

# 创建 Nginx 站点配置文件（占位符需替换）
NGINX_CONF="/etc/nginx/sites-available/${MAIN_PY}"
echo "==> 创建 Nginx 配置文件: ${NGINX_CONF}"
sudo tee ${NGINX_CONF} > /dev/null <<EOF
server {
    listen 80;
    server_name ${SERVER_IP};

    location / {
      include proxy_params;
      proxy_pass http://unix:/opt/${YOUR_WEBSITE_FOLDER}/${MAIN_PY}.sock;
    }
}
EOF

echo "==> 启用 Nginx 站点，并移除默认配置"
sudo ln -sf ${NGINX_CONF} /etc/nginx/sites-enabled/
sudo rm -f /etc/nginx/sites-enabled/default
sudo nginx -t
sudo systemctl restart nginx

# ---------------------------------------
# ====== ⚠️第一步完成，可以直接访问IP测试⚠️ ======
# ---------------------------------------







# ----------------------------------------------
# ====== ⚠️使用Certbot 安装证书 开启 HTTPS⚠️ ======
# ----------------------------------------------
# -----------------------------------------------
# ====== ⚠️需要购买网址(中国需要备案)⚠️         ======
# ====== ⚠️我是外国人所以用外国服务器不需用备案⚠️ ======
# ====== ⚠️网址需要指向服务器IP地址⚠️           ======
# ------------------------------------------------
# =====⚠️本地电脑=====
SERVER_NAME="AliCloudSingapore"
ssh $SERVER_NAME

# ===== ⚠️ 服务器上=====
# ⚠️⚠️⚠️替换为: 你的服务器上网站文件夹名
YOUR_WEBSITE_FOLDER="your_website_folder"  
# ⚠️⚠️⚠️替换为: 主 python 文件名 (不带 .py)   
MAIN_PY="your_main_python_website_file_name"   
# ⚠️⚠️⚠️替换为: 服务器 IP             
SERVER_IP="your_server_ip_address"    
# ⚠️⚠️⚠️替换为: 域名          
DOMAIN="your_domain_name"    
# ⚠️⚠️⚠️替换为: www 子域名（如果适用）                  
WWW_DOMAIN="www.your_domain_name"  
# ⚠️⚠️⚠️替换为: 静态文件夹名             
STATIC_FOLDER="your_static_folder"
  

NGINX_CONF="/etc/nginx/sites-available/${MAIN_PY}"


echo "==> 创建 Nginx 配置文件: ${NGINX_CONF}"
sudo tee ${NGINX_CONF} > /dev/null <<EOF

# HTTP: 将所有 HTTP 请求重定向到 HTTPS
server {
  listen 80;
  server_name ${DOMAIN} ${WWW_DOMAIN} ${SERVER_IP};
  return 301 https://${DOMAIN}$request_uri;
}

# 直接通过 IP 访问: 重定向到域名 (使用 HTTPS)
server {
  listen 443 ssl;
  server_name ${SERVER_IP};

  ssl_certificate /etc/letsencrypt/live/${DOMAIN}/fullchain.pem;
  ssl_certificate_key /etc/letsencrypt/live/${DOMAIN}/privkey.pem;
  include /etc/letsencrypt/options-ssl-nginx.conf;

  location / {
    return 301 https://${DOMAIN}$request_uri;
  }
}

# HTTPS: 应用代理与静态文件服务
server {
  listen 443 ssl;
  server_name ${DOMAIN} ${WWW_DOMAIN};

  ssl_certificate /etc/letsencrypt/live/${DOMAIN}/fullchain.pem;
  ssl_certificate_key /etc/letsencrypt/live/${DOMAIN}/privkey.pem;
  include /etc/letsencrypt/options-ssl-nginx.conf;

  add_header Strict-Transport-Security "max-age=31536000; includeSubDomains; preload" always;

  # 代理到 unix socket (Gunicorn)
  location / {
    proxy_pass http://unix:/opt/${YOUR_WEBSITE_FOLDER}/${MAIN_PY}.sock;
    proxy_set_header Host $host;
    proxy_set_header X-Real-IP $remote_addr;
    proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
    proxy_set_header X-Forwarded-Proto $scheme;
  }

  # 为静态文件创建别名，直接由 nginx 提供静态资源，避免经过 gunicorn
  location /${STATIC_FOLDER}/ {
    alias /opt/${YOUR_WEBSITE_FOLDER}/${STATIC_FOLDER}/;
  }

  client_max_body_size 10M;
}
EOF


# 使用 certbot 获取并安装 Let's Encrypt 证书（需要域名已解析到本服务器）
echo "==> 安装 certbot 并尝试为域名获取证书（请确保 DNS 已指向本服务器）"
sudo apt install -y certbot python3-certbot-nginx

# 自动为域名获取证书
sudo certbot --nginx -d ${DOMAIN} -d ${WWW_DOMAIN}
# 测试自动续期
sudo certbot renew --dry-run 


# 测试并重启 Nginx
sudo nginx -t
sudo systemctl restart nginx



echo "更新防火墙规则..."
ufw allow 80/tcp
ufw allow 443/tcp
ufw reload
# !!! on alicloud console need to activate firewall rule because it has its own security group
# ⚠️⚠️⚠️ 阿里云上面需要在控制台编辑防火墙规则
# ⚠️⚠️⚠️ Be careful when using cloudflare. use full ssl because it will try to communicate http but then server wants https