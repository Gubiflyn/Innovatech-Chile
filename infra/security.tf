resource "aws_security_group" "front_sg" {
  name        = "orlando_front_sg"
  description = "Security Group para la capa Frontend"
  vpc_id      = aws_vpc.main.id

  ingress {
    description = "HTTP desde Internet"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "SSH solo desde mi IP"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.my_ip_cidr]
  }

  egress {
    description = "Salida total"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "orlando_front_sg"
    Layer = "frontend"
  }
}

resource "aws_security_group" "back_sg" {
  name        = "orlando_back_sg"
  description = "Security Group para la capa Backend"
  vpc_id      = aws_vpc.main.id

  ingress {
    description     = "API desde Front"
    from_port       = 8080
    to_port         = 8080
    protocol        = "tcp"
    security_groups = [aws_security_group.front_sg.id]
  }

  ingress {
    description = "SSH solo desde mi IP"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.my_ip_cidr]
  }

  egress {
    description = "Salida total"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "orlando_back_sg"
    Layer = "backend"
  }
}

resource "aws_security_group" "data_sg" {
  name        = "orlando_data_sg"
  description = "Security Group para la capa Data"
  vpc_id      = aws_vpc.main.id

  ingress {
    description     = "MySQL desde Back"
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    security_groups = [aws_security_group.back_sg.id]
  }

  ingress {
    description = "SSH solo desde mi IP"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.my_ip_cidr]
  }

  egress {
    description = "Salida total"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "orlando_data_sg"
    Layer = "data"
  }
}