# Amazon RDS（Relational Database Service）
AWSが提供するクラウド上でリレーショナルデータベースを簡単に構築・運用・スケールできるマネージドサービス。


## 作成するリソース
|リソース|名前|備考|
|---|---| ---| 
|VPC|${var.prefix}_vpc|---|
|プライベートサブネット|${var.prefix}_private_subnet|---|
|RDS||
|||
|||
|セキュリティグループ|${var.prefix}_sg_ec2|EC2インスタンスにアタッチするSG|
|SG egressルール|${var.prefix}_egress_rule|アウトバウンドトラフィックを許可する|
|ロール|${var.prefix}_ec2_excute_role|EC2にアタッチするロール|



## アーキテクチャ構成図