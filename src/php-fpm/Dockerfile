FROM debian:buster-slim

RUN apt-get update;\
    apt-get upgrade -y
RUN apt-get install -y --no-install-recommends \
		php7.3-fpm php-mysql php-zip php-gd \
        php-mbstring php-curl php-xml php-pear php-bcmath php-json php-imagick php-intl\
		curl composer zip unzip default-mysql-client\
		$ADDITIONAL_PACKAGES

# todo: add php-mcrypt

COPY php.ini /tmp/php.ini
RUN cat /tmp/php.ini >>/etc/php/7.3/cli/php.ini
RUN cat /tmp/php.ini >>/etc/php/7.3/fpm/php.ini

RUN sed -i 's/listen\s*=/;listen =/' /etc/php/7.3/fpm/pool.d/www.conf

COPY fpm.conf /tmp/fpm.conf
RUN cat /tmp/fpm.conf >> /etc/php/7.3/fpm/pool.d/www.conf

RUN mkdir -p /run/php/

STOPSIGNAL SIGQUIT

EXPOSE 9000

CMD ["php-fpm7.3", "--nodaemonize"]
