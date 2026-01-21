# AWS Secrets Manager
データベースの認証情報、APIキー、OAuthトークンなどの機密情報を安全に保管・管理・取得・ローテーションできるAWSのマネージドサービス。


## 作成するリソース
|リソース|名前|備考|
|---|---| ---| 
|Secrets Manager|${var.prefix}_posgres_credential|PostgreSQLの認証情報


##