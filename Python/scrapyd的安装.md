## 安装scrapyd服务器
* sudo pip install scrapyd
* (aws安装需要lib包，后面有介绍)
* 配置文件目录 /usr/local/lib/python2.7/dist-packages/scrapyd/default_scrapyd.conf
* 安装在aws的目录在/usr/local/lib/python2.7/site-packages/scrapyd/default_scrapyd.conf

* 修改配置文件default_scrapyd.conf为
> bind_address = 0.0.0.0
* 启动scrapyd
* 访问http：//server_ip:6800

## 在爬虫scrapy工程目录下安装scrapyd-client
* sudo pip install scrapyd-client
* cp  /usr/local/lib/python2.7/dist-packages/scrapyd-client/scrapyd-deploy    directory_of_scrapy.cfg
* 修改爬虫工程目录文件scarpy.cfg
```
[deploy]
url = http://172.16.102.199:6800/#修改scrapyd所在的服务地址
project = tispider
```
* 部署前需要安装各种爬虫需要的lib包
* 进入到爬虫工程文件所在的目录： 运行python scrapyd-deploy -l
> default              http://172.16.102.199:6800/
* 部署爬虫 scrapyd-deploy <target> -p <project> --version <version>
> target就是前面配置文件里deploy后面的的target名字  
> project 可以随意定义，跟爬虫的工程名字无关  
> version自定义版本号，不写的话默认为当前时间戳  
> sudo python scrapyd-deploy  -l#查看现有爬虫部署   
> sudo python scrapyd-deploy  default -p tispider   
> 部署aws ：sudo python scrapyd-deploy  aws -p tispider  
> sudo python scrapyd-deploy localslave01 	 -p vtspider_slaver01  
> sudo python scrapyd-deploy localmaster 	 -p vtspider_master  
## 查看爬虫
> curl http://localhost:6800/listprojects.json  
> curl http://localhost:6800/listspiders.json?project=myproject    
> curl http://localhost:6800/listversions.json?project=myproject 
## 启动爬虫
* curl http://localhost:6800/schedule.json -d project=PROJECT_NAME -d spider=SPIDER_NAME
> curl http://127.0.0.1:6800/schedule.json -d project=vtspider_master -d spider=vtspider_ip  
>  curl http://127.0.0.1:6800/schedule.json -d project=vtspider_master -d spider=vtspider_domain  
>  curl http://127.0.0.1:6800/schedule.json -d project=vtspider_master -d spider=vtspider_hash  
>  curl http://127.0.0.1:6800/schedule.json -d project=vtspider_master -d spider=vtspider_url  
>  curl http://172.16.102.199:6800/schedule.json -d project=tispider -d spider=vtspider_ip  
>  curl http://172.16.102.199:6800/schedule.json -d project=tispider -d spider=vtspider_domain  
>  curl http://172.16.102.199:6800/schedule.json -d project=tispider -d spider=vtspider_hash  
>  curl http://172.16.102.199:6800/schedule.json -d project=tispider -d spider=vtspider_url 
## kill爬虫
> curl http://localhost:6800/cancel.json -d project=vtspider -d job=81e3b1c46b8e11e7b861000c291bcf1d
## 删除某版本的爬虫
> curl http://localhost:6800/listversions.json?project=vtspider_master
> curl http://localhost:6800/delversion.json -d project=vtspider_master -d version="1502420169"
> curl http://localhost:6800/delversion.json -d project=myproject -d version=r99
## 删除某个工程
> curl http://localhost:6800/delproject.json -d project=tispider
## 部署过程中遇到的错误提示，一般为缺少python lib包
0. pip安装
```
sudo apt-get install python-pip
```
1.  安装scrapy-redis、scrapy_crawlera、pymongo、random-useragent
```
sudo pip install scrapy-redis
sudo pip install shodan
sudo pip install scrapy_crawlera
sudo pip install pymongo
sudo pip install scrapy-random-useragent
sudo pip install bs4

sudo /usr/local/bin/pip install shodan
sudo /usr/local/bin/pip install scrapy-redis
sudo /usr/local/bin/pip install scrapy_crawlera
sudo /usr/local/bin/pip install pymongo
sudo /usr/local/bin/pip install scrapy-random-useragent
```
2.  安装mongodb
```
sudo apt-get install mongodb
sudo apt install mongodb-clients
sudo apt install mongodb-server
```
3. 安装redis
```
安装tcl(redis需求)
sudo apt-get install tcl
获取redis安装文件并解压安装
wget http://download.redis.io/releases/redis-stable.tar.gz
tar -xvf redis-stable.tar.gz
cd redis-stable
make
sudo make test

若报错，执行:taskset -c 1 sudo make test
修改配置文件
vi redis.conf

#bind 127.0.0.1
bind 0.0.0.0
sudo cp redis.conf /etc/
安装工具
apt install redis-server
redis-server
apt install redis-tools
运行redis服务 service redisd start 
redis-cli 在本地目录下也有
 ln -s /home/ec2-user/redis-3.2.1/src/redis-cli /usr/bin/redis-cli

127.0.0.1:6379>
```

### aws安装scrapyd缺少的lib包
```
yum -y install gcc
yum -y install gcc-c++
yum install -y libffi-devel
yum install -y openssl-devel
yum install libxslt-devel
```
### [aws install redis-cli](https://gist.github.com/Integralist/72161a96641fa4a0033d)
```
sudo yum install gcc
sudo yum install wget
wget http://download.redis.io/redis-stable.tar.gz
tar xvzf redis-stable.tar.gz
cd redis-stable
make
make test

```

### aws 启动顺序
```
nohup /usr/local/bin/scrapyd &  #测试访问6800端口
/home/ec2-user/redis-3.2.1/src/redis-server
/home/ec2-user/redis-stable/src/redis-cli

远程访问不到reids时候，需要关闭安全保护模式 redis-cli > CONFIG SET protected-mode no
```


## docketr 安装监控graphite
> service docker restart  
> docker run -d  --name graphite  --restart=always  -p 80:80 -p 2003-2004:2003-2004 -p 2023-2024:2023-2024 -p 8125:8125/udp  -p 8126:8126  hopsoft/graphite-statsd
>> 访问地址80端口测试安装成功否  
*  在爬虫工程目录下setting.py设置如下配置文件，并将[工程代码](https://github.com/samrayleung/jd_spider)statscol和utils进行代码修改与集成
```
STATS_CLASS = 'tispider.statscol.graphite.RedisGraphiteStatsCollector'
GRAPHITE_HOST = '127.0.0.1'
GRAPHITE_PORT = 2003
STATS_KEY = 'scrapy:vt:stats'
```
docker exec -it  hopsoft/graphite-statsd /bin/bash


### 分布式爬虫部署 ###
1. 三种类型的setting(测试版：)
2. 对部署的不同爬虫定制不同的setup.py  
3. 
### 常见问题
1. Q1：Twisted.python.failure.Failure twisted.internet.error.ConnectionLost: Connection to the other side was lost in a non-clean fashion: 
> Answer1:[useragent](https://github.com/scrapy/scrapy/issues/1636)