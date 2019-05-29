#  基于dokuwiki搭建的wiki知识库系统

本工程目标是搭建一个开箱即用的个人知识库系统。

## 如何使用

```shell
docker-compose up -d
```

浏览器访问地址 http://ip:9090

根据部署方式修改访问的ip或者端口号

默认登录帐号密码

**admin:admin123456**

## 项目依赖

* dokuwiki 2018-04-22b "Greebo"

## 修订记录

1. 移除多语言支持，仅保留中文和英文

    删除 **dokuwiki/inc/lang** 对应目录。

2. 新建中文页面时文件名直接保存为中文，不再进行转码

    修改 **dokuwiki/inc/pageutils.php** 文件，

    将 `utf8_encodeFN` 返回语句从

    ```php
    $file = urlencode($file);
    $file = str_replace('%2F','/',$file);
    return $file;
    ```

    改为了

    ```php
    return $file;
    ```

    将 `utf8_decodeFN` 返回语句从

    ```php
    return urldecode($file);
    ```

    改为了

    ```php
    return $file;
    ```

3. 修改了wiki的默认参数

    对比 **dokuwiki/conf/dokuwiki.php**（全部的默认参数） 和 **dokuwiki/conf/local.php**（修改的定制参数）



## 参考引用

* [dokuwiki issues:Official dokuwiki docker image](https://github.com/splitbrain/dokuwiki/issues/1896)
* [Installation DokuWiki under Ubuntu](https://www.dokuwiki.org/install:ubuntu)
* [Dokuwiki中文网](http://www.dokuwiki.com.cn/)
* [Dukowiki实现本地文件中文命名](https://www.somnus.top/dukowiki-filename/)