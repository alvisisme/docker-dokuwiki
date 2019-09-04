#!/bin/bash

set -e

ls -al /var/www/html/
if [ ! -d /var/www/html/dokuwiki ];then
    mv /dokuwiki /var/www/html/dokuwiki
fi
   
chown -R www-data /var/www/html 
apachectl -D FOREGROUND
