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
	net-tools \
        wget \
        unzip \
        curl \
        patch \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Add the user UID:1000, GID:1000, home at /app
# RUN groupadd -r app -g 1000 \
#     && useradd -u 1000 -r -g app -m -d /app -s /sbin/nologin -c "App user" app \
#     && chmod 755 /app

RUN sed -i "s/\/var\/www\/html/\/var\/www\/html\/dokuwiki/g" /etc/apache2/sites-available/000-default.conf && \
    sed -i "s/\/var\/www\/html/\/var\/www\/html\/dokuwiki/g" /etc/apache2/sites-available/default-ssl.conf

COPY apache2.conf /etc/apache2/apache2.conf
COPY dokuwiki dokuwiki 
COPY setup.sh setup.sh

EXPOSE 80
VOLUME [ "/var/www/html" ]
CMD [ "/bin/bash", "/setup.sh" ]
