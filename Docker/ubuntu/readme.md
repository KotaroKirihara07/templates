#イメージのbuild
docker build .

#コンテナの起動
docker run -d -p 8080:80 myimage