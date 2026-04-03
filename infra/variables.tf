variable "project_name" {
  type    = string
  default = "innovatech"
}

variable "vpc_cidr" {
  type    = string
  default = "10.0.0.0/16"
}

variable "public_subnet_cidr" {
  type    = string
  default = "10.0.1.0/24"
}

variable "private_subnet_cidr" {
  type    = string
  default = "10.0.2.0/24"
}

variable "instance_type" {
  type    = string
  default = "t2.micro"
}

variable "key_name" {
  type = string
}

variable "my_ip_cidr" {
  type        = string
  description = "Tu IP publica en formato CIDR, por ejemplo 181.10.10.10/32"
}

variable "db_name" {
  type    = string
  default = "innovatechdb"
}

variable "db_user" {
  type    = string
  default = "adminuser"
}

variable "db_password" {
  type      = string
  sensitive = true
}



variable "frontend_app_name" {
  type        = string
  description = "Nombre visible del frontend"
  default     = "Innovatech Frontend"
}

variable "backend_port" {
  type        = number
  description = "Puerto del backend"
  default     = 8080
}

variable "aws_region" {
  type        = string
  description = "Región AWS"
  default     = "us-east-1"
}