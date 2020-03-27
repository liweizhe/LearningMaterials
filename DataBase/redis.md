# install with docker
```
➜  ~ docker pull redis:5.0.8
5.0.8: Pulling from library/redis
68ced04f60ab: Already exists
7ecc253967df: Pull complete
765957bf98d4: Pull complete
91fff01e8fef: Pull complete
76feb725b7e3: Pull complete
75797de34ea7: Pull complete
Digest: sha256:ddf831632db1a51716aa9c2e9b6a52f5035fc6fa98a8a6708f6e83033a49508d
Status: Downloaded newer image for redis:5.0.8
➜  ~ docker run -itd --name redis -p6379:6379 redis:5.0.8
cc090ba913193379e5ae7c29c2711e37289b22f312424208f2f5202ccf8b3e58
➜  ~ docker exec -it redis /bin/bash
root@cc090ba91319:/data# redis-server --version  
Redis server v=5.0.8 sha=00000000:0 malloc=jemalloc-5.1.0 bits=64 build=ce75a617c591114f
root@cc090ba91319:/data# redis-cli
127.0.0.1:6379>

```
# install redis on ubuntu 16.04
sudo apt-get install redis-server

# run
redis-server

# cli
redis-cli

# command
[commands](http://www.runoob.com/redis/redis-lists.html)
