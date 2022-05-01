# Generally assume .netstandard 3.1
# Notice the example put the server files in /home/my_sub_domain or /root/my_sub_domain instead of /var/www/my_sub_domain
# Replace "my_sub_domain" before execution

# Prepare folder for domain content
# Create folder as /var/www/my_sub_domain
# Upload published .net files to this folder
sudo chown -R $USER:$USER /var/www/my_sub_domain
sudo chmod -R 755 /var/www/my_sub_domain

# Update server conf to support SignalR for Blazor
sudo nano /etc/nginx/nginx.conf
http {
    # We can put this just before include /etc/nginx/conf.d/*.conf; and include /etc/nginx/sites-enabled/*;
    map $http_upgrade $connection_upgrade {
        default Upgrade;
        ''      close;
    }
}
# Initialize domain config
sudo nano /etc/nginx/sites-available/my_sub_domain
server {
    listen      80;
    listen [::]:80;

    # root /root/my_sub_domain;
    # index index.html index.htm index.nginx-debian.html;

    server_name my_sub_domain.com www.my_sub_domain.com *.my_sub_domain.com;

    # Route HTTP requests to Kestrel
    location / {
        proxy_pass         http://localhost:5000; # Need to manually adjust per server
        proxy_http_version 1.1;
        proxy_set_header   Upgrade $http_upgrade;
        proxy_set_header   Connection $connection_upgrade;
        proxy_set_header   Host $host;
        proxy_cache_bypass $http_upgrade;
        proxy_set_header   X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header   X-Forwarded-Proto $scheme;
        # try_files $uri $uri/ =404;
    }
}
# Ctrl+X, y, Enter

# Add to NGINX startup
sudo ln -s /etc/nginx/sites-available/my_sub_domain /etc/nginx/sites-enabled/
sudo nginx -t

# Test
cd /root/my_sub_domain
chmod u+x MyBlazorApp.dll && dotnet MyBlazorApp.dll
sudo systemctl restart nginx
# Now you should be able to navigate to my_sub_domain.com to see the result

# Configure ASP.Net Core Blazor App (notice we don't need to use --urls=http://0.0.0.0:80 to listen on 0.0.0.0 and can just use localhost)
# Create a system service
sudo nano /etc/systemd/system/my_sub_domain.service

# REMOVE ALL COMMENTS TO AVOID PARSING ERRORS
#region CONTENT
[Unit]
Description=My New Net Core Application

[Service]
WorkingDirectory=/root/my_sub_domain
ExecStart=/usr/bin/dotnet /root/my_sub_domain/MyBlazorApp.dll --urls=http://0.0.0.0:5000 # Port should match NGINX site config; Use localhost for safety # Notice HTTPS redirection is handled automatically, likely by NGINX
Restart=always
RestartSec=10 # Restart service after 10 seconds if dotnet service crashes
KillSignal=SIGINT	# Optional
User=root 			# Optional
SyslogIdentifier=my_sub_domain # This is the identification for the app in system log, which is available using `systemctl status service_file_name.service` command
    # To see detailed logs: journalctl -u service-name.service
    # Also check out /var/log/syslog
Environment=ASPNETCORE_ENVIRONMENT=Production
Environment=DOTNET_PRINT_TELEMETRY_MESSAGE=false	# Optional; Actually this line looks conflict from above line - maybe there is a way to put the two together?

[Install]
WantedBy=multi-user.target
#endregion CONTENT

# Enable Blazor service and reload NGINX service
systemctl enable my_sub_domain.service && systemctl start my_sub_domain.service && systemctl status my_sub_domain.service
sudo systemctl restart nginx

# Perform SSL Encrypt
certbot --nginx