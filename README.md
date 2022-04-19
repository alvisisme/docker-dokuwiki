#  基于dokuwiki搭建的wiki知识库系统

本工程目标是搭建一个开箱即用的个人知识库系统。

[个人知识库网站](http://wiki.alvisisme.site/)

## 如何使用

1. 复制环境变量

    ```bash
    cp env.sample .env
    ```

    按照自己需求修改 **.env** 下的配置

2. 下载并需要安装的 `dokuwiki` 版本

    ```bash
    make download
    make clean
    make build
    ```

3. 启动 `dokuwiki`

    ```bash
    docker-compose up -d
    ```

    启动成功后执行如下命令确保 dokuwiki 的拥有正确的读写权限

    ```bash
    docker exec -it dokuwiki chown -R www-data:www-data /var/www/dokuwiki
    ```

4. 访问并测试 `dokuwiki`

    浏览器默认访问地址 `http://ip:9090`， 根据部署方式修改访问的ip或者端口号

    默认登录帐号密码为 **admin:admin123456**

## 项目依赖

* dokuwiki "Greebo" 2018-04-22b 605944ec47cd5f822456c54c124df255

## 修订记录

见 **patches** 目录下各个脚本注释

## 参考引用

* [DokuWiki Archived Downloads](https://download.dokuwiki.org/archive)
* [dokuwiki issues:Official dokuwiki docker image](https://github.com/splitbrain/dokuwiki/issues/1896)
* [Installation DokuWiki under Ubuntu](https://www.dokuwiki.org/install:ubuntu)
* [Dokuwiki中文网](http://www.dokuwiki.com.cn/)
* [Dukowiki实现本地文件中文命名](https://www.somnus.top/dukowiki-filename/)
* [Supervisor with Docker: Lessons learned](https://advancedweb.hu/supervisor-with-docker-lessons-learned/)
* [Installing Dokuwiki on Ubuntu 18.04 with Nginx](https://www.dokuwiki.org/install:ubuntu:ubuntu_18.04_nginx)
* [How can I start php-fpm in a Docker container by default?](https://stackoverflow.com/questions/37313780/how-can-i-start-php-fpm-in-a-docker-container-by-default/37313908)