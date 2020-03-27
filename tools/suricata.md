# Suricata
### Basic Info
[来源](https://www.douban.com/note/577616936/)

Suricata是一个高性能的网络入侵检测（IDS）、入侵防御(IPS）和网络安全监控的多线程引擎,内置支持IPv6。可加载snort规则和签名，支持barnyard2。使用pcap提供的接口进行抓包，运行前电脑必须安装有pcap才可以使用。
* 支持操作系统：Linux\\Mac\\FreeBSD\\UNIX\\Windows\\Ubuntu
* 官方网站：https://suricata-ids.org/
* 帮助网页：https://redmine.openinfosecfoundation.org/projects/suricata/wiki

The Suricata engine is capable of real time intrusion detection (IDS), inline intrusion prevention (IPS), network security monitoring (NSM) and offline pcap processing.

### Docs
[official docs](http://suricata.readthedocs.io/en/suricata-4.0.4/)


### installation
##### ubuntu 16.04
[link](https://redmine.openinfosecfoundation.org/projects/suricata/wiki/Ubuntu_Installation_-_Personal_Package_Archives_(PPA))

To setup to install the latest stable Suricata, do:
```
sudo add-apt-repository ppa:oisf/suricata-stable
sudo apt-get update
```
Then you can install the latest stable Suricata with:

`sudo apt-get install suricata`

Upgrading
```
sudo apt-get update
sudo apt-get upgrade suricata
```

Remove

`sudo apt-get remove suricata`

### Basic Setup
[link](https://redmine.openinfosecfoundation.org/projects/suricata/wiki/Basic_Setup)

Config Files in `/etc/suricata`

### Rules
##### Payload KeyWord
[link](http://suricata.readthedocs.io/en/suricata-4.0.4/rules/payload-keywords.html)

[pcre](http://suricata.readthedocs.io/en/suricata-4.0.4/rules/pcre.html)


##### add own Rules
[link](http://suricata.readthedocs.io/en/suricata-4.0.4/rule-management/adding-your-own-rules.html)


### listen multi interfeces
[reference](https://pevma.blogspot.com/2015/05/suricata-multiple-interface.html)
vi suricata.yaml:
```
af-packet:
  - interface: eth2
    threads: 16
    cluster-id: 98
    cluster-type: cluster_cpu
    defrag: no
    use-mmap: yes
    ring-size: 200000
    checksum-checks: kernel
  - interface: eth1
    threads: 2
    cluster-id: 97
    cluster-type: cluster_flow
    defrag: no
    use-mmap: yes
    ring-size: 30000
  - interface: eth3
    threads: 2
    cluster-id: 96
    cluster-type: cluster_flow
    defrag: no
    use-mmap: yes
    ring-size: 20000
```
