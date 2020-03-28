# debian
## lookup ip config
```
root@4ea12ad96a1a:/# apt-get install net-tools
root@4ea12ad96a1a:/# ifconfig -a
eth0: flags=4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 1500
        inet 172.17.0.3  netmask 255.255.0.0  broadcast 172.17.255.255
        ether 02:42:ac:11:00:03  txqueuelen 0  (Ethernet)
        RX packets 199  bytes 260003 (253.9 KiB)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 148  bytes 8154 (7.9 KiB)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0

```
