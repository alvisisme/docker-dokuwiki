#!/bin/bash

set -e

DOKUWIKI_VERSION="release_stable_2018-04-22b"
DOKUWIKI_PATH="/var/www/html"


function start_wiki {
if [ -f $DOKUWIKI_PATH/install.php ];then
    echo "Ready to start dokuwki server"
    chown -R www-data $DOKUWIKI_PATH
    #
    # 删除install.php
    # 重要：脚本通过该文件来判断是否为第一次安装
    #
    rm $DOKUWIKI_PATH/install.php
    service apache2 restart
    exit 0
else
    echo "Ready to setup dokuwki"
fi
}

start_wiki

#
# 下载安装包
#
if [ ! -f $DOKUWIKI_VERSION.tar.gz ]; then
echo "Downloading dokuwiki version $DOKUWIKI_VERSION"
wget -nv https://github.com/splitbrain/dokuwiki/archive/$DOKUWIKI_VERSION.tar.gz
fi

#
# 解压安装包
#
echo "Extracting dokuwiki package to /var/www/html"
tar zxf $DOKUWIKI_VERSION.tar.gz
mv dokuwiki-$DOKUWIKI_VERSION/* /var/www/html/
rm -rf dokuwiki-$DOKUWIKI_VERSION

#
# 删除不必要的多语言支持文件，仅保留中文和英文
#
for dir in `ls $DOKUWIKI_PATH/inc/lang`
do
    if [ $dir = "en" ];then
        continue
    elif [ $dir = "zh" ];then
        continue
    else
        rm -rf $DOKUWIKI_PATH/inc/lang/$dir
    fi
done

#
# 新建中文页时使文件保存为中文命名
# 参考 [Dukowiki实现本地文件中文命名](https://www.somnus.top/dukowiki-filename/)
#
patch -p2 $DOKUWIKI_PATH/inc/pageutils.php <patch/pageutils.php.patch

#
# 修改默认配置，全部配置项见 dokuwiki/conf/dokuwiki.php
#
cp config/local.php $DOKUWIKI_PATH/conf/local.php
cp config/acl.auth.php $DOKUWIKI_PATH/conf/acl.auth.php
cp config/users.auth.php $DOKUWIKI_PATH/conf/users.auth.php

#
# 创建默认页
#
cp pages/sidebar.txt $DOKUWIKI_PATH/data/pages/sidebar.txt
cp pages/welcome.txt $DOKUWIKI_PATH/data/pages/start.txt
cp pages/welcome.txt $DOKUWIKI_PATH/data/pages/wiki/welcome.txt
cp pages/syntax.txt $DOKUWIKI_PATH/data/pages/wiki/syntax.txt
cp pages/dokuwiki.txt $DOKUWIKI_PATH/data/pages/wiki/dokuwiki.txt

rm -f $DOKUWIKI_PATH/index.html

#=======================
#       安装插件
#=======================
#
# 删除不必要的默认插件
#
rm -rf $DOKUWIKI_PATH/lib/plugins/authpgsql
rm -rf $DOKUWIKI_PATH/lib/plugins/authpdo
rm -rf $DOKUWIKI_PATH/lib/plugins/authmysql
rm -rf $DOKUWIKI_PATH/lib/plugins/authad
rm -rf $DOKUWIKI_PATH/lib/plugins/authldap
#
# Move Plugin(https://www.dokuwiki.org/plugin:move)
#
if [ ! -d $DOKUWIKI_PATH/lib/plugins/move ]; then
wget -nv https://github.com/michitux/dokuwiki-plugin-move/archive/2018-04-30.tar.gz -O dokuwiki-plugin-move.tar.gz
tar zxf dokuwiki-plugin-move.tar.gz > /dev/null
mv dokuwiki-plugin-move-2018-04-30 $DOKUWIKI_PATH/lib/plugins/move
fi

#
# Note Plugin(https://www.dokuwiki.org/plugin:note)
#
if [ ! -d $DOKUWIKI_PATH/lib/plugins/note ]; then
wget -nv https://github.com/LarsGit223/dokuwiki_note/archive/2019-04-18.tar.gz -O dokuwiki-plugin-note.tar.gz
tar zxf dokuwiki-plugin-note.tar.gz > /dev/null
mv dokuwiki_note-2019-04-18 $DOKUWIKI_PATH/lib/plugins/note
fi

#
# IndexMenu Plugin(https://www.dokuwiki.org/plugin:indexmenu)
#
if [ ! -d $DOKUWIKI_PATH/lib/plugins/indexmenu ]; then
wget -nv https://codeload.github.com/samuelet/indexmenu/zip/master -O dokuwiki-plugin-indexmenu.zip
unzip dokuwiki-plugin-indexmenu.zip > /dev/null
mv indexmenu-master $DOKUWIKI_PATH/lib/plugins/indexmenu
fi

#
# nosidebar Plugin(https://www.dokuwiki.org/plugin:nosidebar)
# 可以解决 IndexMenu 插件的id冲突错误的问题，将 https://github.com/samuelet/indexmenu/issues/67
#
if [ ! -d $DOKUWIKI_PATH/lib/plugins/nosidebar ]; then
wget -nv https://codeload.github.com/lupo49/dokuwiki-plugin-nosidebar/legacy.zip/master -O dokuwiki-plugin-nosidebar.zip
unzip dokuwiki-plugin-nosidebar.zip > /dev/null
mv lupo49-dokuwiki-plugin-nosidebar-8bd4ab6 $DOKUWIKI_PATH/lib/plugins/nosidebar
fi

#
# AddNewPage Plugin(https://www.dokuwiki.org/plugin:addnewpage)
#
if [ ! -d $DOKUWIKI_PATH/lib/plugins/addnewpage ]; then
wget -nv https://github.com/samwilson/dokuwiki-plugin-addnewpage/archive/2015-11-02.tar.gz -O dokuwiki-plugin-addnewpage.tar.gz
tar zxf dokuwiki-plugin-addnewpage.tar.gz > /dev/null
mv dokuwiki-plugin-addnewpage-2015-11-02 $DOKUWIKI_PATH/lib/plugins/addnewpage
fi

#
# Discussion Plugin(https://www.dokuwiki.org/plugin:discussion)
#
if [ ! -d $DOKUWIKI_PATH/lib/plugins/discussion ]; then
wget -nv https://github.com/dokufreaks/plugin-discussion/archive/2017-08-24.tar.gz -O dokuwiki-plugin-discussion.tar.gz
tar zxf dokuwiki-plugin-discussion.tar.gz > /dev/null
mv plugin-discussion-2017-08-24 $DOKUWIKI_PATH/lib/plugins/discussion
fi

#
# Icons Plugin(https://www.dokuwiki.org/plugin:icons)
#
if [ ! -d $DOKUWIKI_PATH/lib/plugins/icons ]; then
wget -nv https://codeload.github.com/LotarProject/dokuwiki-plugin-icons/legacy.zip/master -O dokuwiki-plugin-icons.zip
unzip dokuwiki-plugin-icons.zip > /dev/null
mv LotarProject-dokuwiki-plugin-icons-5459480 $DOKUWIKI_PATH/lib/plugins/icons
fi

#
# ImgPaste Plugin(https://www.dokuwiki.org/plugin:imgpaste)
#
if [ ! -d $DOKUWIKI_PATH/lib/plugins/imgpaste ]; then
wget -nv https://github.com/cosmocode/dokuwiki-plugin-imgpaste/archive/2018-05-03.tar.gz -O dokuwiki-plugin-imgpaste.tar.gz
tar zxf dokuwiki-plugin-imgpaste.tar.gz > /dev/null
mv dokuwiki-plugin-imgpaste-2018-05-03 $DOKUWIKI_PATH/lib/plugins/imgpaste
fi

#
# SMTP Plugin(https://www.dokuwiki.org/plugin:smtp)
#
if [ ! -d $DOKUWIKI_PATH/lib/plugins/smtp ]; then
wget -nv https://github.com/splitbrain/dokuwiki-plugin-smtp/archive/2019-03-21.tar.gz -O dokuwiki-plugin-smtp.tar.gz
tar zxf dokuwiki-plugin-smtp.tar.gz > /dev/null
mv dokuwiki-plugin-smtp-2019-03-21 $DOKUWIKI_PATH/lib/plugins/smtp
fi


#
# upgrade Plugin(https://www.dokuwiki.org/plugin:upgrade)
#
if [ ! -d $DOKUWIKI_PATH/lib/plugins/upgrade ]; then
wget -nv https://github.com/splitbrain/dokuwiki-plugin-upgrade/archive/2019-04-24.tar.gz -O dokuwiki-plugin-upgrade.tar.gz
tar zxf dokuwiki-plugin-upgrade.tar.gz > /dev/null
mv dokuwiki-plugin-upgrade-2019-04-24 $DOKUWIKI_PATH/lib/plugins/upgrade
fi


#
# 清理安装包
#
rm *.tar.gz
rm *.zip

start_wiki
