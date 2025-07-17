#!/bin/bash

#set -e  # Stop if any command fails

echo " Starting eCommerce App Deployment on Ubuntu WSL"

# Update packages
#echo " Updating system..."
sudo apt update && sudo apt upgrade -y

# Install Apache, PHP, MySQL
echo " Installing Apache, PHP, and MySQL..."
sudo apt install -y apache2 php libapache2-mod-php php-mysql mysql-server git curl

# Start services
echo "Starting Apache and MySQL..."
sudo service apache2 start
sudo service mysql start

# Secure MySQL (optional: you can script mysql_secure_installation but it's messy)
echo " Securing MySQL and setting up database..."

# MySQL root user on Ubuntu defaults to auth_socket, so use sudo
DB_NAME="ecomdb"
DB_USER="ecomuser"
DB_PASS="ecompassword"

sudo mysql -e "CREATE DATABASE IF NOT EXISTS $DB_NAME;"
sudo mysql -e "CREATE USER IF NOT EXISTS '$DB_USER'@'localhost' IDENTIFIED BY '$DB_PASS';"
sudo mysql -e "GRANT ALL PRIVILEGES ON *.* TO '$DB_USER'@'localhost';"
sudo mysql -e "FLUSH PRIVILEGES;"

echo " Database and user created."

# Load sample data
echo " Loading sample data into $DB_NAME..."
cat > db-load.sql <<EOF
USE $DB_NAME;
CREATE TABLE IF NOT EXISTS products (
    id INT AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(255),
    Price VARCHAR(255),
    ImageUrl VARCHAR(255)
);

INSERT INTO products (Name,Price,ImageUrl) VALUES
("Laptop","100","c-1.png"),
("Drone","200","c-2.png"),
("VR","300","c-3.png"),
("Tablet","50","c-5.png"),
("Watch","90","c-6.png"),
("Phone Covers","20","c-7.png"),
("Phone","80","c-8.png"),
("Laptop","150","c-4.png");
EOF

sudo mysql < db-load.sql

echo " Sample data loaded."

# Clone the app code
APP_DIR="/var/www/html/web-app"
echo " Cloning app code into $APP_DIR..."
sudo git clone https://github.com/lalitbhadane/Lalit-Ecom-Application.git $APP_DIR

# Configure database connection
echo " Configuring app to connect to MySQL..."

sudo sed -i 's#// \(.*mysqli_connect.*\)#\1#' $APP_DIR/index.php
sudo sed -i 's#172.20.1.101#localhost#g' $APP_DIR/index.php

echo " App configured."

# Restart Apache just in case
sudo service apache2 restart

echo " Testing the web app locally..."
curl http://localhost | grep -q "Laptop" && echo " Deployment successful, 'Laptop' found on page!" || echo " Deployment may have issues."

echo " All done! Your eCommerce app is deployed on http://localhost"
