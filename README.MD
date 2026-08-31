# ParaPHP

Docker container for PHP & NGINX with Paradise extensions.

Inside the `Dockerfile` is a line to install the extensions. It adds:

- `php85-pdo`
- `php85-pgsql`
- `php85-pdo_pgsql`
- `php85-pdo_mysql`
- `php85-sodium`
- `php85-zip`
- `php85-simplexml`
- `php85-iconv`
- `php85-sockets`

There are also lines to debug the list of extensions with the supplied `list_extensions.php` script. You can run it with the following command:

```sh
docker build -t test-php . && docker run --rm -p 8080:8080 test-php
```
