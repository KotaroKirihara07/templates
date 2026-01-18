#ユーザにアタッチするロール
resource "aws_iam_role" "test_user_role" {
  name = "${var.prefix}_test_user_role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          "AWS": "arn:aws:iam::123456789012:user/user_name"
        }
      },
    ]
  })

  tags = {
    Name = "${var.prefix}_test_user_role"
  }
}


#ポリシー (カスタマー管理)
resource "aws_iam_policy" "customer_policy" {
  name        = "${var.prefix}_customer_policy"
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "ec2:Describe*",
        ]
        Effect   = "Allow"
        Resource = "*"
      },
    ]
  })
}


#サービスにアタッチするロール
resource "aws_iam_role" "test_service_role" {
  name = "${var.prefix}_test_service_role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })

  tags = {
    Name = "${var.prefix}_test_service_role"
  }
}


#ロールへのポリシーのアタッチ (AWS管理ポリシー)
resource "aws_iam_role_policy_attachment" "test_attach" {
  role       = aws_iam_role.test_user_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryFullAccess"
}


#ロールへのポリシーのアタッチ (カスタマー管理ポリシー)
resource "aws_iam_role_policy_attachment" "test_customer_attach" {
  role       = aws_iam_role.test_service_role.name
  policy_arn = aws_iam_policy.customer_policy.arn
}