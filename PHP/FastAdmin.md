# 1 install on mac
## 1.1 download
full pakage archive link: https://www.fastadmin.net/download/full.html
解压到 /Users/lwz/Github/fastadmin
## 1.2 use MxSrvs
使用集成环境 MxSrvs。
dmg link: http://www.xsrvs.com/

### 1.2.1 Config
主要是 nginx 的配置，在集成环境 MxSrvs 中：Config Edit->Nginx->vhost+
写入以下配置
```
server {
	listen			80;
	server_name		www.demo.com;
	root			/Users/lwz/GitHub/fastadmin/public;
	access_log		/Applications/MxSrvs/logs/fastadmin.log;
	location ~ \.php(.*)$ {
        include        fastcgi_params;
        #端口号请根据实际情况填写
        fastcgi_pass 127.0.0.1:10080;
        fastcgi_index  index.php;
        fastcgi_split_path_info  ^(.+\.php)(.*)$;
        fastcgi_param  SCRIPT_FILENAME  $document_root$fastcgi_script_name;
        fastcgi_param  PATH_INFO  $fastcgi_path_info;
        fastcgi_param  PATH_TRANSLATED  $document_root$fastcgi_path_info;
        fastcgi_read_timeout 60s;
    }
	location / {
        index  index.php index.html index.htm;
        #以下代码必须有
        if (!-e $request_filename) {
            rewrite  ^(.*)$  /index.php?s=$1  last;
            break;
        }
    }
}
```
启动服务：
```
start nginx
start php
start mysql
```
访问 `www.demo.com`
### 1.2.2 System Settings
无法验证开发者的应用按以下顺序来添加信任。
System Preference->Security & Privacy->General->Click the lock to make changes


# 2 插件开发
## 2.1 创建插件
进入`think`的根目录，此处为`/Users/lwz/Github/fastadmin`，执行命令创建 mydemo:
> php thnk addon -a mydemo -c create

执行之后会在根目录 addons 下出现一个 mydemo 文件夹，目录树如下
```
➜  fastadmin git:(master) ✗ tree addons/mydemo
addons/mydemo
├── Mydemo.php
├── config.php
├── controller
│   └── Index.php
└── info.ini

1 directory, 4 files
➜  fastadmin git:(master) ✗ ➜  
```
通过`http://www.demo.com/addons/mydemo`访问插件页面。
同时在后台“管理->插件管理->本地插件”也将出现创建的插件

## 2.2 目录结构
FastAdmin所有插件都是存放在`addons`目录，一个插件一个目录，目录名必须和插件标识相同，且全部为小写，不允许出现大写或下划线等特殊符号。
```
mydemo //插件标识
├── application    //此文件夹中所有文件会覆盖到根目录的/application文件夹
├── assets        //此文件夹中所有文件会复制到/public/assets/addons/blog文件夹
├── controller    //此文件夹为插件控制器目录
├── lang            //此文件夹为插件语言包目录
├── model            //此文件夹为插件模型目录
├── public        //此文件夹中所有文件会覆盖到根目录的/public文件夹
├── view            //此文件夹为插件视图目录
├── Mydemo.php        //此文件为插件核心安装卸载控制器,必需存在
├── bootstrap.js    //此文件为插件JS启动文件
├── LICENSE        //版权文件
├── config.php    //插件配置文件,我们在后台插件管理中点配置按钮时配置的文件,必需存在
├── info.ini        //插件信息文件,用于保存插件基本信息，插件开启状态等,必需存在
└── install.sql    //插件数据库安装文件,此文件仅在插件安装时会进行导入
```
其中的`application`和`public`文件夹会覆盖到根目录, 主要用于后台管理功能的开发
## 2.3 内置函数
### 2.3.1 addon_url
生成插件控制器方法的 url
#### 参数列表
名称|描述
:-:|:-:
$url	|插件标识/控制器名/方法名
$vars	|变量参数，默认为空
$suffix	|是否生成后缀，默认为true
$domain	|域名，默认不包含域名
#### 调用方法
```
$url1 = addon_url('mydemo/index/index');
$url2 = addon_url('mydemo/index/index', [':name'=>'myname', 'id'=>123]);
$url3 = addon_url('mydemo/index/index', [':name'=>'myname', 'id'=>123], true, true)
```
### 2.3.2 get_addon_list
获得插件列表，此函数将返回本地已安装的插件列表。
输入`$addonList = get_addon_list();`调用，返回二维数组。
### 2.3.3 get_addon_info
pass

