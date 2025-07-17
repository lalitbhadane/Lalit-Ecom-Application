# LALIT Ecommerce Services - Full Stack Deployment on Ubuntu (WSL)

This project automates the setup and deployment of a basic **Ecommerce Web Application** on **Ubuntu using WSL (Windows Subsystem for Linux)**.

It provisions:
- Apache Web Server
- PHP & MySQL Stack
- Sample Ecommerce Application
- Pre-populated Inventory Data

---

## 🛍️ Web Application Details

### ✅ **About the App**

The Ecommerce web application is a lightweight, PHP-based frontend that connects to a MySQL database to display a list of products. The app features:

- Display of multiple products with names, prices, and images
- Dynamic product listing fetched from a MySQL database
- Clean and minimal UI

### ✅ **Tech Stack**

| Layer         | Technology    |
| ------------- | ------------- |
| Web Server    | Apache2       |
| Frontend      | PHP           |
| Backend       | PHP & MySQL   |
| Database      | MySQL         |
| OS            | Ubuntu (via WSL2) |


---

## 📦 Prerequisites

Before running the deployment script:

- ✅ **Ubuntu OS in WSL2**
- ✅ Internet connection to download packages and clone GitHub repo (or you could just copy the script😜)
- ✅ User with `sudo` privileges on Ubuntu

---

## 🚀 How to Run the Project

### 1. Clone the Project Repository

git clone <https://github.com/lalitbhadane/Lalit-Ecom-Application.git>


### 2. Make the Deployment Script Executable

chmod +x deploy-ecom-wsl.sh

### 3. Run the Deployment Script

./deploy-ecom-wsl.sh

### 4. Verify Services
Ensure the services are running:

sudo service apache2 status
sudo service mysql status

### 5. Access the Web Application
Open your browser and visit:

http://localhost/web-app

### 📁 Project Structure

```
├── deploy-ecom-wsl.sh       # Main automation script
├── db-load.sql              # SQL script to populate database
├── web-app/                 # Cloned PHP ecommerce application
│     ├── index.php
│     └── (Other PHP files & assets)
└── README.md                # Project documentation
```


### ⚠️ Challenges Faced

#### 1. MySQL Root Authentication Issue on Ubuntu

By default, Ubuntu's MySQL installation configures root to authenticate via auth_socket.

We created a dedicated MySQL user ecomuser with a password for easier application access.

#### 2. PHP-MySQL Driver Missing

On a fresh Ubuntu setup, php-mysql isn't installed by default.

The script explicitly installs php-mysql to ensure PHP-MySQL connectivity.

#### 3. FirewallD Not Available in WSL

WSL does not include firewalld. Network configurations like port openings were unnecessary.

#### 4. File Permissions

Apache must have correct permissions to serve the app code. The script ensures this by cloning the app into /var/www/html/.

### ✅ Additional Notes:

#### MySQL Credentials:
User: ecomuser
Password: ecompassword
Database: ecomdb

#### To manually verify database entries:

mysql -u ecomuser -p
Enter password: ecompassword

USE ecomdb;
SELECT * FROM products;


#### To check PHP or Apache errors:
sudo tail -n 50 /var/log/apache2/error.log

#### To test the local application directly from CLI:

curl http://localhost/web-app

### ✅ Testing

#### After deployment:

The app should display a catalog of products like Laptop, Drone, VR, etc.

The script auto-tests the webpage using curl and verifies key product names.

Manual browser check can be done at:

[http://localhost/web-app](http://localhost/web-app)

### 🙌 Credits
#### Application Base: KodeKloud Learning App - Ecommerce

#### Deployment Automation & Documentation: LALIT BHADANE

