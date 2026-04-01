data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"]

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

resource "aws_instance" "front" {
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = var.instance_type
  subnet_id              = aws_subnet.public_subnet.id
  vpc_security_group_ids = [aws_security_group.front_sg.id]
  key_name               = var.key_name
  user_data              = file("${path.module}/userdata/front.sh")

  tags = {
    Name  = "front_ec2"
    Layer = "frontend"
  }
}

resource "aws_instance" "data" {
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = var.instance_type
  subnet_id              = aws_subnet.private_subnet.id
  vpc_security_group_ids = [aws_security_group.data_sg.id]
  key_name               = var.key_name

  user_data = templatefile("${path.module}/userdata/data.sh", {
    db_name     = var.db_name
    db_user     = var.db_user
    db_password = var.db_password
  })

  tags = {
    Name  = "data_ec2"
    Layer = "data"
  }
}

resource "aws_instance" "back" {
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = var.instance_type
  subnet_id              = aws_subnet.private_subnet.id
  vpc_security_group_ids = [aws_security_group.back_sg.id]
  key_name               = var.key_name

  user_data = templatefile("${path.module}/userdata/back.sh", {
    db_host      = aws_instance.data.private_ip
    db_name      = var.db_name
    db_user      = var.db_user
    db_password  = var.db_password
    backend_port = 8080
  })

  tags = {
    Name  = "back_ec2"
    Layer = "backend"
  }
}