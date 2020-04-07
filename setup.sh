#!/bin/bash

if [ ! -f /var/www/dokuwiki/index.php ];then
    tar xzf /dokuwiki.tar.gz -C /var/www/dokuwiki .
fi

chown -R www-data:www-data /var/www/dokuwiki
