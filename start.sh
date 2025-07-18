#!/bin/bash

cd /app && composer install

/etc/init.d/php8.4-fpm start
/etc/init.d/nginx start

tail -f /var/log/nginx/access.log