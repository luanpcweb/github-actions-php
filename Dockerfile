FROM php:7.4.3-fpm

WORKDIR /app

RUN apt-get update && apt-get install -y git libzip-dev && apt-get clean

COPY composer.json .
COPY composer.phar .

RUN docker-php-ext-install zip pdo_mysql
RUN mv "$PHP_INI_DIR/php.ini-production" "$PHP_INI_DIR/php.ini"
#RUN echo "extension=zip.so" >> "$PHP_INI_DIR/php.ini"
RUN ./composer.phar install --prefer-dist --no-scripts --no-autoloader
COPY . .

RUN ./composer.phar dump-autoload --no-scripts --optimize

VOLUME ["/app/vendor"]
