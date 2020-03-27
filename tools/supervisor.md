# supervisor
install, [tutorial 1](http://www.restran.net/2015/10/04/supervisord-tutorial/)
[tutorial 2](http://liyangliang.me/posts/2015/06/using-supervisor/)
> pip install supervisor

cat default config files
> echo_supervisord_conf > /etc/supervisor.conf

if permission denied, try:
> sudo su - root -c "echo_supervisord_conf > /etc/supervisord.conf"

run supervisor, if not use '-c', supervisor will find config file in $CWD/supervisord.conf,$CWD/etc/supervisord.conf,/etc/supervisord.conf by order :
> supervisord -c /etc/supervisord.conf

new program.ini need reloading before use:
> supervisorctl reload


### start group programe
```
ubuntu@ip-172-31-8-226:~/supervisor$ supervisorctl
vtspider_ip:vtspider_ip_00               STOPPED   Not started
vtspider_ip:vtspider_ip_01               STOPPED   Not started
vtspider_ip:vtspider_ip_02               STOPPED   Not started
vtspider_ip:vtspider_ip_03               STOPPED   Not started
vtspider_new_hash:vtspider_new_hash_00   STOPPED   Not started
vtspider_new_hash:vtspider_new_hash_01   STOPPED   Not started
vtspider_new_hash:vtspider_new_hash_02   STOPPED   Not started
vtspider_new_hash:vtspider_new_hash_03   STOPPED   Not started
supervisor> start vtspider_new_hash:*
vtspider_new_hash:vtspider_new_hash_00: started
vtspider_new_hash:vtspider_new_hash_01: started
vtspider_new_hash:vtspider_new_hash_02: started
vtspider_new_hash:vtspider_new_hash_03: started
```

### a ini example
~~~
[program:ti]
; 程序的启动目录
directory = /opt/hansight/ti/script
; 启动命令，可以看出与手动在命令行启动的命令是一样的
command = bash start.sh
; 在 supervisord 启动的时候也自动启动
autostart = true
; 启动 5 秒后没有异常退出，就当作已经正常启动了
startsecs = 60     
; 程序异常退出后自动重启
autorestart = true
; 启动失败自动重试次数，默认是 3
startretries = 3     
; 用哪个用户启动
user = hansight          
; 把 stderr 重定向到 stdout，默认 false
redirect_stderr = true
; stdout 日志文件大小，默认 50MB
stdout_logfile_maxbytes = 10MB
; stdout 日志文件备份数
stdout_logfile_backups = 10
; stdout 日志文件，需要注意当指定目录不存在时无法正常启动，所以需要手动创建目录（supervisord 会自动创建日志文件）
stdout_logfile = /opt/hansight/ti/log/runtime.log
~~~
