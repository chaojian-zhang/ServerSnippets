# SSL
sudo snap install core
sudo snap refresh core

sudo snap install --classic certbot
sudo ln -s /snap/bin/certbot /usr/bin/certbot

# Running HTTPS with NGINX is easier for certificate management, otherwise configure Kestrel to directly use HTTPS is hard.
# sudo certbot certonly --standalone
sudo certbot --nginx