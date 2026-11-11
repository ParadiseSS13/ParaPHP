FROM php:8.5.12-fpm-alpine3.23

# Elevate to install stuff
USER root

# Install deps
RUN apk add --no-cache zlib-dev libpng-dev icu-dev libpq-dev linux-headers libzip-dev

# Install extensions we need
RUN docker-php-ext-install -j"$(nproc)" \
    gd \
    intl \
    mysqli \
    pdo \
    pdo_mysql \
    pdo_pgsql \
    pgsql \
    sockets \
    zip

# Uncomment the below 2 lines to debug extensions
#COPY dbg/phpinfo.php /var/www/html/index.php
#COPY dbg/list_extensions.php /var/www/html/exts.php

# Install nginx
RUN apk add nginx curl supervisor

# Copy stuff over supervisord
COPY src/default.conf /etc/nginx/conf.d/default.conf
COPY src/fpm-pool.conf /usr/local/etc/php-fpm.d/www.conf
COPY src/nginx.conf /etc/nginx/nginx.conf
COPY src/supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# Allow 'nobody' access
RUN chown -R nobody:nobody /var/www/html /run /var/lib/nginx /var/log/nginx

# No more root
USER nobody

# Hint at the nginx port
EXPOSE 8080

# Start stuff up
CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/conf.d/supervisord.conf"]

# Healthcheck to validate stuff
HEALTHCHECK --timeout=10s CMD curl --silent --fail http://127.0.0.1:8080/fpm-ping || exit 1