FROM centos:8

RUN dnf update -y \
	&& dnf install -y http://rpms.remirepo.net/enterprise/remi-release-8.rpm \
	&& dnf install -y epel-release dnf-plugins-core dnf-utils \
	&& dnf module install -y php:remi-7.3 \
	&& dnf install -y php-cli php-fpm php-mysql php-zip php-gd php-mcrypt php-mbstring php-curl \
		php-xml php-pear php-bcmath php-json php-imagick php-intl \
		supervisor crontabs curl zip unzip mysql \
		$ADDITIONAL_PACKAGES \
	&& curl https://getcomposer.org/installer -sS | php -- --filename=composer --install-dir=/usr/local/bin

COPY php.ini /tmp/php.ini
COPY fpm.conf /tmp/fpm.conf
COPY crontab.conf /tmp/app_crontab

RUN cat /tmp/php.ini >>/etc/php.ini \
	&& cat /tmp/fpm.conf >> /etc/php-fpm.conf \
	&& sed -i 's/listen = 127.0.0.1:9000/listen = 0.0.0.0:9000/' /etc/php-fpm.d/www.conf \
	&& sed -i 's/listen.allowed_clients/;listen.allowed_clients/' /etc/php-fpm.d/www.conf \
	&& mkdir /run/php-fpm \
	&& /tmp/app_crontab | crontab

COPY supervisord.conf /etc/supervisord.conf

EXPOSE 9000

CMD ["/usr/bin/supervisord", "-n"]
