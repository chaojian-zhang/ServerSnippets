# Reference: https://www.digitalocean.com/community/tutorials/how-to-install-nginx-on-ubuntu-20-04
# After NGINX is installed, we can use those snippets to initialize a new subdomain host
# Replace "my_sub_domain" before execution

# Prepare folder for domain content
sudo mkdir -p /var/www/my_sub_domain/html
sudo chown -R $USER:$USER /var/www/my_sub_domain/html
sudo chmod -R 755 /var/www/my_sub_domain

# Create test page
sudo nano /var/www/my_sub_domain/html/index.html
<html>
    <head>
        <title>Welcome to my_sub_domain!</title>
    </head>
    <body>
        <h1>Success!  The my_sub_domain server block is working!</h1>
    </body>
</html>
# Ctrl+X, y, Enter

# Initialize domain config
sudo nano /etc/nginx/sites-available/my_sub_domain
server {
        listen 80;
        listen [::]:80;

        root /var/www/my_sub_domain/html;
        index index.html index.htm index.nginx-debian.html;

        server_name my_sub_domain www.my_sub_domain;

        location / {
                try_files $uri $uri/ =404;
        }
}
# Ctrl+X, y, Enter

# Manually do this
sudo nano /etc/nginx/nginx.conf
# Uncomment server_names_hash_bucket_size line to enable it

# Add to NGINX startup
sudo ln -s /etc/nginx/sites-available/my_sub_domain /etc/nginx/sites-enabled/
sudo nginx -t
sudo systemctl restart nginx