### set
set指令能设置所使用shell的执行方式，可依照不同的需求来做设置
```

   -a 　标示已修改的变量，以供输出至环境变量。

   -b 　使被中止的后台程序立刻回报执行状态。

   -C 　转向所产生的文件无法覆盖已存在的文件。

   -d 　Shell预设会用杂凑表记忆使用过的指令，以加速指令的执行。使用-d参数可取消。

   -e 　若指令传回值不等于0，则立即退出shell。

   -f　 　取消使用通配符。

   -h 　自动记录函数的所在位置。

   -H Shell 　可利用"!"加<指令编号>的方式来执行history中记录的指令。

   -k 　指令所给的参数都会被视为此指令的环境变量。

   -l 　记录for循环的变量名称。

   -m 　使用监视模式。

   -n 　只读取指令，而不实际执行。

   -p 　启动优先顺序模式。

   -P 　启动-P参数后，执行指令时，会以实际的文件或目录来取代符号连接。

   -t 　执行完随后的指令，即退出shell。

   -u 　当执行时使用到未定义过的变量，则显示错误信息。

   -v 　显示shell所读取的输入值。

   -x 　执行指令后，会先显示该指令及所下的参数。

   +<参数> 　取消某个set曾启动的参数。
```

### read
read -p "info" var

### . source
'.' is synonym of 'source', both of them add vars to env

### export
transfer vars to sub shell

### $?
Expands  to  the status of the most recently executed foreground pipeline.
For example,
> if [ $? -eq 0 ]

get the return value of the last executed cmd to judge whether it was finished normally.

### $var and ${var}
[difference](https://stackoverflow.com/questions/18135451/what-is-the-difference-between-var-var-and-var-in-the-bash-shell)

### function
    function dotr ()
    {
         tr 'a-z' 'A-Z'
    }

### vars use case
[tutorial](http://blog.csdn.net/jinzhao1993/article/details/53579723)

### case
    case $num in
        "one")
                printInfo; echo $num | dotr
                ;;
        "two")
                printInfo; echo $num | dotr
                ;;
        "Three")
                printInfo; echo $num | dotr
                ;;
        "four") printInfo; echo $num | dotr
                ;;
    esac

### 换行
'\'+ Enter  
for example
  ./configure --sbin-path=/usr/local/nginx/nginx \
  --conf-path=/usr/local/nginx/nginx.conf \
  --pid-path=/usr/local/nginx/nginx.pid


### 单引号问题
~~~
#!/bin/bash
DIR="/home/ubuntu/mongo_bak"
END_DATE=$(date +%Y-%m-%d)
BEGIN_DATE=$(date -d "1 days ago" +%Y-%m-%d)
mkdir -p $DIR/$BEGIN_DATE
QUERY='{"timestamp": {"$gte":"'$BEGIN_DATE' 00:00:00", "$lt":"'$END_DATE' 00:00:00"}}'
bash -c "mongodump -h localhost -d virustotal -c new_hash -q '$QUERY' -o $DIR/$BEGIN_DATE"
cd $DIR && tar -czf ${BEGIN_DATE}.tgz $BEGIN_DATE && rm -rf $BEGIN_DATE && cd -
~~~


### string operation
%x=abcdabcd
%echo ${x/a/b} # 只替换一个
bbcdabcd
%echo ${x//a/b} # 替换所有
bbcdbbcd
[tutorial](http://justcoding.iteye.com/blog/1963463)


### [] test
~~~
[ -a FILE ]	如果 FILE 存在则为真。
[ -b FILE ]	如果 FILE 存在且是一个块特殊文件则为真。
[ -c FILE ]	如果 FILE 存在且是一个字特殊文件则为真。
[ -d FILE ]	如果 FILE 存在且是一个目录则为真。
[ -e FILE ]	如果 FILE 存在则为真。
[ -f FILE ]	如果 FILE 存在且是一个普通文件则为真。
[ -g FILE ]	如果 FILE 存在且已经设置了SGID则为真。
[ -h FILE ]	如果 FILE 存在且是一个符号连接则为真。
[ -k FILE ]	如果 FILE 存在且已经设置了粘制位则为真。
[ -p FILE ]	如果 FILE 存在且是一个名字管道(F如果O)则为真。
[ -r FILE ]	如果 FILE 存在且是可读的则为真。
[ -s FILE ]	如果 FILE 存在且大小不为0则为真。
[ -t FD ]	如果文件描述符 FD 打开且指向一个终端则为真。
[ -u FILE ]	如果 FILE 存在且设置了SUID (set user ID)则为真。
[ -w FILE ]	如果 FILE 如果 FILE 存在且是可写的则为真。
[ -x FILE ]	如果 FILE 存在且是可执行的则为真。
[ -O FILE ]	如果 FILE 存在且属有效用户ID则为真。
[ -G FILE ]	如果 FILE 存在且属有效用户组则为真。
[ -L FILE ]	如果 FILE 存在且是一个符号连接则为真。
[ -N FILE ]	如果 FILE 存在 and has been mod如果ied since it was last read则为真。
[ -S FILE ]	如果 FILE 存在且是一个套接字则为真。
[ FILE1 -nt FILE2 ]	如果 FILE1 has been changed more recently than FILE2, or 如果 FILE1 exists and FILE2 does not则为真。
[ FILE1 -ot FILE2 ]	如果 FILE1 比 FILE2 要老, 或者 FILE2 存在且 FILE1 不存在则为真。
[ FILE1 -ef FILE2 ]	如果 FILE1 和 FILE2 指向相同的设备和节点号则为真。
[ -o OPTIONNAME ]	如果 shell选项 “OPTIONNAME” 开启则为真。
[ -z STRING ]	“STRING” 的长度为零则为真。
[ -n STRING ] or [ STRING ]	“STRING” 的长度为非零 non-zero则为真。
[ STRING1 == STRING2 ]	如果2个字符串相同。 “=” may be used instead of “==” for strict POSIX compliance则为真。
[ STRING1 != STRING2 ]	如果字符串不相等则为真。
[ STRING1 < STRING2 ]	如果 “STRING1” sorts before “STRING2” lexicographically in the current locale则为真。
[ STRING1 > STRING2 ]	如果 “STRING1” sorts after “STRING2” lexicographically in the current locale则为真。
[ ARG1 OP ARG2 ]	“OP” is one of -eq, -ne, -lt, -le, -gt or -ge. These arithmetic binary operators return true if “ARG1” is equal to, not equal to, less than, less than or equal to, greater than, or greater than or equal to “ARG2”, respectively. “ARG1” and “ARG2” are integers.
~~~
