# AWS IAM (Identity and Access Management) 
AWSのサービスやリソースへのアクセスを安全に制御するためのサービス。


## 作成するリソース
|リソース|名前|備考|
|---|---| ---| 
|ロール|${var.prefix}_ec2_excute_rol|EC2にアタッチするロール|
|カスタムポリシー|${var.prefix}-ec2-policy-rds-s3|上記ロールにアタッチするRDSとS3に対する操作権限を記述したポリシー|
|ロール|${var.prefix}_user_role|ユーザにアタッチするロール|
|カスタムポリシー|${var.prefix}-user-policy-rds-s3|上記ロールにアタッチするRDSとS3に対する操作権限を記述したポリシー|
|★|||


##