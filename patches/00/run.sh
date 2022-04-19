#!/bin/bash

#********************************************************************
# Author: Alvis Zhao<alvisisme@gmail.com>
# Description：
# 移除无用的多语言支持，仅保留中文和英文
#********************************************************************

find data/inc/lang/*  -maxdepth 0 -type d | grep -v -E "en$|zh$" | xargs -I {} rm -rf {}
