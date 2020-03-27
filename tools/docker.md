### 显示镜像 docker images
### 删除镜像 docker rmi IMAGE_ID
### 镜像保存 docker save -o xxx.tar
```
zzh@ubuntu:~$ sudo docker images
REPOSITORY                TAG                 IMAGE ID            CREATED             SIZE
gitlab/gitlab-ce          latest              6099ff61e4ff        4 months ago        1.309 GB
hopsoft/graphite-statsd   latest              2cc9a7dfe93b        5 months ago        870.2 MB
scrapinghub/portia        latest              dd83dbe34c2c        5 months ago        760.9 MB
zzh@ubuntu:~$ sudo docker save -o gitlab.tar gitlab/gitlab-ce
zzh@ubuntu:~$ ls | grep gitlab.tar
gitlab.tar
```
### 镜像加载 docker load -i xxx.tar

```
ti@ubuntu:~$ sudo docker run -d -p 8443:443 -p 5000:5000 -p 9200:9200 aeppert/cifv2
a61f60ec54d393188158340661ba700a96569e18cf16b73631aa7067b0e1c960
ti@ubuntu:~$ sudo docker ps
CONTAINER ID        IMAGE               COMMAND                 CREATED             STATUS              PORTS                                                                   NAMES
a61f60ec54d3        aeppert/cifv2       "/bin/bash /start.sh"   7 seconds ago       Up 5 seconds        0.0.0.0:5000->5000/tcp, 0.0.0.0:9200->9200/tcp, 0.0.0.0:8443->443/tcp   gracious_yonath
ti@ubuntu:~$ sudo docker exec -it gracious_yonath /bin/bash
root@a61f60ec54d3:/# cd /etc/cif/rules/default/
root@a61f60ec54d3:/etc/cif/rules/default# ls
00_whitelist.yml  alexa.yml  autoshun.yml                blocklist_de.yml  bruteforceblocker.yml  emergingthreats.yml  isc_sans_edu.yml  malc0de.yml         mirc.yml         openbl.yml     packetmail.yml     phishtank.yml     spamhaus.yml        vxvault.yml
1d4_us.yml        aper.yml   bambenekconsulting_com.yml  botscout.yml      drg.yml                feodotracker.yml     joxeankoret.yml   malwaredomains.yml  nothink_org.yml  openphish.yml  palevotracker.yml  proxyspy_net.yml  sslbl_abuse_ch.yml  zeustracker.yml
root@a61f60ec54d3:/etc/cif/rules/default# sudo su - cif -c "/opt/cif/bin/cif-smrt --testmode -cdr /etc/cif/rules/default/drg.yml -f ssh"
```
# docker network
```
➜  ~ docker network list
NETWORK ID          NAME                DRIVER              SCOPE
42f269088d4a        bridge              bridge              local
33609e95a1d3        host                host                local
bef6dac63053        none                null                local
```
docker network inspect bridge
```
➜  ~ docker network inspect bridge
[
    {
        "Name": "bridge",
        "Id": "42f269088d4a89c311bca8659d1f692c229b69f11c9f7f24b9883011f67a35d5",
        "Created": "2020-03-27T04:16:33.315969165Z",
        "Scope": "local",
        "Driver": "bridge",
        "EnableIPv6": false,
        "IPAM": {
            "Driver": "default",
            "Options": null,
            "Config": [
                {
                    "Subnet": "172.17.0.0/16"
                }
            ]
        },
        "Internal": false,
        "Attachable": false,
        "Ingress": false,
        "ConfigFrom": {
            "Network": ""
        },
        "ConfigOnly": false,
        "Containers": {
            "4ea12ad96a1a0e73207ccd27eff0a442a3c179ef9598badba9db21dcd99d4ae2": {
                "Name": "mysql",
                "EndpointID": "93e6803b3b7e76db5d63825e5f4d927abb5d15ecaea1908bf6ea77dee1f527e1",
                "MacAddress": "02:42:ac:11:00:02",
                "IPv4Address": "172.17.0.2/16",
                "IPv6Address": ""
            }
        },
        "Options": {
            "com.docker.network.bridge.default_bridge": "true",
            "com.docker.network.bridge.enable_icc": "true",
            "com.docker.network.bridge.enable_ip_masquerade": "true",
            "com.docker.network.bridge.host_binding_ipv4": "0.0.0.0",
            "com.docker.network.bridge.name": "docker0",
            "com.docker.network.driver.mtu": "1500"
        },
        "Labels": {}
    }
]
```
# docker

### docker-machine
Docker Machine是一个工具，用来在虚拟主机上安装Docker Engine，并使用 docker-machine命令来管理这些虚拟主机。

安装：
```
curl -L https://github.com/docker/machine/releases/download/v0.14.0/docker-machine-`uname -s`-`uname -m` >/tmp/docker-machine &&
    chmod +x /tmp/docker-machine &&
    sudo cp /tmp/docker-machine /usr/local/bin/docker-machine
```

创建虚拟 Docker 主机前，以 virtualbox 模式为例，在创建前需要安装 virtualbox 组件，执行
`sudo apt-get install virtualbox`

