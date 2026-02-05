# AWS Lambda
サーバーの管理なしでコードを実行できるAWSのサーバーレスコンピューティングサービス。


## Python Lambda 関数 (コンテナイメージ)
### 作成しておくリソース
|リソース|名前|備考|
|---|---| ---| 
|ECR||コンテナイメージをプッシュするためのリポジトリ|
||||
||||


### コンテナイメージの作成手順
1. 「lambda_python」ディレクトリを作成する
2. 「lambda_python」ディレクトリに移動する
3. 「lambda_function.py」を作成する
4. 「requirements.txt」を作成する
5. 「Dockerfile」を作成する

参考資料: https://docs.aws.amazon.com/ja_jp/lambda/latest/dg/python-image.html


### 作成するリソース
|リソース|名前|備考|
|---|---| ---| 
|Lambda関数|${var.prefix}_${var.function_name}||
||||
||||


### アーキテクチャ構成図


## Python Lambda 関数 (ZIPファイルアーカイブ on S3)
### 作成しておくリソース
|リソース|名前|備考|
|---|---| ---| 
|S3|||
||||
||||


### 作成するリソース
|リソース|名前|備考|
|---|---| ---| 
|Lambda関数|${var.prefix}_${var.function_name}|---|
|cloudwatch log group|/aws/lambda/${var.prefix}_${var.function_name}|---|
||||


### アーキテクチャ構成図


## Python Lambda 関数 (ZIPファイルアーカイブ on ローカル)
### 作成しておくリソース
|リソース|名前|備考|
|---|---| ---| 
|ロール|Lambda-ExecutionRole|Lambda関数の実行ロール|
|フォルダ|lambda|srcフォルダとuploadフォルダを配置するフォルダ|
|フォルダ|src|main.pyを配置するフォルダ|
|フォルダ|upload|ZIPファイルアーカイブが出力されるフォルダ|
|ファイル|main.py|関数の内容を記述したpyファイル|


### 作成するリソース
|リソース|名前|備考|
|---|---| ---| 
|Lambda関数|${var.prefix}_${var.function_name}|---|
|cloudwatch log group|/aws/lambda/${var.prefix}_${var.function_name}|---|
||||


### アーキテクチャ構成図


## 