# Amazon CodePipeline
AWSが提供する継続的インテグレーション(CI)および継続的デリバリー(CD)サービス。

## Dockerイメージ ビルド パイプライン
### 作成するファイル
|ファイル名|説明|
|---|---| 
|Dockerfile||
|buildspec.yml||


### あらかじめ作成しておくリソース
|リソース|名前|備考|
|---|---| ---| 
|S3|codepipeline-ap-noratheast-1-012345678912|codepipilineのアーティファクトバケット|
|ロール|CodeCommit-ExecutionRole|codebuildの実行ロール|


### 作成するリソース
|リソース|名前|備考|
|---|---| ---| 
|ECR|${var.prefix}_ecr_repository||
|CodeCommit|${var.prefix}_codecommit_repository||
|CodeBuild|${var.prefix}_codebuild_project||
|CloudWatch Loggroup|${var.prefix}_codebuild_project_log_group||
|CodePipeline|${var.prefix}_codepipeline||
|サービスロール|AWSCodePipelineServiceRole-ap-northeast-1-${var.prefix}_codepipeline|CodePipelineの実行ロール|



### アーキテクチャ構成図


##


## Lambda関数作成パイプライン
### 作成するファイル
|ファイル名|説明|
|---|---| 
|Dockerfile||
|buildspec.yml||


### あらかじめ作成しておくリソース
|リソース|名前|備考|
|---|---| ---| 
|Amazon S3|||


### 作成するリソース
|リソース|名前|備考|
|---|---| ---| 
|Amazon ECR|${var.prefix}_ecr_repository||
|AWS CodePipeline|||
|AWS CodeBuild|||
|AWS CodeBuild|||
|AWS CodeDeploy|||



### アーキテクチャ構成図


## コマンド

#ビルドの実行  
`aws codebuild start-build --project-name <project-name>`  

#必要なパラメータの調査  
`aws codebuild start-build --generate-cli-skeleton`

#既存のプロジェクトの設定値を上書きしてビルド  
`aws codebuild start-build --cli-input-json file://startbuild_params.json`


##