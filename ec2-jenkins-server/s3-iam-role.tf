resource "aws_iam_role" "s3-jenkins-role" {
  name = "s3-jenkins_role"
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
}

resource "aws_iam_role_policy_attachment" "s3-jenkins-s3-access" {
  policy_arn = var.policy_arn
  role       = aws_iam_role.s3-jenkins-role.name
}