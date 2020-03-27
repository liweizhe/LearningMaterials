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
create containser
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

### yum
check update
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
