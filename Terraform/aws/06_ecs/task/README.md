# Amazon Elastic Container Service
Amazon Elastic Container Serviceはフルマネージドなコンテナオーケストレータ。


## 用語
|用語|説明|
|---|---| 
|タスク|1つ以上のコンテナから構成されるアプリケーションの実行単位|
|タスク定義|タスクを作成するテンプレート定義|
|サービス|指定した数だけタスクを維持するスケジューラ|
|クラスター|サービスとタスクを実行する論理グループ|
|データプレーン|コンテナが実際に稼働するリソース環境 (EC2/Fargate)|
|タスクロール|タスク実行して起動したコンテナがAWSリソースにアクセスするための権限をまとめたロール|
|タスク実行ロール|タスクを実行する際に必要な権限をまとめたロール|


## Amazon ECR Public Gallery
[https://gallery.ecr.aws/](https://gallery.ecr.aws/)


## タスクとサービスの違い
- タスク(スタンドアロンタスク) : 一度コンテナを立ち上げて実行した後、コンテナを停止する
- サービス : 任意の数のタスクを実行し続ける


## タスク
### あらかじめ作成しておくべきリソース
|リソース|名前|備考|
|---|---| ---| 
|ロール|AmazonECSTaskRole|タスクロール|
|ロール|AmazonECSTaskExecutionRole|タスク実行ロール|
|イメージ|public.ecr.aws/docker/library/hello-world:latest|イメージ|


### 作成するリソース
|リソース|名前|備考|
|---|---| ---| 
|VPC|${var.prefix}_vpc|---|
|パブリックサブネット|${var.prefix}_public_subnet|---|
|Internet Gateway|${var.prefix}_internet_gateway|---|
|ルーティングテーブル|${var.prefix}_public_subnet_route_table|---|
|セキュリティグループ|${var.prefix}_sg_ecs|---|
|ECSクラスター|${var.prefix}_ecs_cluster|---|
|タスク定義|${var.prefix}_ecs_task_definition|hello-worldを実行するタスク|
|CloudWatch Log group|${var.prefix}_esc_task_log_group|---|
|★|||


### アーキテクチャ構成図
![ecs_task](../99_images/06_ecs_task.svg)


### コマンド
#### タスクの実行 : `aws ecs run-task --cli-input-json file://runtask_params.json`



## サービス
### あらかじめ作成しておくべきリソース
|リソース|名前|備考|
|---|---| ---| 
|ロール|AmazonECSTaskRole|タスクロール|
|ロール|AmazonECSTaskExecutionRole|タスク実行ロール|
|ロール|AmazonECSServiceRole|ECSサービス実行ロール|
|イメージ|public.ecr.aws/docker/library/httpd:latest|Apache HTTP Server イメージ|


### 作成するリソース
|リソース|名前|備考|
|---|---| ---| 
|VPC|${var.prefix}_vpc|---|
|パブリックサブネット|${var.prefix}_public_subnet|---|
|Internet Gateway|${var.prefix}_internet_gateway|---|
|ルーティングテーブル|${var.prefix}_public_subnet_route_table|---|
|ECSクラスター|${var.prefix}_ecs_cluster|---|
|ECSサービス|???|---|
|タスク定義|${var.prefix}_ecs_task_definition|---|
|CloudWatch Log group|${var.prefix}_esc_task_log_group|---|
|セキュリティグループ|||
|ALB|||


### アーキテクチャ構成図



## コマンド
#イメージの作成  
<code>docker image build -t image:tag . </code>

#コンテナイメージのタグ付け  
<code>docker image tag image:tag 123456789012.dkr.ecr.ap-northeast-1.amazonaws.com/image:tag </code>

#ECRへのログイン  
<code>aws ecr --region ap-northeast-1 get-login-password | docker login --username AWS --password-stdin https://123456789012.dkr.ecr.ap-northeast-1.amazonaws.com/image </code>

#ECRへイメージを登録する  
<code>docker image push 123456789012.dkr.ecr.ap-northeast-1.amazonaws.com/image:tag </code>

#必要なパラメータの調査   
<code>aws ecs run-task --generate-cli-skeleton</code>

#タスクの実行   
<code>aws ecs run-task --cli-input-json file://runtask_params.json</code>

##
