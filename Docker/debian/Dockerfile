FROM debian:latest

RUN apt-get update
RUN ln -sf /usr/share/zoneinfo/Asia/Tokyo /etc/localtime
RUN groupadd -r test_group && useradd -r -g test_group test_user


COPY entrypoint.sh /

USER test_user
ENTRYPOINT ["/entrypoint.sh"]