### docker swarm
提供 Docker 容器集群服务，是 Docker 官方对容器云生态进行支持的核心方案。
### 搭建 Ubuntu+Nginx+PHP 环境
##### 安装Ubuntu
```
➜  ~ docker pull ubuntu
➜  ~ docker run -it --name myserver ubuntu /bin/bash   
```
##### 容器内安装Nginx
```
root@d9af227e280f:/# apt-get update
Get:1 http://security.ubuntu.com/ubuntu bionic-security InRelease [88.7 kB]                            
Get:2 http://archive.ubuntu.com/ubuntu bionic InRelease [242 kB]
pass
Fetched 17.7 MB in 2min 32s (116 kB/s)     
Reading package lists... Done
root@d9af227e280f:/# apt-get install nginx
After this operation, 61.9 MB of additional disk space will be used.
Do you want to continue? [Y/n] Y
pass
```
##### 容器内安装PHP

```
root@d9af227e280f:/# apt-get install php
pass
```

### 打包镜像
```
➜  ~ docker ps                                                                                                                                                    lwz@LWZsMBP
CONTAINER ID        IMAGE               COMMAND             CREATED             STATUS              PORTS               NAMES
d9af227e280f        ubuntu              "/bin/bash"         About an hour ago   Up 5 minutes                            myserver
------------------------------------------------------------
➜  ~ docker commit -m "ubuntu+nginx+php" -a "lwz" d9af227e280f myserver                                                                                           lwz@LWZsMBP
sha256:49a4a4fc0a40b5f2d384c01d2f2a7384bf1398ee95efaf6469bee8169fc9a5cf
------------------------------------------------------------
➜  ~ docker images                                                                                                                                                lwz@LWZsMBP
REPOSITORY          TAG                 IMAGE ID            CREATED             SIZE
myserver            latest              49a4a4fc0a40        6 seconds ago       315MB
ubuntu              18.04               72300a873c2c        3 weeks ago         64.2MB
ubuntu              latest              72300a873c2c        3 weeks ago         64.2MB
```
### 加载镜像并映射宿主机文件夹和端口号
```
➜  ~ docker run  -it --name UNP -p 8080:80 -v "$PWD/html":/var/www/html/ -it ubuntu:18.04 /bin/bash
root@afbc075c3fec:/# which php
/usr/bin/php
root@afbc075c3fec:/# exit
➜  ~ docker restart UNP
UNP
➜  ~ docker ps
CONTAINER ID        IMAGE               COMMAND             CREATED             STATUS              PORTS                              NAMES
afbc075c3fec        myserver            "/bin/bash"         12 minutes ago      Up 8 seconds        0.0.0.0:9001-9020->9001-9020/tcp   UNP
d9af227e280f        ubuntu              "/bin/bash"         2 hours ago         Up About an hour                                       myserver
➜  ~ docker exec -it UNP /bin/bash
```

### docker镜像保存，导入
```
zzh@ubuntu:~$ docker images
Cannot connect to the Docker daemon. Is the docker daemon running on this host?
zzh@ubuntu:~$ sudo docker images
REPOSITORY                TAG                 IMAGE ID            CREATED             SIZE
gitlab/gitlab-ce          latest              6099ff61e4ff        4 months ago        1.309 GB
hopsoft/graphite-statsd   latest              2cc9a7dfe93b        5 months ago        870.2 MB
scrapinghub/portia        latest              dd83dbe34c2c        5 months ago        760.9 MB
zzh@ubuntu:~$ sudo docker save -o gitlab.tar gitlab/gitlab-ce
zzh@ubuntu:~$ ls | grep gitlab.tar
gitlab.tar
```
`docker load -i gitlab.tar `

```
ti@ubuntu:~$ sudo docker run -d -p 8443:443 -p 5000:5000 -p 9200:9200 aeppert/cifv2
a61f60ec54d393188158340661ba700a96569e18cf16b73631aa7067b0e1c960
ti@ubuntu:~$ sudo docker ps
CONTAINER ID        IMAGE               COMMAND                 CREATED             STATUS              PORTS                                                                   NAMES
a61f60ec54d3        aeppert/cifv2       "/bin/bash /start.sh"   7 seconds ago       Up 5 seconds        0.0.0.0:5000->5000/tcp, 0.0.0.0:9200->9200/tcp, 0.0.0.0:8443->443/tcp   gracious_yonath
ti@ubuntu:~$ sudo docker exec -it gracious_yonath /bin/bash
root@a61f60ec54d3:/# cd /etc/cif/rules/default/
root@a61f60ec54d3:/etc/cif/rules/default# ls
00_whitelist.yml  alexa.yml  autoshun.yml                blocklist_de.yml  bruteforceblocker.yml  emergingthreats.yml  isc_sans_edu.yml  malc0de.yml         mirc.yml         openbl.yml     packetmail.yml     phishtank.yml     spamhaus.yml        vxvault.yml
1d4_us.yml        aper.yml   bambenekconsulting_com.yml  botscout.yml      drg.yml                feodotracker.yml     joxeankoret.yml   malwaredomains.yml  nothink_org.yml  openphish.yml  palevotracker.yml  proxyspy_net.yml  sslbl_abuse_ch.yml  zeustracker.yml
root@a61f60ec54d3:/etc/cif/rules/default# sudo su - cif -c "/opt/cif/bin/cif-smrt --testmode -cdr /etc/cif/rules/default/drg.yml -f ssh"
```
