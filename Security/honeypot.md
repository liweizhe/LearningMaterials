# honeypot
# category
[reference](https://github.com/paralax/awesome-honeypots/blob/master/README_CN.md)
### suricata
Suricata是一个高性能的网络入侵检测（IDS）、入侵防御(IPS）和网络安全监控的多线程引擎,内置支持IPv6。可加载snort规则和签名，支持barnyard2。使用pcap提供的接口进行抓包，运行前电脑必须安装有pcap才可以使用。

### Snort
一个多平台(Multi-Platform),实时(Real-Time)流量分析，网络IP数据包(Pocket)记录等特性的强大的网络入侵检测/防御系统(Network Intrusion Detection/Prevention System)

Snort的有三种模式的运行方式：嗅探器模式，包记录器模式，和网络入侵检测系统模式。嗅探器模式仅仅是从捕获网络数据包显示在终端上，包记录器模式则是把捕获的数据包存储到磁盘，入侵检测模式则是最复杂的能对数据包进行分析、按规则进行检测、做出响应。

### cowrie
Cowrie是一款交互型SSH蜜罐，用于获取攻击者用于对SSH进行暴力破解的字典，输入命令以及上传或下载恶意文件 这些记录都会被记载到日志当中或者倒入数据库当中更方便查询
Cowrie is a "medium interaction SSH and Telnet honeypot designed to log brute force attacks and the shell interaction performed by the attacker."

### dionaea
Dionaea is meant to be a nepenthes successor, embedding python as
scripting language, using libemu to detect shellcodes, supporting ipv6
and tls
How it works:
dionaea intention is to trap malware exploiting vulnerabilities exposed
by services offerd to a network, the ultimate goal is gaining a copy of
the malware.


### Conpot
Conpot is an ICS honeypot with the goal to collect intelligence about the motives and methods of adversaries targeting industrial control systems

### Glastopf
Web 应用攻击诱捕软件
漏洞类型仿真

未知的攻击

支持多种数据库类型

HPFeeds通讯

过内置的沙箱PHP远程文件包含，本地文件包含通过POST请求

通常对手使用搜索引擎和特殊制作的搜索请求找到他们的受害者

模拟SQL注入、爬虫响应等。

### kippo
一款优秀的SSH蜜罐开源软件，受Kojoney的启发，于2009年开源发布的另一款SSH 蜜罐软件，它在Kojoney基础上能够进一步提供更加真实的shell交互环境，比如支持对一个文件系统目录的完全伪装，允许攻击者能够增加或者删除其中的文件；包含一些伪装的文件内容，如/etc/passwd和/etc/shadow等攻击者感兴趣的文件；以UML（User Mode Linux）兼容格式来记录shell会话日志，并提供了辅助工具能够逼真地还原攻击过程；引入很多欺骗和愚弄攻击者的智能响应机制，往往会让攻击者对自己的智商产生怀疑。正是由于具有这些特性，Kippo能够称为是一种中等交互级别的SSH蜜罐软件。

伪装文件系统

•    伪装用户文件存储

•    Sftp子文件系统 上传文件存储

•    模拟一些特殊的黑客关心的文件/etc/passwd

伪造系统命令

•    文件上传下载命令 sftp、scp，同时支持客户端wget/curl命令解析

•    SSH交互执行的命令(黑客入侵常用命令)：w\\exit\\cat\\uname\\chmod\\ps\\cd

伪装系统相关配置

•    Hostname

•    SSH服务指纹

•    SSH账号和密码

•    SSH key

与外部威胁情报联动

•    连接IP白名单威胁情报

•    上传可疑文件内容检查威胁情报

日志大数据处理

•    支持elastic search日志导出

### p0f
p0f是一款被动探测工具，能够通过捕获并分析目标主机发出的数据包来对主机上的操作系统进行鉴别，即使是在系统上装有性能良好的防火墙的情况下也没有问题。同时p0f在网络分析方面功能强大，可以用它来分析NAT、负载均衡、应用代理等。p0f是万能的被动操作系统指纹工具。p0f对于网络攻击非常有用，它利用SYN数据包实现操作系统被动检测技术，能够正确地识别目标系统类型。和其他扫描软件不同，它不向目标系统发送任何的数据，只是被动地接受来自目标系统的数据进行分析。因此，一个很大的优点是：几乎无法被检测到，而且p0f是专门系统识别工具，其指纹数据库非常详尽，更新也比较快，特别适合于安装在网关中。

# mhn(Modern Honey Network)
[MHN](https://github.com/threatstream/mhn) is a centralized server for management and data collection of honeypots. MHN allows you to deploy sensors quickly and to collect data immediately, viewable from a neat web interface. Honeypot deploy scripts include several common honeypot technologies, including Snort, Cowrie, Dionaea, and glastopf, among others.

### restart honeypot
on honeypot server, restart p0f for example
> superuserclt restart p0f
