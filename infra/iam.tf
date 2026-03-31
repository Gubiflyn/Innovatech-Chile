resource "aws_iam_role" "ec2_ssm_role" {
  name = "orlando_ec2_ssm_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })

  tags = {
    Name = "orlando_ec2_ssm_role"
  }
}

resource "aws_iam_role_policy_attachment" "ssm_core_policy" {
  role       = aws_iam_role.ec2_ssm_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

resource "aws_iam_instance_profile" "ec2_ssm_profile" {
  name = "orlando_ec2_ssm_profile"
  role = aws_iam_role.ec2_ssm_role.name

  tags = {
    Name = "orlando_ec2_ssm_profile"
  }
}