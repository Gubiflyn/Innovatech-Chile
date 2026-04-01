resource "aws_launch_template" "front_lt" {
  name_prefix   = "front-lt-"
  image_id      = data.aws_ami.ubuntu.id
  instance_type = var.instance_type
  key_name      = var.key_name


  vpc_security_group_ids = [aws_security_group.front_sg.id]

  user_data = base64encode(file("${path.module}/userdata/front.sh"))

  tag_specifications {
    resource_type = "instance"

    tags = {
      Name  = "front_lt"
      Layer = "frontend"
    }
  }
}

resource "aws_launch_template" "back_lt" {
  name_prefix   = "back-lt-"
  image_id      = data.aws_ami.ubuntu.id
  instance_type = var.instance_type
  key_name      = var.key_name


  vpc_security_group_ids = [aws_security_group.back_sg.id]

  user_data = base64encode(templatefile("${path.module}/userdata/back.sh", {
    db_host      = aws_instance.data.private_ip
    db_name      = var.db_name
    db_user      = var.db_user
    db_password  = var.db_password
    backend_port = 8080
  }))

  tag_specifications {
    resource_type = "instance"

    tags = {
      Name  = "back_lt"
      Layer = "backend"
    }
  }
}

resource "aws_launch_template" "data_lt" {
  name_prefix   = "data-lt-"
  image_id      = data.aws_ami.ubuntu.id
  instance_type = var.instance_type
  key_name      = var.key_name


  vpc_security_group_ids = [aws_security_group.data_sg.id]

  user_data = base64encode(templatefile("${path.module}/userdata/data.sh", {
    db_name     = var.db_name
    db_user     = var.db_user
    db_password = var.db_password
  }))

  tag_specifications {
    resource_type = "instance"

    tags = {
      Name  = "data_lt"
      Layer = "data"
    }
  }
}