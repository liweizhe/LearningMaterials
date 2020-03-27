# 1. VMware虚拟网络
[reference](http://blog.51cto.com/wangchunhai/381225)

![vm_net](pics/network/vm_net.jpg)

### 1.1 host-only
其默认的网络行为，只与主机或其他使用VMnet1虚拟网卡的虚拟机有网络连接。使用VMnet1虚拟网卡的虚拟机，不能访问与物理主机之外的其他计算机.
### 1.2 nat
主机A的VMnet8虚拟网卡，连接到VMnet8虚拟交换机，VMnet8虚拟交换机连接到“虚拟路由器”，“虚拟路由器”再连接到“VMnet0虚拟网卡(也即主机物理网卡)”，并通过“VMnet0虚拟网卡”连接到“VMnet0虚拟交换机”，“VMnet0虚拟交换机”连接到主机物理网络。这也就表明，连接到“VMnet8虚拟交换机”的计算机（虚拟机或主机），需要通过“虚拟路由器”→“VMnet0虚拟网卡”→“VMnet0虚拟交换机”的方向连接到主机物理网络。
### 1.3 bridged
即VMnet0，则虚拟机相当于主机网络中的一台计算机，虚拟机如果选择VMnet0（或桥接网络），则通过“VMnet0虚拟交换机”连接到主机所属网络，这时与主机“VMnet0虚拟网卡”是否设置IP地址无关。

# 2. docker网络

### 2.1 前置条件
##### 2.1.1 linux网络命名空间(network namespaces)
[reference](http://blog.csdn.net/vacing/article/details/69802394)

##### 2.1.2 Linux虚拟网络设备之veth
[reference](https://segmentfault.com/a/1190000009251098)

### 2.2 基本原理
docker0是网桥
