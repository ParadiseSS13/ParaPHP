# ParaPHP

Docker container for PHP & NGINX with Paradise extensions.

This dockerfile takes base PHP-FPM, adds nginx and supervisord Inside the `Dockerfile` is a line to install the extensions. It adds:

- gd
- intl
- mysqli
- pdo
- pdo_mysql
- pdo_pgsql
- pgsql
- sockets
- zip

From there it adds supervisord, nginx, and cron to allow this to be an all in one container.

Why cron? Because some webapps like forums like to run cron scripts to manage things.

There are also lines to debug the list of extensions with the supplied `list_extensions.php` script. You can run it with the following command:

```sh
docker build -t test-php . && docker run --rm -p 8080:8080 test-php
```
