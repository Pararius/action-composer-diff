FROM composer:2
RUN apk add --no-cache jq curl

ENV COMPOSER_BIN_DIR=/usr/local/bin
RUN composer require davidrjonas/composer-lock-diff

COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
