FROM debian:jessie

Maintainer Tiago Peralta <tperalta82@gmail.com>

ENv REV_BACKEND_IP 1.2.3.4
ENV REV_BACKEND_PORT 80
ENV PGSPEED_ENABLED ON

ADD src/deb/waffle.deb /root/waffle.deb

RUN apt-get update \
    && apt-get -y dist-upgrade \
    && apt-get -y install libssl1.0.0 \
    && dpkg -i /root/waffle.deb \
    && ln -sf /opt/openresty/nginx/logs /var/log/openresty \
    && apt-get clean \
    && apt-get autoclean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /usr/share/doc/* /root/*

ADD src/conf/nginx.conf /opt/openresty/nginx/conf/nginx.conf

EXPOSE 80
CMD ["/opt/openresty/nginx/sbin/nginx"]
