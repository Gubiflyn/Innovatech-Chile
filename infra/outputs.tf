output "vpc_id" {
  value = aws_vpc.main.id
}

output "public_subnet_id" {
  value = aws_subnet.public_subnet.id
}

output "private_subnet_id" {
  value = aws_subnet.private_subnet.id
}

output "front_public_ip" {
  value = aws_instance.front.public_ip
}

output "front_public_dns" {
  value = aws_instance.front.public_dns
}

output "back_private_ip" {
  value = aws_instance.back.private_ip
}

output "data_private_ip" {
  value = aws_instance.data.private_ip
}