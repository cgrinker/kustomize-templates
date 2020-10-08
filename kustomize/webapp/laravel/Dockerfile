FROM debian:10-slim
RUN apt-get update && apt-get install -y nodejs npm unzip nginx php-pear php7.3-curl \
    php7.3-dev php7.3-gd php7.3-mbstring php7.3-zip php7.3-mysql php7.3-xml php7.3-fpm \
    php7.3-imagick php7.3-recode php7.3-tidy php7.3-xmlrpc php7.3-intl php-redis php-xdebug git ssh
RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
RUN php composer-setup.php --install-dir=/usr/local/bin --filename=composer
ADD nginx.conf /etc/nginx/sites-enabled/default
RUN mkdir -p /run/php
RUN composer global require laravel/installer
RUN sed -e 's/;clear_env = no/clear_env = no/' -i /etc/php/7.3/fpm/pool.d/www.conf
WORKDIR /usr/share/nginx/html/

ADD ./entry.sh /bin/entry.sh
CMD /bin/entry.sh

