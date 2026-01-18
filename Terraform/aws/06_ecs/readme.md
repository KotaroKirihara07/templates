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


## タスクとサービスの違い
- タスク(スタンドアロンタスク) : 一度コンテナを立ち上げて実行した後、コンテナを停止する
- サービス : 任意の数のタスクを実行し続ける


## タスク
### 作成するリソース
|リソース|名前|概要|
|---|---| ---| 
|VPC|vpc|---|
|パブリックサブネット|???|???|
|ECSクラスター|???|???|
|タスク定義|???|???|


### アーキテクチャ構成図



## サービス
### 作成するリソース
|リソース|名前|概要|
|---|---| ---| 
|VPC|vpc-???|-|
|パブリックサブネット|???|???|
|ECSクラスター|???|???|
|ECSサービス|???|???|
|タスク定義|???|???|


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
