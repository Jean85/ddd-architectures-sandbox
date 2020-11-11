FROM php:7.4.12-fpm-alpine3.12

LABEL maintainer="alessandro.lai@facile.it"

# workaround for https://github.com/docker-library/php/issues/240
RUN apk add --no-cache --repository http://dl-cdn.alpinelinux.org/alpine/edge/community/ gnu-libiconv
ENV LD_PRELOAD /usr/lib/preloadable_libiconv.so php

RUN apk --no-cache add \
        git \
        icu-dev \
        libzip-dev \
        netcat-openbsd \
        sudo \
        vim \
        zsh
RUN apk add --no-cache --virtual .ext-build-deps $PHPIZE_DEPS
 ## PHP-EXT
RUN pecl install -o \
        apcu \
        pcov \
        xdebug
RUN docker-php-ext-enable \
        apcu \
        pcov
RUN docker-php-ext-install -j5 \
        intl \
        opcache \
        pcntl \
        pdo_mysql \
        zip \
    && php -m

COPY xdebug.ini /usr/local/etc/php/conf.d/xdebug.ini

WORKDIR /var/www/ddd-architectures-sandbox

 ## Utente non-root (no sudo)
RUN adduser -D -u 1000 ddd-dev -G www-data \
    && mkdir -p /home/ddd-dev \
    && chown -R ddd-dev /home/ddd-dev \
    && chown -R ddd-dev /var/www/ddd-architectures-sandbox \
 ## Composer and accounts
    && curl -sS https://getcomposer.org/installer | php -- \
        --install-dir=/usr/local/bin \
        --version=2.0.6 \
        --filename=composer
USER ddd-dev
RUN composer config -g github-oauth.github.com e46e9d616a32cd27dbb7c6f626b625c61071c5c2

 ## ZSH / OhMyZsh
COPY --chown=ddd-dev:www-data zsh/install-zsh.sh /home/ddd-dev/install-zsh.sh
#RUN chmod +x /home/ddd-dev/install-zsh.sh \
#    && /home/ddd-dev/install-zsh.sh
#COPY zsh/zsh-config.sh /home/ddd-dev/.zshrc
#ENV TERM xterm-256color
