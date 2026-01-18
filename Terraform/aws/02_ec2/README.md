# Amazon Elastic Compute Cloud
AWSが提供するクラウド上の仮想サーバーサービス。


## 作成するリソース
|リソース|名前|備考|
|---|---| ---| 
|VPC|${var.prefix}_vpc|---|
|パブリックサブネット|${var.prefix}_public_subnet|---|
|Internet Gateway|${var.prefix}_internet_gateway|---|
|EC2インスタンス|${var.prefix}_ec2instance|---|
|セキュリティグループ|${var.prefix}_sg_ec2|EC2インスタンスにアタッチするSG|
|SG egressルール|${var.prefix}_egress_rule|アウトバウンドトラフィックを許可する|
|ロール|${var.prefix}_ec2_excute_role|EC2にアタッチするロール|


## アーキテクチャ構成図