FROM debian:jessie

MAINTAINER Tiago Peralta "tperalta82@gmail.com"

ENV NGINX_VERSION 1.11.3-2-pagespeed~jessie

RUN apt-key adv --keyserver keys.gnupg.net --recv 39100E53 \
	&& echo "deb https://s3-eu-west-1.amazonaws.com/jessie-aspt-repo stable main" >> /etc/apt/sources.list \
	&& apt-get update \
	&& apt-get install --no-install-recommends --no-install-suggests -y \
						ca-certificates \
						nginx=${NGINX_VERSION} \
						nginx-module-xslt \
						nginx-module-geoip \
						nginx-module-image-filter \
						nginx-module-pagespeed \
						nginx-module-perl \
						nginx-module-njs \
						gettext-base \
	&& rm -rf /var/lib/apt/lists/*

# forward request and error logs to docker log collector
RUN ln -sf /dev/stdout /var/log/nginx/access.log \
	&& ln -sf /dev/stderr /var/log/nginx/error.log

EXPOSE 80 443

CMD ["nginx", "-g", "daemon off;"]
