FROM php:7.3.6-alpine

ENV PHINX_VER=0.10.8
ENV PATH ${PATH}:/vendor/bin
ENV COMPOSER_SETUP_CHECKSUM=48e3236262b34d30969dca3c37281b3b4bbe3221bda826ac6a9a62d6444cdb0dcd0615698a5cbe587c3f0fe57a54d8f5

RUN \
    apk add --no-cache postgresql-dev \
 && docker-php-ext-install pdo pdo_pgsql \
 && wget https://getcomposer.org/installer -O composer-setup.php \
 && php -r "if (hash_file('sha384', 'composer-setup.php') === getenv('COMPOSER_SETUP_CHECKSUM')) { exit(0); } else { exit(1); }" \
 && php composer-setup.php \
 && php composer.phar require robmorgan/phinx:${PHINX_VER} \
 && rm -f composer* \
 && :

