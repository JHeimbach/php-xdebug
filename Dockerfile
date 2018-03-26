ARG CONTAINER_VERSION=latest
FROM jheimbach/php-basic:${CONTAINER_VERSION}
ARG XDEBUG_INI=./xdebug.ini
ARG XDEBUG_CONF_FILE=$PHP_INI_DIR/conf.d/xdebug.ini

RUN pecl install xdebug
RUN docker-php-ext-enable xdebug

COPY ${XDEBUG_INI} $XDEBUG_CONF_FILE

COPY xdebug_local_settings /usr/local/bin/

ENV XDEBUG_CONF_FILE=$XDEBUG_CONF_FILE \
    XDEBUG_IDE_KEY="PHPSTORM" \
    XDEBUG_DEFAULT_ENABLE="On" \
    XDEBUG_CLI_ENABLE="Off" \
    XDEBUG_REMOTE_ENABLE="On" \
    XDEBUG_REMOTE_CONNECT_BACK="Off" \
    XDEBUG_REMOTE_AUTOSTART="On"\
    XDEBUG_REMOTE_LOG="\/proc\/self\/fd\/2"

RUN xdebug_local_settings