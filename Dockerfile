FROM alvisisme/ubuntu:16.04
LABEL maintainer="Alvis Zhao<alvisisme@163.com>"

RUN apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y \
        apache2 \
        php7.0 \
        libapache2-mod-php7.0 \
        php7.0-xml \
        php-mcrypt \
        php-mbstring \
        php-gd \
        ca-certificates \
        wget \
        unzip \
        curl \
        patch \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Install php Composer Globally
# See https://getcomposer.org/download/ and https://getcomposer.org/doc/00-intro.md#system-requirements
RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" \
    && php -r "if (hash_file('sha384', 'composer-setup.php') === '48e3236262b34d30969dca3c37281b3b4bbe3221bda826ac6a9a62d6444cdb0dcd0615698a5cbe587c3f0fe57a54d8f5') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;" \
    && php composer-setup.php --install-dir=/usr/local/bin --filename=composer \
    && php -r "unlink('composer-setup.php');"

# Add the user UID:1000, GID:1000, home at /app
# RUN groupadd -r app -g 1000 \
#     && useradd -u 1000 -r -g app -m -d /app -s /sbin/nologin -c "App user" app \
#     && chmod 755 /app

COPY ci_setup.sh ci_setup.sh
COPY patch patch
COPY config config
COPY pages pages
RUN /bin/bash ci_setup.sh

COPY apache2.conf /etc/apache2/apache2.conf
EXPOSE 80
VOLUME [ "/var/www/html" ]
CMD [ "tail", "-f", "/var/log/apache2/error.log" ]
