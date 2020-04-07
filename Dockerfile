FROM alvisisme/ubuntu:18.04

RUN apt-get update \
  && DEBIAN_FRONTEND=noninteractive apt-get install -q -y --no-install-recommends \
    ca-certificates \
    net-tools \
    wget \
    unzip \
    curl \
    patch \
    supervisor \
  && rm -rf /var/lib/apt/lists/*

RUN echo "exit 0" > /usr/sbin/policy-rc.d

RUN apt-get update \
  && DEBIAN_FRONTEND=noninteractive apt-get install -q -y --no-install-recommends \
    nginx \
  && rm -rf /var/lib/apt/lists/*

RUN apt-get update \
  && DEBIAN_FRONTEND=noninteractive apt-get install -q -y --no-install-recommends \
    php7.2 \
    php7.2-fpm \
    php7.2-xml \
    php7.2-mbstring \
    php7.2-gd \
    php7.2-ldap \
    php7.2-curl \
    php7.2-json \
    php7.2-zip \
  && rm -rf /var/lib/apt/lists/*

# Add the user UID:1000, GID:1000, home at /app
# RUN groupadd -r app -g 1000 \
#     && useradd -u 1000 -r -g app -m -d /app -s /sbin/nologin -c "App user" app \
#     && chmod 755 /app

COPY default /etc/nginx/sites-available/default
COPY dokuwiki.conf /etc/supervisor/conf.d/dokuwiki.conf
COPY dokuwiki.tar.gz /dokuwiki.tar.gz
COPY setup.sh /setup.sh

# CMD ["/usr/bin/supervisord", "-n"]
CMD /etc/init.d/php7.2-fpm restart && nginx -g "daemon off;"
