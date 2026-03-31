#!/bin/bash
set -e

exec > /var/log/back-userdata.log 2>&1

apt update -y
apt upgrade -y

apt install -y docker.io git curl python3

systemctl enable docker
systemctl start docker

mkdir -p /opt/backend

cat > /opt/backend/app.py <<EOF
from http.server import BaseHTTPRequestHandler, HTTPServer
import json

class Handler(BaseHTTPRequestHandler):
    def do_GET(self):
        if self.path == "/" or self.path == "/health":
            self.send_response(200)
            self.send_header("Content-type", "application/json")
            self.end_headers()
            self.wfile.write(json.dumps({
                "status": "ok",
                "service": "backend",
                "port": ${backend_port}
            }).encode())

        elif self.path == "/api/planes":
            self.send_response(200)
            self.send_header("Content-type", "application/json")
            self.end_headers()
            self.wfile.write(json.dumps([
                {"id": 1, "nombre": "Plan Básico"},
                {"id": 2, "nombre": "Plan Premium"},
                {"id": 3, "nombre": "Plan Corporativo"}
            ]).encode())

        else:
            self.send_response(404)
            self.end_headers()

httpd = HTTPServer(("0.0.0.0", ${backend_port}), Handler)
print("Backend activo en puerto ${backend_port}")
httpd.serve_forever()
EOF

cat > /etc/systemd/system/backend.service <<EOF
[Unit]
Description=Backend Demo Service
After=network.target

[Service]
ExecStart=/usr/bin/python3 /opt/backend/app.py
Restart=always
User=root

[Install]
WantedBy=multi-user.target
EOF

systemctl daemon-reload
systemctl enable backend.service
systemctl start backend.service