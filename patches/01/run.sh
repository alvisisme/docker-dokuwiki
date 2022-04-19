#!/bin/bash

#********************************************************************
# Author: Alvis Zhao<alvisisme@gmail.com>
# Description：
# 将一些常用配置设为默认，并建立默认账号和密码
# 默认账号: admin
# 默认密码：admin123456
#********************************************************************

cp patches/01/acl.auth.php data/conf/acl.auth.php
cp patches/01/users.auth.php data/conf/users.auth.php
cp patches/01/local.php data/conf/local.php
