### install on centos
```
yum install wget
wget http://repo.mysql.com/mysql-community-release-el7-5.noarch.rpm && rpm -ivh mysql-community-release-el7-5.noarch.rpm
ls -1 /etc/yum.repos.d/mysql-community*
yum install mysql-server
mysql_secure_installation

```
uninstall
```
yum remove mysql mysql-server
mv /var/lib/mysql /var/lib/mysql_old_backup
rm -vR /var/lib/mysql
```
### docker install
获取镜像（默认 debian 系统），创建容器时设置 mysql 密码 123456 、映射端口 3306
```
docker pull mysql:5.7
docker run -d -p 3306:3306 --name=mysql --env="MYSQL_ROOT_PASSWORD=123456" mysql:5.7
docker exec -it mysql /bin/bash
```

获取 centos7 系统的 mysql 镜像：
`docker pull centos/mysql-57-centos7:5.7`
`docker run -d --name mysql_database -e MYSQL_USER=user -e MYSQL_PASSWORD=pass -e MYSQL_DATABASE=db -p 3306:3306 centos/mysql-57-centos7:5.7`

[官方镜像安装教程](https://dev.mysql.com/doc/mysql-installation-excerpt/5.6/en/docker-mysql-getting-started.html)
### 创建数据库、表
所有 sql 语句为了区分关键字与普通字符，引入反引号 \` ，列名称均适用反引号，普通字符使用但引号。
```
DROP TABLE IF EXISTS `fa_demo`;
CREATE TABLE IF NOT EXISTS `fa_demo`(
`id` int(8) unsigned NOT NULL AUTO_INCREMENT,
`nickname` varchar(50) NOT NULL DEFAULT '' COMMENT '昵称',
`email` varchar(255) NULL DEFAULT NULL COMMENT '邮箱',
`birthday` int(11) UNSIGNED NOT NULL DEFAULT '0' COMMENT '生日',
`status` tinyint(2) NOT NULL DEFAULT '0' COMMENT '状态',
`create_time` int(11) UNSIGNED NOT NULL DEFAULT '0' COMMENT '注册时间',
`update_time` int(11) UNSIGNED NOT NULL DEFAULT '0' COMMENT '更新时间', PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 ;
```
### 显示表的详细信息
`show full fields from table_name;`
### 返回表的记录数
`select count('') from table`
### 修改表名
`ALTER TABLE old_name RENAME new_name`
### MySQL Workbench
```
use `demo`;
create table if not exists `think_user`(
  `id` int(8) unsigned not null auto_increment,
  `nickname` varchar(50) not null,
  `email` varchar(255) null default null,
  `birthday` int(11) unsigned not null default '0',
  `status` tinyint(2) not null default '0',
  `create_time` int(11) unsigned not null default '0',
  `update_time` int(11) unsigned not null default '0',
  PRIMARY KEY (`id`)
) ENGINE = MyISAM DEFAULT CHARSET = utf8;
show tables;
```

# Incorrect integer value: ''
### Try Use NULL install of ''
Try to edit your my.cf and comment the original sql_mode and add sql_mode = "".

`vi /etc/mysql/my.cnf`

```sql_mode = ""```

save and quit...

`service mysql restart`

# 类型
类型|大小|用途
:-:|:-:|:-:
CHAR|0-255byte|定长字符串
VARCHAR|0-65535byte|变长字符串


#如何在MySQL中增加一列
如果想在一个已经建好的表中添加一列，可以使用诸如：

`alter table TABLE_NAME add column NEW_COLUMN_NAME varchar(255) not null;`
