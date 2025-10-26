# Amazon Elastic Container Service
Amazon Elastic Container Serviceはフルマネージドなコンテナオーケストレータ。


## 用語
### タスク
タスクとは、1つ以上のコンテナから構成されるアプリケーションの実行単位。

### タスク定義
タスク定義とは、タスクを作成するテンプレート定義。

### サービス
指定した数だけタスクを維持するスケジューラ。起動タスク数、関連するロードバランサ、ネットワークなどを指定する。

### クラスター
サービスとタスクを実行する論理グループ

### データプレーン
コンテナが実際に稼働するリソース環境。Amazon ECSではAmazon EC2かAWS Fargateのいずれかを選択することができる。

### タスクロール  
タスク実行して起動したコンテナたちがAWSリソースにアクセスするための権限をまとめたロール。

### タスク実行ロール  
タスクを実行する際に必要な権限をまとめたロール。


## タスクとサービス
- タスク(スタンドアロンタスク) : 一度コンテナを立ち上げて実行した後、コンテナを停止する
- サービス : 任意の数のタスクを実行し続ける

### タスク(スタンドアロンタスク)
#### 作成すべきリソース
- ECR
- イメージ
- タスク定義
- タスク
- クラスター


### サービス
#### 作成すべきリソース
- ECR
- イメージ
- タスク定義
- タスク
- クラスター
- サービス


## Terraform上のリソース
- ECS cluster (クラスター)
- ECS cluster capacity providers
- container definitions (タスク定義)
- ECS service (サービス)



## コマンド
- イメージの作成  
<code>sudo docker image build -t image:tag . </code>

- コンテナイメージのタグ付け  
<code>sudo docker image tag image:tag 123456789012.dkr.ecr.ap-northeast-1.amazonaws.com/image:tag </code>

- ECRへのログイン  
<code>aws ecr --region ap-northeast-1 get-login-password | sudo docker login --username AWS --password-stdin https://123456789012.dkr.ecr.ap-northeast-1.amazonaws.com/image </code>

- ECRへイメージを登録する  
<code>sudo docker image push 123456789012.dkr.ecr.ap-northeast-1.amazonaws.com/image:tag </code>

- タスクの実行  
<code>aws ecs run-task --cluster "${CLUSTER_NAME}" --task-definition "${family:revision}" --launch-type "FARGATE" </code>
