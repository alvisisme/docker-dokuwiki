#!/bin/sh

if [ -f /var/www/wiki/index.php ]; then
  chown -R www-data /var/www/wiki
  apache2ctl -f /etc/apache2/apache2.conf -e info -X
else
  echo "Can not find wiki folder"
fi