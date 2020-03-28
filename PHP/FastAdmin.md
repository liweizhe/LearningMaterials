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

[下载第三方包](https://www.fastadmin.net/download/third.html)
解压缩并覆盖到 fastadmin文件夹下。

# 常见问题
1. 如果使用命令行安装则后台管理默认账号是admin，默认密码是123456
2. 提示请先下载完整包覆盖后再安装，说明你是直接从仓库下载的代码，请从官网下载完整包覆盖后再进行安装
3. 执行php think install时出现Access denied for user ...，请确保数据库服务器、用户名、密码配置正确
4. 执行php think install时报不是内部或外部命令? 请将php.exe所在的目录路径加入到环境变量PATH中
5. 如果提示当前权限不足，无法写入配置文件application/database.php，请检查database.php是否可读，还有可能是当前安装程序无法访问父目录，请检查PHP的open_basedir配置
6. 如果提示找不到fastadmin.fa_admin表或表不存在，请检查你的MySQL是否开启了支持innodb。
7. 如果在Linux环境中使用的是root账户，bower install执行出错，请尝试添加上--allow-root参数
8. 如果访问后台右侧空白，请检查资源是否下载完整，可使用bower install多试两次或下载资源包覆盖
9. 如果composer install失败，请尝试在命令行进行切换配置到国内源，命令如下`composer config -g repo.packagist composer https://mirrors.aliyun.com/composer/`
