#!/bin/bash

# Wait for MariaDB to be ready
until php -r "new mysqli('${DB_HOST}', '${ADM_USER}', '${ADM_PASS}', '${DB_NAME}');" > /dev/null 2>&1; do
  echo "Waiting for database connection..."
  sleep 5
done

cd /var/www/html

if [ ! -f wp-config.php ]; then
    wp config create --dbname=${DB_NAME} --dbuser=${ADM_USER} --dbpass=${ADM_PASS} --dbhost=${DB_HOST} --allow-root
fi

# Force HTTPS
wp option update home "https://${DOMAIN}" --allow-root
wp option update siteurl "https://${DOMAIN}" --allow-root

# Configure Wordpress
wp core install --url="https://${DOMAIN}" --title="${TITLE}" --admin_user="${ADM_USER}" --admin_password="${ADM_PASS}" --admin_email="${ADM_MAIL}" --skip-email --allow-root || true

# Create normal user
wp user create ${NORMAL_USER} ${NORMAL_EMAIL} --role=author --user_pass=${NORMAL_PASS} --allow-root || true

#if [ ! -f wp-config.php ]; then
#wp config create --dbase=${DB_NAME} --dbuser=${ADM_USER} --dbpass=${ADM_PASS} --dbhost=${DB_HOST} --allow-root
#fi

#wp core install --url="${DOMAIN}" --title="${TITLE}" --admin_user="${ADM_USER}" --admin_password="${ADM_PASS}" --admin_email="${ADM_MAIL}" --skip-email --allow-root || true

#wp user create ${NORMAL_USER} ${NORMAL_EMAIL} --role=author --user_pass=${NORMAL_PASS} --allow-root || true

#wp theme install https://downloads.wordpress.org/theme/blocksy.2.0.16.zip --activate --allow-root || true

#mkdir -p /run/php 

#/usr/sbin/php-fpm7.3 -F