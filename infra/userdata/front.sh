#!/bin/bash
set -e

exec > /var/log/front-userdata.log 2>&1

apt update -y
apt upgrade -y

apt install -y docker.io git nginx curl

systemctl enable docker
systemctl start docker

systemctl enable nginx
systemctl start nginx

cat > /var/www/html/index.html <<EOF
<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8">
  <title>${frontend_app_name}</title>
</head>
<body style="font-family: Arial, sans-serif; text-align:center; margin-top:60px;">
  <h1>${frontend_app_name}</h1>
  <p>Servidor Frontend desplegado en EC2 pública</p>
  <p>Docker, Git y Nginx instalados correctamente</p>
  <p>Arquitectura Lift & Shift - Innovatech</p>
</body>
</html>
EOF

systemctl restart nginx