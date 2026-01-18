# Docker
- Dockerfileからイメージを作成する  
<code>docker image build -t repository/image:tag . </code>

- イメージをレジストリへ保存する  
<code>docker image push repository/image:tag </code>

- イメージからコンテナを作成する  
<code>docker run -d -p 3000:3000 repository/image:tag </code>

- 稼働中のコンテナのid一覧を取得する  
<code>docker ps -q </code>

- 稼働中のコンテナを停止する  
<code>docker stop container_id </code>

- コンテナを削除する  
<code>docker rm container_id </code>


# Compose
- アプリケーションを起動する  
<code>docker-compose up -d </code>

- アプリケーションを停止する  
<code>docker-compose stop </code>

- アプリケーションを再起動する (yamlファイルの変更後に実行)  
<code>docker-compose build </code>

- アプリケーションを削除する  
<code>docker-compose rm </code>

