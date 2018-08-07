FROM alpine:3.7

ENV WEBAPP_ROOT=www
ENV LD_PRELOAD /usr/lib/preloadable_libiconv.so

# Install gnu-libconv required by php7-iconv
RUN apk add --no-cache --repository http://dl-cdn.alpinelinux.org/alpine/edge/testing gnu-libiconv

# Setup apache and php
RUN apk --update add apache2 php7-apache2 curl \
    php7-json php7-phar php7-openssl php7-mysqli php7-curl php7-mcrypt php7-pdo_mysql php7-ctype php7-gd php7-xml php7-dom php7-iconv \
    && rm -f /var/cache/apk/* \
    && mkdir /run/apache2 \
    && mkdir -p /opt/utils  

EXPOSE 80 443
RUN mkdir -p /app/www
RUN ln -sfn /usr/bin/php7 /usr/bin/php
ADD start.sh /opt/utils/

RUN chmod +x /opt/utils/start.sh

ENTRYPOINT ["/opt/utils/start.sh"]