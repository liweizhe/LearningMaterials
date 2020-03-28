# install
pull docker image
```
➜  ~ docker pull centos:8  
8: Pulling from library/centos
8a29a15cefae: Pull complete
Digest: sha256:fe8d824220415eed5477b63addf40fb06c3b049404242b31982106ac204f6700
Status: Downloaded newer image for centos:8
docker.io/library/centos:8
➜  ~ docker images
REPOSITORY          TAG                 IMAGE ID            CREATED             SIZE
ubuntu              18.04               4e5021d210f6        6 days ago          64.2MB
mysql               5.7                 84164b03fa2e        3 weeks ago         456MB
centos              8                   470671670cac        2 months ago        237MB
```
create container
```
➜  ~ docker run -itd --name centos centos:8 /bin/bash
77109bf8bf5a836352ee4ab26c31caf321666210e6585e0f1cfd30d3200c500c
➜  ~ docker exec -it centos /bin/bash
[root@77109bf8bf5a /]# cat /etc/*-release
CentOS Linux release 8.1.1911 (Core)
NAME="CentOS Linux"
VERSION="8 (Core)"
ID="centos"
ID_LIKE="rhel fedora"
VERSION_ID="8"
PLATFORM_ID="platform:el8"
PRETTY_NAME="CentOS Linux 8 (Core)"
ANSI_COLOR="0;31"
CPE_NAME="cpe:/o:centos:centos:8"
HOME_URL="https://www.centos.org/"
BUG_REPORT_URL="https://bugs.centos.org/"

CENTOS_MANTISBT_PROJECT="CentOS-8"
CENTOS_MANTISBT_PROJECT_VERSION="8"
REDHAT_SUPPORT_PRODUCT="centos"
REDHAT_SUPPORT_PRODUCT_VERSION="8"

CentOS Linux release 8.1.1911 (Core)
CentOS Linux release 8.1.1911 (Core)
[root@77109bf8bf5a /]#

```
# docker systemctl
创建容器：

` docker run -d -name centos7 --privileged=true centos:7 /usr/sbin/init`

进入容器：

`docker exec -it centos7 /bin/bash`

# docker base images
Dockerfile:
```
FROM centos:7
ENV container docker
RUN (cd /lib/systemd/system/sysinit.target.wants/; for i in *; do [ $i == \
systemd-tmpfiles-setup.service ] || rm -f $i; done); \
rm -f /lib/systemd/system/multi-user.target.wants/*;\
rm -f /etc/systemd/system/*.wants/*;\
rm -f /lib/systemd/system/local-fs.target.wants/*; \
rm -f /lib/systemd/system/sockets.target.wants/*udev*; \
rm -f /lib/systemd/system/sockets.target.wants/*initctl*; \
rm -f /lib/systemd/system/basic.target.wants/*;\
rm -f /lib/systemd/system/anaconda.target.wants/*;
VOLUME [ "/sys/fs/cgroup" ]
CMD ["/usr/sbin/init"]
```
进入 Dockerfile 存放文件夹下，执行：
`docker build --rm -t local/c7-systemd .`

创建容器，添加 privilege 参数：
`docker run -itd --name base --privileged=true local/c7-systemd`

这样可以使用systemctl启动服务了。
### yum
#### 更改镜像源为国内
* 网易：http://mirrors.163.com.centos/   
* 阿里云：http://mirros.aliyun.com/centos

```
mv /etc/yum.repos.d/CentOS-Base.repo  /etc/yum.repos.d/CentOS-Base.repo.backup
# wget -O /etc/yum.repos.d/CentOS-Base.repo http://mirrors.163.com/.help/CentOS7-Base-163.repo
wget -O /etc/yum.repos.d/CentOS-Base.repo http://mirrors.aliyun.com/repo/Centos-7.repo
yum makecache
yum -y update
```
#### check update
```
[root@77109bf8bf5a /]# yum check-update
Failed to set locale, defaulting to C.UTF-8
Last metadata expiration check: 0:01:06 ago on Fri Mar 27 06:17:37 2020.

audit-libs.x86_64                                                                 3.0-0.13.20190507gitf58ec40.el8                                                     BaseOS
binutils.x86_64                                                                   2.30-58.el8_1.1                                                                     BaseOS
centos-gpg-keys.noarch                                                            8.1-1.1911.0.9.el8                                                                  BaseOS
centos-release.x86_64                                                             8.1-1.1911.0.9.el8                                                                  BaseOS
centos-repos.x86_64                                                               8.1-1.1911.0.9.el8                                                                  BaseOS
glibc.x86_64                                                                      2.28-72.el8_1.1                                                                     BaseOS
glibc-common.x86_64                                                               2.28-72.el8_1.1                                                                     BaseOS
glibc-minimal-langpack.x86_64                                                     2.28-72.el8_1.1                                                                     BaseOS
libarchive.x86_64                                                                 3.3.2-8.el8_1                                                                       BaseOS
openldap.x86_64                                                                   2.4.46-11.el8_1                                                                     BaseOS
sqlite-libs.x86_64                                                                3.26.0-4.el8_1                                                                      BaseOS
systemd.x86_64                                                                    239-18.el8_1.4                                                                      BaseOS
systemd-libs.x86_64                                                               239-18.el8_1.4                                                                      BaseOS
systemd-pam.x86_64                                                                239-18.el8_1.4                                                                      BaseOS
systemd-udev.x86_64                                                               239-18.el8_1.4                                                                      BaseOS
[root@77109bf8bf5a /]#

```

### ip
```
[root@350f16f03a80 fastadmin]# ip addr
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN group default qlen 1000
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
    inet 127.0.0.1/8 scope host lo
       valid_lft forever preferred_lft forever
2: tunl0@NONE: <NOARP> mtu 1480 qdisc noop state DOWN group default qlen 1000
    link/ipip 0.0.0.0 brd 0.0.0.0
3: ip6tnl0@NONE: <NOARP> mtu 1452 qdisc noop state DOWN group default qlen 1000
    link/tunnel6 :: brd ::
8: eth0@if9: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue state UP group default
    link/ether 02:42:ac:11:00:02 brd ff:ff:ff:ff:ff:ff link-netnsid 0
    inet 172.17.0.2/16 brd 172.17.255.255 scope global eth0
       valid_lft forever preferred_lft forever
```
