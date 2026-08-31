FROM trafex/php-nginx:3.11.1

# Elevate to install stuff
USER root

# Install extensions we need
RUN apk add --no-cache \
    php85-pdo \
    php85-pgsql \
    php85-pdo_pgsql \
    php85-pdo_mysql \
    php85-sodium \
    php85-zip \
    php85-simplexml \
    php85-iconv \
    php85-sockets

# Uncomment the below 2 lines to debug extensions
#COPY list_extensions.php /list_extensions.php
#ENTRYPOINT ["php", "/list_extensions.php"]

# Uncomment the below 2 lines for production use
USER nobody
ENTRYPOINT ["/usr/bin/supervisord", "-c", "/etc/supervisor/conf.d/supervisord.conf"]