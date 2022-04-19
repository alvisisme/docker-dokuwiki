FROM ubuntu:18.04

ARG APT_CHINA_MIRROR
RUN if [ -n "$APT_CHINA_MIRROR" ]; then sed -i -E "s/(archive|security).ubuntu.com/mirrors.aliyun.com/g" /etc/apt/sources.list; fi

RUN apt-get update \
  && DEBIAN_FRONTEND=noninteractive apt-get install -q -y --no-install-recommends \
    ca-certificates \
    net-tools \
    wget \
    unzip \
    curl \
    patch \
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

# forward request and error logs to docker log collector
RUN ln -sf /dev/stdout /var/log/nginx/access.log \
    && ln -sf /dev/stderr /var/log/nginx/error.log
STOPSIGNAL SIGTERM

CMD /etc/init.d/php7.2-fpm restart && nginx -g "daemon off;"
