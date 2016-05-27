FROM debian:jessie

Maintainer Tiago Peralta <tperalta82@gmail.com>

ENv REV_BACKEND_IP 1.2.3.4
ENV REV_BACKEND_PORT 80
ENV PGSPEED_ENABLED on

ADD src/deb/waffle.deb /root/waffle.deb
ADD entrypoint.sh /sbin/entrypoint.sh

RUN apt-get update \
    && apt-get -y dist-upgrade \
    && apt-get -y install libssl1.0.0 \
    && dpkg -i /root/waffle.deb \
    && mkdir /var/log/openresty \
    && rm -rf /opt/openresty/nginx/logs \
    && ln -sf /var/log/openresty /opt/openresty/nginx/logs \
    && chmod +x /sbin/entrypoint.sh \
    && apt-get clean \
    && apt-get autoclean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /usr/share/doc/* /root/*

ADD src/conf/nginx.conf /opt/openresty/nginx/conf/nginx.conf

EXPOSE 80
CMD ["/sbin/entrypoint.sh"]
