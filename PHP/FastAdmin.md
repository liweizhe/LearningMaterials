# install on centos 8.1
## install package
necessary package
```
[root@77109bf8bf5a /]# yum check-update
[root@77109bf8bf5a /]# yum install php
[root@77109bf8bf5a /]# yum install nginx
[root@77109bf8bf5a /]# yum install php-pdo
[root@77109bf8bf5a /]# yum install php-mbstring
[root@77109bf8bf5a /]# yum install php-curl
```
optional package
```
[root@77109bf8bf5a /]# yum install nodejs
[root@77109bf8bf5a /]# yum install php-json
[root@77109bf8bf5a /]# curl -sS https://getcomposer.org/installer | php
[root@77109bf8bf5a /]# mv composer.phar /usr/local/bin/composer
[root@77109bf8bf5a /]# yum install gcc-c++ make
[root@77109bf8bf5a /]# npm install -g bower
[root@77109bf8bf5a /]# yum install less
```
### config
edit `/etc/php.ini`
```
; Extension PDO
extension=pdo.so
```
if `PHP Warning:  Module 'PDO' already loaded in Unknown on line 0` appear,

delete `extension=pdo.so` in `/etc/php.ini`
## install fastadmin
download from git:
`git clone https://gitee.com/karson/fastadmin.git`

```
[root@77109bf8bf5a fastadmin]# cd fastadmin/
[root@77109bf8bf5a fastadmin]# bower install --allow-root
[root@77109bf8bf5a fastadmin]# composer config -g repo.packagist composer https://packagist.phpcomposer.com
[root@77109bf8bf5a fastadmin]# composer install
Loading composer repositories with package information
Updating dependencies (including require-dev)
Your requirements could not be resolved to an installable set of packages.

  Problem 1
    - endroid/qr-code 1.9.3 requires ext-gd * -> the requested PHP extension gd is missing from your system.
    - endroid/qr-code 1.9.2 requires ext-gd * -> the requested PHP extension gd is missing from your system.
    - endroid/qr-code 1.9.1 requires ext-gd * -> the requested PHP extension gd is missing from your system.
    - endroid/qr-code 1.9.0 requires ext-gd * -> the requested PHP extension gd is missing from your system.
    - Installation request for endroid/qr-code ^1.9 -> satisfiable by endroid/qr-code[1.9.0, 1.9.1, 1.9.2, 1.9.3].
You can also run `php --ini` inside terminal to see which files are used by PHP in CLI mode.
```
安卓验证码依赖库下载失败。可以用`php --ini`查看已加载的库。
