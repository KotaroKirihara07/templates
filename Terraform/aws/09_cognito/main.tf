# ユーザプール
resource "aws_cognito_user_pool" "cognito_user_pool" {
  name = "${var.prefix}_cognito_user_pool"

  password_policy {
    minimum_length                   = 12    # 最小の長さ
    require_lowercase                = true # 英小文字
    require_numbers                  = true # 数字
    require_symbols                  = true # 記号
    require_uppercase                = true # 英大文字
    temporary_password_validity_days = 7 # 初期登録時の一時的なパスワードの有効期限
  }
}

# ユーザ
resource "aws_cognito_user" "example" {
  user_pool_id = aws_cognito_user_pool.cognito_user_pool.id
  username     = "example_user"
}