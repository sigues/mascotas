#!/bin/bash

php_config_file="/etc/php5/apache2/php.ini"
xdebug_config_file="/etc/php5/mods-available/xdebug.ini"
mysql_config_file="/etc/mysql/my.cnf"

IPADDR=$(/sbin/ifconfig eth0 | awk '/inet / { print $2 }' | sed 's/addr://')
sed -i "s/^${IPADDR}.*//" hosts
echo $IPADDR ubuntu.localhost >> /etc/hosts # Just to quiet down some error messages
# Update the server
apt-get update
#apt-get -y upgrade
# Install basic tools
apt-get -y install build-essential binutils-doc git
# Install Apache
apt-get -y install apache2
apt-get -y install php5 php5-curl php5-mysql php5-sqlite php5-xdebug php5-mcrypt curl
sed -i "s/display_startup_errors = Off/display_startup_errors = On/g" ${php_config_file}
sed -i "s/display_errors = Off/display_errors = On/g" ${php_config_file}
echo "xdebug.remote_enable=On" >> ${xdebug_config_file}
echo 'xdebug.remote_connect_back=On' >> ${xdebug_config_file}
# Install MySQL
echo "mysql-server mysql-server/root_password password root" | sudo debconf-set-selections
echo "mysql-server mysql-server/root_password_again password root" | sudo debconf-set-selections
apt-get -y install mysql-client mysql-server
sed -i "s/bind-address\s*=\s*127.0.0.1/bind-address = 0.0.0.0/" ${mysql_config_file}
# Allow root access from any host
echo "GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY 'root' WITH GRANT OPTION" | mysql -u root --password=root
echo "GRANT PROXY ON ''@'' TO 'root'@'%' WITH GRANT OPTION" | mysql -u root --password=root

echo "CREATE DATABASE mascotas" | mysql -u root --password=root
# Restart Services

APP_DB_USER=mascotas
APP_DB_PASS=m45c0t45
# Edit the following to change the name of the database that is created (defaults to the user name)
APP_DB_NAME=$APP_DB_USER
PG_VERSION=9.3
# echo "sudo apt-get install postgresql postgresql-contrib"
# echo "apt-get install php5-pgsql"


# Add PG apt repo:
echo "deb http://apt.postgresql.org/pub/repos/apt/ precise-pgdg main" > "$PG_REPO_APT_SOURCE"
# Add PGDG repo key:
echo "wget --quiet -O - http://apt.postgresql.org/pub/repos/apt/ACCC4CF8.asc | apt-key add -"

# Update package list and upgrade all packages
echo "apt-get -y install postgresql postgresql-contrib php5-pgsql"

# Edit postgresql.conf to change listen address to '*':
echo "sed -i \"s/#listen_addresses = 'localhost'/listen_addresses = '*'/\" \"/etc/postgresql/9.3/main/postgresql.conf\""
# Append to pg_hba.conf to add password auth:
echo "host all all all md5" >> "/etc/postgresql/9.3/main/pg_hba.conf"
# Restart so that all new config is loaded:
echo "service postgresql restart"
echo "cat << EOF | su - postgres -c psql
-- Create the database user:
CREATE USER mascotas WITH PASSWORD 'm45c0t45';
-- Create the database:
CREATE DATABASE mascotas WITH OWNER mascotas;
EOF"
# Tag the provision time:
echo "Successfully created PostgreSQL dev virtual machine."

php5enmod mcrypt

# Add ServerName to httpd.conf
echo "ServerName localhost" > /etc/apache2/httpd.conf
# Setup hosts file
VHOST=$(cat <<EOF
<VirtualHost *:80>
	DocumentRoot "/vagrant/public"
	ServerName localhost
	<Directory "/vagrant/public">
		AllowOverride All
		Require all granted
	</Directory>
</VirtualHost>
EOF
)
echo "${VHOST}" > /etc/apache2/sites-enabled/000-default.conf
# Enable mod_rewrite
a2enmod rewrite
# Restart apache
service apache2 restart

# Remove /var/www default
rm -rf /var/www/html
# Symlink /vagrant to /var/www
ln -fs /vagrant /var/www/html

#installing composer

curl -sS https://getcomposer.org/installer | php
mv composer.phar /usr/local/bin/composer

#installing composer to project
cd /vagrant

composer install

#installing migrations for database
php artisan migrate

#seeding database
php artisan db:seed

#restart servers

service apache2 restart
service mysql restart

#running
