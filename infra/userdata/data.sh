#!/bin/bash
set -e

exec > /var/log/data-userdata.log 2>&1

export DEBIAN_FRONTEND=noninteractive

apt update -y
apt upgrade -y

apt install -y docker.io git mysql-server

systemctl enable docker
systemctl start docker

systemctl enable mysql
systemctl start mysql

mysql -e "CREATE DATABASE IF NOT EXISTS ${db_name};"

mysql -e "CREATE USER IF NOT EXISTS '${db_user}'@'%' IDENTIFIED BY '${db_password}';"

mysql -e "GRANT ALL PRIVILEGES ON ${db_name}.* TO '${db_user}'@'%';"

mysql -e "FLUSH PRIVILEGES;"

sed -i 's/127.0.0.1/0.0.0.0/g' /etc/mysql/mysql.conf.d/mysqld.cnf

systemctl restart mysql

mysql -e "USE ${db_name}; CREATE TABLE IF NOT EXISTS planes (id INT AUTO_INCREMENT PRIMARY KEY, nombre VARCHAR(100));"

mysql -e "USE ${db_name}; INSERT INTO planes (nombre) VALUES ('Plan Básico'), ('Plan Premium'), ('Plan Corporativo');"