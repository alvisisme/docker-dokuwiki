#!/bin/bash

DOKUWIKI_VERSION="release_stable_2018-04-22b"

#
# 下载安装包
#
if [ ! -f $DOKUWIKI_VERSION.tar.gz ]; then
echo "Downloading dokuwiki version $DOKUWIKI_VERSION"
wget https://github.com/splitbrain/dokuwiki/archive/$DOKUWIKI_VERSION.tar.gz
fi

#
# 解压安装包
#
if [ ! -d dokuwiki ]; then
echo "Extracting dokuwiki package to dokuwiki"
tar zxf $DOKUWIKI_VERSION.tar.gz
mv dokuwiki-$DOKUWIKI_VERSION dokuwiki
fi

#
# 删除不必要的多语言支持文件，仅保留中文和英文
#
for dir in `ls dokuwiki/inc/lang`
do
    if [ $dir = "en" ];then
        continue
    elif [ $dir = "zh" ];then
        continue
    else
        rm -rf dokuwiki/inc/lang/$dir
    fi
done

#
# 新建中文页时使保存的文件名也是中文，不再乱码
#
patch -p2 dokuwiki/inc/pageutils.php <patch/pageutils.php.patch

#
# 修改默认配置，全部配置项见 dokuwiki/conf/dokuwiki.php
#
cp config/local.php dokuwiki/conf/local.php
cp config/acl.auth.php dokuwiki/conf/acl.auth.php
cp config/users.auth.php dokuwiki/conf/users.auth.php

#
# 删除install.php
#
rm dokuwiki/install.php