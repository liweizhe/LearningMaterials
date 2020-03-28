# mac version
## install
`brew install nginx`
## config
```
#（配置文件路径）
/usr/local/etc/nginx/nginx.conf
#（服务器默认路径）
/usr/local/var/www
# (安装路径)
/usr/local/Cellar/nginx/1.17.9
```
### 修改网页根目录
`vi /usr/local/etc/nginx/nginx.conf`
修改 root 为网页根目录即可：
```
     server {
         listen       8080;
         server_name  localhost;

         #charset koi8-r;

         #access_log  logs/host.access.log  main;

         location / {
             #root   html;
             root    /Users/lwz/GitHub/fastadmin/fastadmin/public;
             index  index.html index.htm;
         }

```
之后执行 `nginx -s reload`
