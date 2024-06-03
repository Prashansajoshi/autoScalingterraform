#!/bin/bash

# Update package lists
sudo apt-get update -y

# Install NGINX
sudo apt-get install -y nginx

# Enable the default site by creating a symbolic link
rm -f /etc/nginx/sites-enabled/default
ln -s /etc/nginx/sites-available/default /etc/nginx/sites-enabled/

# Create a new NGINX configuration file for your site
echo "server {
    listen 80;
    server_name your_domain_or_IP;

    location / {
        root /var/www/html;
        index index.html;
    }
}" > /etc/nginx/sites-available/my_site

# Enable the new site
ln -s /etc/nginx/sites-available/my_site /etc/nginx/sites-enabled/

# Test the NGINX configuration for syntax errors
nginx -t

# Reload NGINX to apply the changes
sudo systemctl reload nginx

# Copy the index.html file to the web server's root directory
cp /path/to/your/index.html /var/www/html/

# Ensure the index.html file is served as the default document
ln -sf /var/www/html/index.html /var/www/html/index.html