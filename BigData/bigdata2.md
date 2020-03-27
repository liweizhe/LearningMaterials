### [kafka zookeeper单例安装](https://www.cnblogs.com/wangyangliuping/p/5546465.html)  
1. [zookeeper安装](http://blog.csdn.net/tanyujing/article/details/8504481)  
> sudo apt-get install default-jre  
> sudo apt-get install default-jdk  
> wget http://mirror.bit.edu.cn/apache/zookeeper/stable/zookeeper-3.4.10.tar.gz
> ./bin/zkServer.sh start  
> ./bin/zkServer.sh status


2. kafka [install](http://note.youdao.com/)
> wget http://mirror.bit.edu.cn/apache/kafka/1.0.0/kafka_2.11-1.0.0.tgz
> ./kafka-server-start.sh ../config/server.properties &  
> netstat -tunlp|egrep "(2181|9092)"

### kafka 常见命令行


1. 查看所有topic列表  
./kafka-topics.sh --zookeeper 127.0.0.1:2181 --list

2. 查看指定topic信息  
./kafka-topics.sh --zookeeper 127.0.01:2181 --describe --topic topic_json

3. 创建topic  
kafka-topics.sh --create --zookeeper localhost:2181 --replication-factor 1 --partitions 1 --topic agg_test

4. 如果防火墙是正常的，就需要改变Kafka的配置：  
在/config/service.properties中，添加上一句host.name=192.168.211.129




### [spark install]()  
1. install java  
2. wget http://mirror.bit.edu.cn/apache/spark/spark-2.2.1/spark-2.2.1-bin-hadoop2.7.tgz
3. ./bin/spark-shell
4. ./sbin/start-all.sh

###  配置pyspark环境
pip install findspark
### [spark免秘登录](http://www.dataguru.cn/thread-324474-1-1.html)
3.4 ssh-keygen -t rsa
然后一直按回车键即可。
复制spark-master结点的id_rsa.pub文件到另外两个结点：
scp -r  id_rsa.pub spark@ubuntu-worker:/root/.ssh/ 到另外两个结点，将公钥加到用于认证的公钥文件中:
cat id_rsa.pub >> authorized_keys
本地部署情况：
cp /root/.ssh/id_rsa.pub  /root/.ssh/authorized_keys
3.4.1 本机也需要配置



### [Apache Kafka 与Spark的集成](https://www.w3cschool.cn/apache_kafka/apache_kafka_integration_spark.html)

1. 安装confluent_kafka  
sudo apt-get install librdkafka-dev python-dev  
pip install confluent_kafka  


./spark-submit  --master spark://172.16.104.30:6666   --packages org.apache.spark:spark-streaming-kafka-0-8_2.11:2.2.1 /home/ti/src/ spark-consume.py   


./spark-submit  --master spark://192.168.0.161:8080   --packages org.apache.spark:spark-streaming-kafka-0-8_2.11:2.2.1  /home/zzh/dealwith.py   


bin/spark-submit --master spark://192.168.26.245:7077 --jars jars/spark-streaming-kafka-0-8-assembly_2.11-2.0.2.jar python/txt.py


./spark-submit    --packages org.apache.spark:spark-streaming-kafka-0-8:2.2.1 /home/ti/bigdata/test/rte02.py   


./spark-submit  --master spark://172.16.104.30:6666   --packages org.apache.spark:spark-streaming-kafka-0-8:2.2.1 /home/ti/src/test/spark-consume.py   


## splunk
1. 下载
wget -O splunk-7.0.1-2b5b15c4ee89-Linux-x86_64.tgz 'https://www.splunk.com/bin/splunk/DownloadActivityServlet?architecture=x86_64&platform=linux&version=7.0.1&product=splunk&filename=splunk-7.0.1-2b5b15c4ee89-Linux-x86_64.tgz&wget=true'

2. 启动
3. ./splunk start
