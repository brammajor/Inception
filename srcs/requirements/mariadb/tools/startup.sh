#!/bin/bash

service mysql start

while ! mysqladmin ping --silent; do
    sleep 1
done
sleep 1

echo "CREATE DATABASE IF NOT EXISTS ${DB_NAME} ;" > db.sql
echo "CREATE USER IF NOT EXISTS '${ADM_USER}'@'%' IDENTIFIED BY '${ADM_PASS}' ;" >> db.sql
echo "GRANT ALL PRIVILEGES ON ${DB_NAME}.* TO '${ADM_USER}'@'%' ;" >> db.sql
echo "ALTER USER 'root '@' localhost' IDENTIFIED BY '${ROOT_PASS} ;" >> db.sql
echo "FLUSH PRIVILEGES ;" >> db.sql

mysql < db.sql

kill $(cat /var/run/mysqld/mysqld.pid)

mysqld