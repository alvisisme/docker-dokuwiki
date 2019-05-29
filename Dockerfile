FROM alvisisme/ubuntu:16.04
LABEL maintainer="Alvis Zhao<alvisisme@163.com>"

RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y \
    apache2  php7.0 \
    libapache2-mod-php7.0 php7.0-xml php-mcrypt php-mbstring php-gd && \
    apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

COPY 000-default.conf /etc/apache2/sites-available/000-default.conf
COPY apache2.conf /etc/apache2/apache2.conf
COPY start.sh /start.sh
RUN chmod a+x /start.sh
EXPOSE 80
VOLUME [ "/var/www/wiki" ]
CMD [ "/bin/sh", "/start.sh" ]