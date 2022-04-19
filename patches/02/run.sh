#!/bin/bash

#********************************************************************
# Author: Alvis Zhao<alvisisme@gmail.com>
# Description：
# 新建中文页面时文件名直接保存为中文，不再进行转码
#********************************************************************

echo "$conf['fnencode'] = 'utf-8';" >> data/conf/local.php