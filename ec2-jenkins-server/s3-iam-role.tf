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

resource "aws_iam_policy" "s3-jenkins-rw-policy" {
  name   = "s3-jenkins-rw-policy"
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "S3ReadWriteAccess",
      "Effect": "Allow",
      "Action": [
        "s3:GetObject",
        "s3:PutObject",
        "s3:ListBucket"
      ],
      "Resource": [
        "arn:aws:s3:::${var.bucket}",
        "arn:aws:s3:::${var.bucket}/*"
      ]
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "s3-jenkins-s3-access" {
  policy_arn = aws_iam_policy.s3-jenkins-rw-policy.arn
  role       = aws_iam_role.s3-jenkins-role.name
}

resource "aws_iam_instance_profile" "s3-jenkins-profile" {
  name = "s3-jenkins-profile"
  role = aws_iam_role.s3-jenkins-role.name
}