FROM ubuntu:latest

RUN apt-get update 
RUN ln -sf /usr/share/zoneinfo/Asia/Tokyo /etc/localtime

WORKDIR /workspace
RUN mkdir volume

#ボリュームマウント(ホストの/var/lib/docker/volumes/に実体がある)
VOLUME name:/volume
#バインドマウント (ホストのパス/コンテナのパス)
VOLUME ./volume:/volume

#ホストのfromディレクトリの中身をコンテナのtoディレクトリにコピー
COPY from /to

#ポート番号の指定 (ホストのポート番号/コンテナのポート番号)
EXPOSE 3000 3000