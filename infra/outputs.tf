output "vpc_id" {
  description = "ID de la VPC principal"
  value       = aws_vpc.main.id
}

output "public_subnet_id" {
  description = "ID de la subred pública"
  value       = aws_subnet.public.id
}

output "private_subnet_id" {
  description = "ID de la subred privada"
  value       = aws_subnet.private.id
}

output "front_instance_id" {
  description = "ID de la instancia Front"
  value       = aws_instance.front.id
}

output "back_instance_id" {
  description = "ID de la instancia Back"
  value       = aws_instance.back.id
}

output "data_instance_id" {
  description = "ID de la instancia Data"
  value       = aws_instance.data.id
}

output "front_public_ip" {
  description = "IP pública del Frontend"
  value       = aws_instance.front.public_ip
}

output "front_public_dns" {
  description = "DNS público del Frontend"
  value       = aws_instance.front.public_dns
}

output "back_private_ip" {
  description = "IP privada del Backend"
  value       = aws_instance.back.private_ip
}

output "data_private_ip" {
  description = "IP privada de la Base de Datos"
  value       = aws_instance.data.private_ip
}

output "frontend_url" {
  description = "URL de acceso al frontend"
  value       = "http://${aws_instance.front.public_ip}"
}

output "backend_private_url" {
  description = "URL privada del backend"
  value       = "http://${aws_instance.back.private_ip}:${var.backend_port}"
}