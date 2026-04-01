#!/bin/bash
apt update -y
apt upgrade -y
apt install -y docker.io git openjdk-21-jdk

systemctl enable docker
systemctl start docker

mkdir -p /opt/backend

cat > /opt/backend/application.properties <<EOF
spring.datasource.url=jdbc:mysql://${db_host}:3306/${db_name}
spring.datasource.username=${db_user}
spring.datasource.password=${db_password}
server.port=${backend_port}
EOF