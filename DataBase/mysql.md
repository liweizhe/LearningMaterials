### docker 运行，设置root
```
docker run -d -p 3306:3306 --name=mysql --env="MYSQL_ROOT_PASSWORD=123456" mysql:5.7
docker exec -it mysql /bin/bash
```
### mysql
```
root@6d71bd4bb15c:/# mysql -u root -p
Enter password:
Welcome to the MySQL monitor.  Commands end with ; or \g.
Your MySQL connection id is 2
Server version: 5.7.29 MySQL Community Server (GPL)

Copyright (c) 2000, 2020, Oracle and/or its affiliates. All rights reserved.

Oracle is a registered trademark of Oracle Corporation and/or its
affiliates. Other names may be trademarks of their respective
owners.

Type 'help;' or '\h' for help. Type '\c' to clear the current input statement.

mysql>
```
### 创建数据库、表
所有 sql 语句为了区分关键字与普通字符，引入反引号 \` ，列名称均适用反引号，普通字符使用但引号。
```
mysql> create database if not exists `demo`;
Query OK, 1 row affected, 1 warning (0.00 sec)

mysql> use `demo`
Database changed
mysql> create table if not exists `think_data`(
    -> `id` int(8) unsigned NOT NULL AUTO_INCREMENT,
    -> `name` varchar(255) NOT NULL COMMENT 'NAME',
    -> `status` tinyint(2) NOT NULL DEFAULT '0' COMMENT 'STATUS',
    -> PRIMARY KEY (`id`)
    -> )ENGINE=MyISAM DEFAULT CHARSET=utf8;
Query OK, 0 rows affected (0.03 sec)
```

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
