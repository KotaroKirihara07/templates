# アカウントID (${data.aws_caller_identity.self.account_id})
data "aws_caller_identity" "self" {}


#リージョン (${data.aws_region.current.name})
data "aws_region" "current" {}


# ロール (for EC2)
resource "aws_iam_role" "ec2_excute_role" {
  name = "${var.prefix}_ec2_excute_role"
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
}


# ポリシー (for EC2)
resource "aws_iam_policy" "ec2_policy_rds_s3" {
  name        = "${var.prefix}-ec2-policy-rds-s3"
  description = "Policy for EC2"
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Action = [
        "rds:*",
        "s3:*"
      ]
      Resource = "*"
    }]
  })
}


# ロールへポリシーをアタッチ (カスタムポリシー)
resource "aws_iam_role_policy_attachment" "ec2_role_policy_attach_1" {
  role       = aws_iam_role.ec2_excute_role.name
  policy_arn = aws_iam_policy.ec2_policy_rds_s3.arn
}


# ロールへポリシーをアタッチ (AWS管理ポリシー AmazonSSMManagedInstanceCore)
resource "aws_iam_role_policy_attachment" "ec2_role_policy_attach_2" {
  role       = aws_iam_role.ec2_excute_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}


# ロール (for user_name)
resource "aws_iam_role" "user_role" {
  name = "${var.prefix}_user_role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          AWS = ["arn:aws:iam::${data.aws_caller_identity.self.account_id}:user/${var.user_name}"]
        }
      },
    ]
  })
}


# ポリシー (for user_name)
resource "aws_iam_policy" "user_policy_rds_s3" {
  name        = "${var.prefix}-user-policy-rds-s3"
  description = "Policy for EC2"
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Action = [
        "rds:*",
        "s3:*"
      ]
      Resource = "*"
    }]
  })
}


# ロールへポリシーをアタッチ
resource "aws_iam_role_policy_attachment" "user_role_policy_attach" {
  role       = aws_iam_role.user_role.name
  policy_arn = aws_iam_policy.user_policy_rds_s3.arn
}