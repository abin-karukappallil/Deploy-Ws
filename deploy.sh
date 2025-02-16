#!/bin/bash
git clone https://github.com/abin-karukappallil/Advanced-web-scraper.git
cd Advanced-web-scraper
sudo apt update
sudo ufw allow 80
sudo ufw allow 8000
sudo ufw allow 443
sudo apt install -y python3 python3-pip python3-venv nginx certbot python3-certbot-nginx
python3 -m venv venv
source venv/bin/activate
pip3 install -r requirements.txt
sudo bash -c 'cat > /etc/nginx/sites-enabled/default <<EOF
server {
    listen 80;
    server_name wsapi.abinthomas.dev;

    location / {
        proxy_pass http://127.0.0.1:8000;
    }
}
EOF'
sudo systemctl restart nginx
sudo certbot --nginx --non-interactive --agree-tos -m abinthomas2484@gmail.com -d wsapi.abinthomas.dev
screen -S api -dm uvicorn api:app
