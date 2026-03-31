resource "aws_launch_template" "front_lt" {
  name_prefix   = "${var.project_name}-front-lt-"
  image_id      = var.ami_id
  instance_type = var.instance_type
  key_name      = var.key_name

  vpc_security_group_ids = [aws_security_group.front_sg.id]

  iam_instance_profile {
    name = aws_iam_instance_profile.ssm_profile.name
  }

  user_data = base64encode(templatefile("${path.module}/userdata/front.sh", {
    frontend_app_name = var.frontend_app_name
  }))

  tag_specifications {
    resource_type = "instance"

    tags = {
      Name    = "${var.project_name}-front"
      Project = var.project_name
      Tier    = "frontend"
    }
  }
}

resource "aws_launch_template" "back_lt" {
  name_prefix   = "${var.project_name}-back-lt-"
  image_id      = var.ami_id
  instance_type = var.instance_type
  key_name      = var.key_name

  vpc_security_group_ids = [aws_security_group.back_sg.id]

  iam_instance_profile {
    name = aws_iam_instance_profile.ssm_profile.name
  }

  user_data = base64encode(templatefile("${path.module}/userdata/back.sh", {
    backend_port = var.backend_port
    db_name      = var.db_name
    db_user      = var.db_user
    db_password  = var.db_password
  }))

  tag_specifications {
    resource_type = "instance"

    tags = {
      Name    = "${var.project_name}-back"
      Project = var.project_name
      Tier    = "backend"
    }
  }
}

resource "aws_launch_template" "data_lt" {
  name_prefix   = "${var.project_name}-data-lt-"
  image_id      = var.ami_id
  instance_type = var.instance_type
  key_name      = var.key_name

  vpc_security_group_ids = [aws_security_group.data_sg.id]

  iam_instance_profile {
    name = aws_iam_instance_profile.ssm_profile.name
  }

  user_data = base64encode(templatefile("${path.module}/userdata/data.sh", {
    db_name     = var.db_name
    db_user     = var.db_user
    db_password = var.db_password
  }))

  tag_specifications {
    resource_type = "instance"

    tags = {
      Name    = "${var.project_name}-data"
      Project = var.project_name
      Tier    = "database"
    }
  }
}