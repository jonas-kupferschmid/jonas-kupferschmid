# Host a python website

install all packages needed
```bash
sudo apt install python3-pip python3-dev build-essential libssl-dev libffi-dev python3-setuptools
# y to confirm installations
pip3 install gunicorn --break-system-packages
pip3 install flask flask_login --break-system-packages
pip3 install --ignore-installed blinker --break-system-packages

sudo mkdir -p /opt/{{your_website_folder}}
```
## On mac terminal
```bash
# upload the files to that folder (folder included)
scp -i ~/.ssh/id_ed25519_your_ssh_key_name -r "{{Path_To_Your_Local_Website_Folder}}" root@{{your_server_ip_address}}:/opt/
```
## Back on the server
```bash
code /opt/{{your_website_folder}}/
# test the app
python3 {{your_main_python_website_file_name}}.py
pip3 install shapely --break-system-packages

# pythonfile name : flask app name
gunicorn --bind 0.0.0.0:8000 {{your_main_python_website_file_name}}:{{flask_app_name}}

# create a user that will run the app
sudo useradd --no-create-home --shell /bin/false gunicorn

sudo chown -R gunicorn:gunicorn /opt/{{your_website_folder}}

# create a service so it will auto start gunicorn and serve flask app
code /etc/systemd/system/{{your_main_python_website_file_name}}.service
```
/etc/systemd/system/{{your_main_python_website_file_name}}.service
```bash
[Unit]
Description=Gunicorn instance to serve Flask app
After=network.target

[Service]
User=gunicorn
Group=gunicorn
WorkingDirectory=/opt/{{your_website_folder}}
ExecStart=/usr/local/bin/gunicorn --workers 3 --bind unix:/opt/{{your_website_folder}}/{{your_main_python_website_file_name}}.sock {{your_main_python_website_file_name}}:{{flask_app_name}}

[Install]
WantedBy=multi-user.target
```
launch the service
```bash
sudo systemctl daemon-reload
sudo systemctl start {{your_main_python_website_file_name}}
sudo systemctl enable {{your_main_python_website_file_name}}
```

# Install nginx
```bash
sudo apt install nginx

sudo systemctl start nginx
sudo systemctl enable nginx
```
Create a new file in /etc/nginx/sites-available/{{your_main_python_website_file_name}} and Replace your_ubuntu_ip with your actual server IP address.

```bash
code  /etc/nginx/sites-available/{{your_main_python_website_file_name}}
```

# Test out the website with http
```bash
server {
  listen 80;
  server_name {{your_server_ip_address}};

  ocation / {
    include proxy_params;
    proxy_pass http://unix:/opt/{{your_website_folder}}/{{your_main_python_website_file_name}}.sock;
  }
}
```

```bash
sudo ln -s /etc/nginx/sites-available/{{your_main_python_website_file_name}} /etc/nginx/sites-enabled/
sudo rm /etc/nginx/sites-enabled/default
sudo nginx -t
sudo systemctl restart nginx
```

# HTTPS certify with certbot

obtain certificate
```bash
sudo apt install certbot python3-certbot-nginx

sudo certbot --nginx -d {{your_domain_name}} -d {{www.your_domain_name}}
sudo certbot renew --dry-run
```



```bash
code  /etc/nginx/sites-available/{{your_main_python_website_file_name}}
```


```bash
# Redirect HTTP to HTTPS for {{your_domain_name}}l
server {
  listen 80;
  server_name {{your_domain_name}} {{www.your_domain_name}} {{your_server_ip_address}};
  return 301 https://{{your_domain_name}}$request_uri;
}

# Redirect direct IP access to domain
server {
  listen 443 ssl;
  server_name {{your_server_ip_address}};

  ssl_certificate /etc/letsencrypt/live/{{your_domain_name}}/fullchain.pem;
  ssl_certificate_key /etc/letsencrypt/live/{{your_domain_name}}/privkey.pem;
  include /etc/letsencrypt/options-ssl-nginx.conf;

  location / {
    return 301 https://{{your_domain_name}}$request_uri;
  }
}

# HTTPS server block for {{your_domain_name}}
server {
  listen 443 ssl;
  server_name {{your_domain_name}} {{www.your_domain_name}};

  ssl_certificate /etc/letsencrypt/live/{{your_domain_name}}/fullchain.pem;
  ssl_certificate_key /etc/letsencrypt/live/{{your_domain_name}}/privkey.pem;
  include /etc/letsencrypt/options-ssl-nginx.conf;

  add_header Strict-Transport-Security "max-age=31536000; includeSubDomains; preload" always;


  location / {
  proxy_pass http://unix:/opt/{{your_website_folder}}/{{your_main_python_website_file_name}}.sock;
  proxy_set_header Host $host;
  proxy_set_header X-Real-IP $remote_addr;
  proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
  proxy_set_header X-Forwarded-Proto $scheme;
  }
  # performance increase so static files doesn't go through Gunicorn. but will bypass login requirements
  location /{{your_static_folder}}/ {
  alias /opt/{{your_website_folder}}/{{your_static_folder}}/;
  }
  client_max_body_size 10M;
}
```


```bash
sudo nginx -t
sudo systemctl restart nginx
```

