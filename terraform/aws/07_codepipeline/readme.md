# Amazon CodePipeline
AWSが提供する継続的インテグレーション(CI)および継続的デリバリー(CD)サービス。


## 作成するファイル
|ファイル名|説明|
|---|---| 
|Dockerfile||
|buildspec.yml||
|||
|||


## あらかじめ作成しておくリソース
|リソース|名前|備考|
|---|---| ---| 
|Amazon S3||
|Amazon ECR||


## 作成するリソース
|リソース|名前|備考|
|---|---| ---| 
|AWS CodePipeline||
|AWS CodeBuild||
|AWS CodeBuild||
|AWS CodeDeploy||



## アーキテクチャ構成図


## コマンド

#ビルドの実行  
<code>aws codebuild start-build --project-name <project-name></code>  

#必要なパラメータの調査  
<code>aws codebuild start-build --generate-cli-skeleton</code>

#既存のプロジェクトの設定値を上書きしてビルド  
<code>aws codebuild start-build --cli-input-json file://startbuild_params.json</code>