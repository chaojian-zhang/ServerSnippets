sudo apt update
sudo apt install -y nginx

sudo ufw app list
sudo ufw allow 'Nginx HTTP'
sudo ufw status

systemctl status nginx
# sudo systemctl stop nginx
# sudo systemctl start nginx
# sudo systemctl restart nginx # sudo nginx -s reload
# sudo systemctl reload nginx
# sudo systemctl disable nginx
# sudo systemctl enable nginx

# Server address
curl -4 icanhazip.com