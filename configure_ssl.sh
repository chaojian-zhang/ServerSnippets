# SSL
sudo snap install core
sudo snap refresh core
sudo snap install --classic certbot
sudo ln -s /snap/bin/certbot /usr/bin/certbot
sudo certbot certonly --standalone
# Running HTTPS requires NGINX for easier certificate management, otherwise configure Kestrel to use HTTPS is hard.