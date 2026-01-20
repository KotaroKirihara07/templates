# Amazon VPC (Virtual Private Cloud) 
AWSクラウド上に構築される論理的に分離された専用の仮想ネットワーク空間。


## 作成するリソース
|リソース|名前|備考|
|---|---| ---| 
|VPC|${var.prefix}_vpc|---|
|パブリックサブネット|${var.prefix}_public_subnet|---|
|Internet Gateway|${var.prefix}_internet_gateway|---|
|EIP|${var.prefix}_eip|NAT Gatewayに紐づけるグローバルIPアドレス|
|NAT Gateway|${var.prefix}_nat_gateway|---|
|ルーティングテーブル|${var.prefix}_public_subnet_route_table|パブリックサブネット用のルーティングテーブル|
|プライベートサブネット|${var.prefix}_private_subnet|---|
|ルーティングテーブル|${var.prefix}_private_subnet_route_table|プライベートサブネット用のルーティングテーブル|


## アーキテクチャ構成図
![vpc](../99_images/01_vpc.svg)


## 