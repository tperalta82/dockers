FROM debian:jessie

Maintainer Tiago Peralta


RUN apt-get update \
    && apt-get install -y curl sendmail \
    && echo "deb http://packages.dotdeb.org jessie all" > /etc/apt/sources.list.d/dotdeb.list \
    && echo "deb-src http://packages.dotdeb.org jessie all" >> /etc/apt/sources.list.d/dotdeb.list \
	&& sed -i "s/deb http:\/\/httpredir.debian.org\/debian jessie main/deb http:\/\/httpredir.debian.org\/debian jessie main contrib non-free/g" /etc/apt/sources.list \
	&& sed -i "s/deb http:\/\/httpredir.debian.org\/debian jessie-updates main/deb http:\/\/httpredir.debian.org\/debian jessie-updates main contrib non-free/g" /etc/apt/sources.list \
	&& sed -i "s/deb http:\/\/security.debian.org jessie\/updates main/deb http:\/\/security.debian.org jessie\/updates main contrib non-free/g" /etc/apt/sources.list \
    && echo "deb-src http://httpredir.debian.org/debian jessie main contrib non-free" >> /etc/apt/sources.list \
	&& echo "deb-src http://httpredir.debian.org/debian jessie-updates main contrib non-free" >> /etc/apt/sources.list \
    && curl -sS https://www.dotdeb.org/dotdeb.gpg | apt-key add - \
    && apt-get update \
    && apt-cache search ^php7.0- | awk {'printf $1 " "'} | sed 's\php7.0-phpdbg\\g'| sed 's\php7.0-dbg\\g' | sed 's\php7.0-xdebug\\g' | xargs apt-get --no-install-recommends -y install \
	&& rm -rf /etc/php/7.0/mods-available \
	&& ln -sf /etc/php/mods-available /etc/php/7.0/mods-available \
	&& apt-get -y install git-core snmp-mibs-downloader make deborphan \
	&& cd /root/ \
	&& git clone https://github.com/php/pecl-database-mysql     mysql   --recursive \
	&& cd mysql \
	&& phpize \
	&& ./configure \
	&& make install \
	&& echo "extension=mysql.so" > /etc/php/mods-available/mysqlnd_mysql.ini \
	&& phpenmod -v ALL -s ALL mysqlnd_mysql \
	&& cd /root/ \
	&& git clone https://github.com/php/pecl-text-ereg.git \
	&& cd pecl-text-ereg \
	&& phpize \
	&& ./configure \
	&& make install \
	&& echo "extension=ereg.so" > /etc/php/mods-available/ereg.ini \
	&& phpenmod -v ALL -s ALL ereg \
    && apt-get clean \
	&& apt-get -y --purge remove  make automake git git-core git-man \
	&& deborphan | xargs apt-get -y --purge remove \
	&& deborphan --guess-dev | xargs apt-get -y --purge remove \
	&& apt-get -y --purge remove deborphan \
	&& apt-get -y --purge autoremove \
	&& rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /usr/share/doc/* /root/* \
  && mkdir -p /var/www \
  && chown www-data:www-data /var/www


RUN sed -i "/listen = .*/c\listen = [::]:9000" /etc/php/7.0/fpm/pool.d/www.conf \
    && sed -i "/;access.log = .*/c\access.log = /proc/self/fd/2" /etc/php/7.0/fpm/pool.d/www.conf \
    && sed -i "/;clear_env = .*/c\clear_env = no" /etc/php/7.0/fpm/pool.d/www.conf \
    && sed -i "/;catch_workers_output = .*/c\catch_workers_output = yes" /etc/php/7.0/fpm/pool.d/www.conf \
    && sed -i "/pid = .*/c\;pid = /run/php/php7.0-fpm.pid" /etc/php/7.0/fpm/php-fpm.conf \
    && sed -i "/;daemonize = .*/c\daemonize = no" /etc/php/7.0/fpm/php-fpm.conf \
    && sed -i "/error_log = .*/c\error_log = /proc/self/fd/2" /etc/php/7.0/fpm/php-fpm.conf \
    && usermod -u 1000 www-data

EXPOSE 9000
CMD ["/usr/sbin/php-fpm7.0"]