## 2.4 数据库
pass

## 2.5 配置
配置文件在插件目录下，此处为 `addons/mydemo/config.php`，配置文件需要返回一个多位数组，例如：
```
<?php

return [
    [
        //配置名称,该值在当前数组配置中确保唯一
        'name'    => 'yourname',
        //配置标题
        'title'   => '配置标题',
        //配置类型,支持string/text/number/datetime/array/select/selects/image/images/file/files/checkbox/radio/bool
        'type'    => 'string',
        //配置select/selects/checkbox/radio/bool时显示的列表项
        'content' => [
            '1' => '显示',
            '0' => '不显示'
        ],
        //配置值
        'value'   => '1',
        //配置验证规则,更之规则可参考nice-validator文件
        'rule'    => 'required',
        'msg'     => '验证失败提示文字',
        'tip'     => '字段填写帮助',
        'ok'      => '验证成功提示文字',
        'extend'  => ''
    ],
    [
        'name'    => 'yourname2',
        'title'   => '配置标题2',
        'type'    => 'radio',
        'content' => [
            '1' => '显示',
            '0' => '不显示'
        ],
        'value'   => '1',
        'rule'    => 'required',
        'msg'     => '验证失败提示文字',
        'tip'     => '字段填写帮助',
        'ok'      => '验证成功提示文字',
        'extend'  => ''
    ],
    [
        'name'    => '__tips__',
        'title'   => '温馨提示',
        'type'    => 'string',
        'content' =>
            array(),
        'value'   => '该提示将出现的插件配置头部，通常用于提示和说明',
        'rule'    => '',
        'msg'     => '',
        'tip'     => '',
        'ok'      => '',
        'extend'  => '',
    ],
];
```

添加上述配置信息后，可在后台管理页面：后台管理->插件管理 中找到对应的 `配置` 选项。

#### 参数说明
pass

## 2.6 控制器
FastAdmin插件中的控制器和ThinkPHP5的控制器类似，
请参考：https://www.kancloud.cn/manual/thinkphp5/118047
### 控制器定义
典型的控制器代码如下，位于`adons/mydemo/Index.php`：
```
<?php

namespace addons\mydemo\controller;

use think\addons\Controller;

class Index extends Controller
{

    public function index()
    {
        $this->error("当前插件暂无前台页面");
    }

}
```
### 控制器请求
`http://www.demo.addons/mydemo/控制器名/控制器方法`

### 基类控制器
FastAdmin的基类控制器`\think\addons\Controller`位于`vendor/karsonzhang/fastadmin-addons/src/addons/Controller.php`。

### 基类属性
```
protected $addon = null; //插件名称
protected $controller = null; //控制器名称
protected $action = null; //方法名称
/**
 * 无需登录的方法,同时也就不需要鉴权了
 * @var array
 */
protected $noNeedLogin = ['*'];
/**
 * 无需鉴权的方法,但需要登录
 * @var array
 */
protected $noNeedRight = ['*'];
/**
 * 权限Auth，如果用户是登录太，可以直接从中读取用户信息
 * @var Auth
 */
protected $auth = null;

/**
 * 布局模板，默认不启用
 * @var string
 */
protected $layout = null;
```

## 2.7 模型
FastAdmin插件中的模型使用方法完全同ThinkPHP5的模型使用相同，
参考：https://www.kancloud.cn/manual/thinkphp5/135186

## 2.8 视图
FastAdmin插件中的视图使用方法完全同ThinkPHP5的视图使用相同，
参考：https://www.kancloud.cn/manual/thinkphp5/118112


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
```
可以用`php --ini`查看已加载的库。

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
