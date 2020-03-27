# Ubuntu16.04
### 断点续传
> rsync -e "ssh -i security-team-aws.pem" -v --progress ec2-user@34.209.2.17:/home/ec2-user/hash/1.tar.gz ./1.tar.gz

### linux version information
> cat /etc/\*-release

### linux folder size
> du -sh folder_name

### system login
> /var/log/syslog

### 时区更改
> 时区更改 AWS EC2(centos)
>> TZ='Asia/Shanghai'; export TZ  
>> vi /etc/sysconfig/clock  
>> 将内容修改为ZONE=Asia/Shanghai 删除UTC=true  
>> rm /etc/local  
>> 链接到上海时区文件  
>> ln -sf /usr/share/zoneinfo/Asia/Shanghai   /etc/localtime (important)  

> Docker cif(ubuntu)
>> sudo tzselect  
>> sudo cp /usr/share/zoneinfo/Asia/Shanghai  /etc/localtime  
>> sudo vi /etc/timezone  
>> 改为Asia/Shanghai  
>
~~~
You can make this change permanent for yourself by appending the line
	TZ='Asia/Shanghai'; export TZ
to the file '.profile' in your home directory; then log out and log in again.
~~~

### make alias
> vi ~/.bash_profile
>> alias cdp="cd ~/Dropbox/projects/octopress/source/\_posts"

# CentOs
### add account to sudoers
login as root, and add write operations to /etc/sudoers
> chmod +w /etc/sudoers

add 'user ALL=(ALL) ALL' into /etc/sudoers, save and quit.
> vi /etc/sudoers  
chmod -w /etc/sudoers

### network config
use dhcp
> cat /etc/sysconfig/network-scripts/ifcfg-eth0
~~~
DEVICE=eth0
HWADDR=00:1C:42:AA:35:81
TYPE=Ethernet
ONBOOT=yes
BOOTPROTO=dhcp
~~~
~~~
PROTO=static #网卡获得ip地址的方式，Static:静态 ip地址;dhcp:通过dhcp协议获取ip;bootip:通过bootp协议获得的ip地址
BROADCAST=192.168.0.255         #子网广播地址
HWADDR=00:50:56:8E:47:EE        #网卡物理地址
IPADDR=12.168.1.117             #网卡IP地址
IPV6INIT=no                     #是否启用IPV6
IPV6_AUTOCONF=no
NETMASK=255.255.255.0           #网卡对应网络掩码
NETWORK=192.168.1.0             #网卡对应的网络地址
ONBOOT=yes                      #系统启动时是否设置此网络接口，设置为yes时，系统启动时激活此设备。默认设置为yes
~~~

### open ssh server
check if ssh-server already installed
> rpm -qa |grep ssh

if not, try:
> yum install openssh-server

check if sshd auto start:
> chkconfig --list sshd

if not:
> chkconfig --level 2345 sshd on

check if port 22 openning:
> netstat -antp |grep sshd  
or
ss | grep sshd
#iptables -nL  看看是否放行了22口.
#setup---->防火墙设置   如果没放行就设置放行.

### mkdir
make directory directly
> mkdir -p foo/bar/a

### tar
tar a folder without hidden files
> tar -czvf test.tgz --exclude=".\*" test/

extract tgz to specific file
> tar -xzvf test.tgz -C specific_folder/

split large files
~~~
# create archives
$ tar cz my_large_file_1 my_large_file_2 | split -b 1024MiB - myfiles_split.tgz_
# uncompress
$ cat myfiles_split.tgz_* | tar xz
~~~

### echo
set echo font and color, [tutorial](https://stackoverflow.com/questions/5947742/how-to-change-the-output-color-of-echo-in-linux)
### open port
##### ubuntu 16.04
>iptables -I INPUT -p tcp --dport 8181 -j ACCEPT  
iptables -L -n |grep ACCEPT

### 更换 apt-get 源
* a.) add 'apt_preserve_sources_list: true' to /etc/cloud/cloud.cfg
or do the same in user-data
* b.) add sources in /etc/apt/sources.list.d
* c.) make changes to template file /etc/cloud/templates/sources.list.tmpl


[tutorial](http://www.cnblogs.com/lyon2014/p/4715379.html)

* 1. get codename
> lsb_release -a
>> No LSB modules are available.
Distributor ID:	Ubuntu
Description:	Ubuntu 14.04.2 LTS
Release:	14.04
Codename:	trusty

* 2. ensure source is supported
> http://mirrors.aliyun.com/ubuntu/dists/

* 3. copy default source list settings
> cd /etc/apt  
sudo mv sources.list sources.list_bak

* 4. add new source
> sudo vi sources.list

### get linux version
lsb_release -a  
cat /etc/\*release

### crontab
* get crontab ENV
> crontab -e
>> * * * * * env \> /tmp/env.output
>
cat /tmp/env.output
>> HOME=/home/ubuntu  
LOGNAME=ubuntu  
PATH=/opt/someApp/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin  
LANG=en_US.UTF-8  
SHELL=/bin/sh  
PWD=/home/ubuntu  

* run shell script
> crontab -e
>> SHELL=/bin/sh  
PATH=/bin:/sbin:/usr/bin:/usr/sbin

### cd
fdisk -l  
mount /founded_disk /mnt

umount /media/cdrom0
mount -o exec /media/cdrom0

### expect
Expect is a program that "talks" to other interactive programs according to a script.  Following the script, Expect knows what can be expected from a program and what the correct response should be.  An interpreted language provides branching and high-level control structures to direct the dialogue.  In addition, the user can take control and interact directly when desired, afterward returning control to the script.

example
~~~
example
#!/usr/bin/expect
set timeout -1
set PW "233"
spawn /bin/sh encrypt.sh
expect "*password*"
send "$PW\r"
expect "*password*"
send "$PW\r"
expect eof
exit


encrypt.sh
#!/bin/bash
pwd
PW="hhh"
zip -e test.zip  test | tee > log
echo "finished"
~~~

### ssh
specific port
> ssh -p 2222 user@ip

### grep
##### find specific line in file
grep -rnw '/path/to/somewhere/' -e 'pattern'
* -r or -R is recursive,
* -n is line number, and
* -w stands for match the whole word.
* -l (lower-case L) can be added to just give the file name of matching files.
Along with these, --exclude, --include, --exclude-dir or --include-dir flags could be used for efficient searching:

* This will only search through those files which have .c or .h extensions:
>grep --include=\*.{c,h} -rnw '/path/to/somewhere/' -e "pattern"

* This will exclude searching all the files ending with .o extension:
>grep --exclude=\*.o -rnw '/path/to/somewhere/' -e "pattern"

* Just like exclude files, it's possible to exclude/include directories through --exclude-dir and --include-dir parameter. For example, this will exclude the dirs dir1/, dir2/ and all of them matching \*.dst/:
>grep --exclude-dir={dir1,dir2,\*.dst} -rnw '/path/to/somewhere/' -e "pattern"


### zip
zip folder
> zip -r test.zip test/

### unzip
extract files into exdir
> unzip package.zip -d /opt

### route
get gate way
~~~
ti@spark01:~/bigdata/tmp/zookeeper$ route
Kernel IP routing table
Destination     Gateway         Genmask         Flags Metric Ref    Use Iface
default         172.16.104.253  0.0.0.0         UG    0      0        0 ens160
localnet        *               255.255.255.0   U     0      0        0 ens160
~~~

### 查看cpu核数
> cat /proc/cpuinfo| grep "cpu cores"| uniq
