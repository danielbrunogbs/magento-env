from ubuntu:latest

WORKDIR /app

RUN apt-get update && \
       apt-get install -y --no-install-recommends \
           software-properties-common \
           curl \
           gnupg \
           lsb-release && \
       rm -rf /var/lib/apt/lists/*

RUN add-apt-repository -y ppa:ondrej/php

RUN apt-get install -y \
    php8.4 \
    php8.4-xml \
    php8.4-mbstring \
    php8.4-zip \
    php8.4-pdo \
    php8.4-bcmath \
    php8.4-curl \
    php8.4-gd \
    php8.4-intl \
    php8.4-soap \
    php8.4-mysql \
    php8.4-fpm \
    php8.4-cgi

RUN apt-get install -y nginx

COPY nginx-magento-site /etc/nginx/sites-enabled/

COPY start.sh /start.sh
RUN chmod +x /start.sh

COPY /magento2 /app

RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
RUN php -r "if (hash_file('sha384', 'composer-setup.php') === 'dac665fdc30fdd8ec78b38b9800061b4150413ff2e3b6f88543c636f7cd84f6db9189d43a81e5503cda447da73c7e5b6') { echo 'Installer verified'.PHP_EOL; } else { echo 'Installer corrupt'.PHP_EOL; unlink('composer-setup.php'); exit(1); }"
RUN php composer-setup.php
RUN php -r "unlink('composer-setup.php');"

RUN mv composer.phar /usr/local/bin/composer

CMD [ "/./start.sh" ]