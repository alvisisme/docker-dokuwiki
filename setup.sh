#!/bin/bash

if [ ! -d /var/www/html/dokuwiki ];then
    mv /dokuwiki /var/www/html/dokuwiki
fi

chown -R www-data /var/www/html

if [ `ps -ef | grep apache2 | grep -v apache2 | wc -l` -eq 0 ];then
    apache2ctl -D FOREGROUND
else
    tail -f /var/log/apache2/error.log
fi

