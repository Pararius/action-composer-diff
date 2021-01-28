FROM composer:2

ENV COMPOSER_BIN_DIR=/usr/local/bin
RUN composer require davidrjonas/composer-lock-diff

WORKDIR /github/workspace

COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
