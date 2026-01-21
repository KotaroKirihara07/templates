# シークレットを作成
resource "aws_secretsmanager_secret" "db_credential" {
  name = "${var.prefix}_posgres_credential"
  description = "postgreSQLのrootパスワード"

  tags = {
    Name = "${var.prefix}_posgres_credential"
  }
}


# 20桁のランダムなパスワードを生成する
data "aws_secretsmanager_random_password" "db_rnd_password" {
  password_length = 20
  exclude_numbers = false
  exclude_punctuation = true
}


# シークレットにユーザ名とパスワードを登録する
resource "aws_secretsmanager_secret_version" "db_credential_version" {
  secret_id = aws_secretsmanager_secret.db_credential.id
  secret_string = jsonencode({
    username = "admin"
    password = data.aws_secretsmanager_random_password.db_rnd_password.random_password
  })
}
