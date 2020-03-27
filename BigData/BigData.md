# Hadoop
[与 Hadoop 对比，如何看待 Spark 技术？](https://www.zhihu.com/question/26568496)

首先看一下Hadoop解决了什么问题，Hadoop就是解决了大数据（大到一台计算机无法进行存储，一台计算机无法在要求的时间内进行处理）的可靠存储和处理。
* HDFS，在由普通PC组成的集群上提供高可靠的文件存储，通过将块保存多个副本的办法解决服务器或硬盘坏掉的问题。
* MapReduce，通过简单的Mapper和Reducer的抽象提供一个编程模型，可以在一个由几十台上百台的PC组成的不可靠集群上并发地，分布式地处理大量的数据集，而把并发、分布式（如机器间通信）和故障恢复等计算细节隐藏起来。而Mapper和Reducer的抽象，又是各种各样的复杂数据处理都可以分解为的基本元素。这样，复杂的数据处理可以分解为由多个Job（包含一个Mapper和一个Reducer）组成的有向无环图（DAG）,然后每个Mapper和Reducer放到Hadoop集群上执行，就可以得出结果。

![MapReduce](../pics/BigData/map_reduce.jpg)

![MapReduce](../pics/BigData/map_reduce_2.jpg)


# kafka
[documentation](http://kafka.apache.org/documentation.html)

[training-deck-and-tutorial](http://www.michael-noll.com/blog/2014/08/18/apache-kafka-training-deck-and-tutorial/)

### concept
1、消费者：（Consumer）：从消息队列中请求消息的客户端应用程序

2、生产者：（Producer）  ：向broker发布消息的应用程序

3、AMQP服务端（broker）：用来接收生产者发送的消息并将这些消息路由给服务器中的队列，便于fafka将生产者发送的消息，动态的添加到磁盘并给每一条消息一个偏移量，所以对于kafka一个broker就是一个应用程序的实例

### frame
![kafka_frame](../pics/BigData/kafka_frame.png)

##### terminology
WAL（Write Ahead Log）

### quick start
[QuickStart](https://kafka.apache.org/quickstart)

### start kafka
进入kafka安装目录，执行以下命令：
~~~
ti@kafka01:~/bigdata/kafka_2.11-1.0.0$ bin/zookeeper-server-start.sh config/zookeeper.properties >> zoo.log 2>1 &
[1] 3099
ti@kafka01:~/bigdata/kafka_2.11-1.0.0$ bin/kafka-server-start.sh config/server.properties >> kafka.log 2>1 &
[2] 3384
ti@kafka01:~/bigdata/kafka_2.11-1.0.0$ sudo netstat -tunlp|egrep "(2181|9092)"
[sudo] password for ti:
tcp6       0      0 172.16.104.10:9092      :::*                    LISTEN      3384/java       
tcp6       0      0 :::2181                 :::*                    LISTEN      3099/java
~~~

create topic
~~~
ti@kafka01:~/bigdata/kafka_2.11-1.0.0$ bin/kafka-topics.sh --zookeeper localhost:2181 --create --topic test --partitions 1 --replication-factor 1
Created topic "test".
~~~

check topic
~~~
ti@kafka01:~/bigdata/kafka_2.11-1.0.0$ bin/kafka-topics.sh --zookeeper localhost:2181 --list
test
~~~

run console producer & console consumer
~~~
ti@kafka01:~/bigdata/kafka_2.11-1.0.0$ bin/kafka-console-producer.sh --broker-list 172.16.104.10:9092 --topic test
>hi
>nihao a
>hello there
>if      
>boom
>
~~~
the result
~~~
ti@kafka01:~/bigdata/kafka_2.11-1.0.0$ bin/kafka-console-consumer.sh --zookeeper localhost:2181 --topic test
Using the ConsoleConsumer with old consumer is deprecated and will be removed in a future major release. Consider using the new consumer by passing [bootstrap-server] instead of [zookeeper].
hi
nihao a
hello there
if
boom

~~~

# zookeeper
Zookeeper是一种在分布式系统中被广泛用来作为：分布式状态管理、分布式协调管理、分布式配置管理、和分布式锁服务的集群

# spark

[tutorial](https://endymecy.gitbooks.io/spark-programming-guide-zh-cn/content/)

### terminology
##### RDD: Resilient Distributed Dataset

Spark 最主要的抽象是叫Resilient Distributed Dataset(RDD) 的弹性分布式集合。RDDs 可以使用 Hadoop InputFormats(例如 HDFS 文件)创建，也可以从其他的 RDDs 转换。

RDD是一个不可变的带分区的记录集合，RDD也是Spark中的编程模型。Spark提供了RDD上的两类操作，转换和动作。转换是用来定义一个新的RDD，包括map, flatMap, filter, union, sample, join, groupByKey, cogroup, ReduceByKey, cros, sortByKey, mapValues等，动作是返回一个结果，包括collect, reduce, count, save, lookupKey。

在Spark中，所有RDD的转换都是是<b>惰性求值</b>的。RDD的转换操作会生成新的RDD，新的RDD的数据依赖于原来的RDD的数据，每个RDD又包含多个分区。那么一段程序实际上就构造了一个由相互依赖的多个RDD组成的<b>有向无环图（DAG）。</b>并通过在RDD上执行动作将这个有向无环图作为一个Job提交给Spark执行。

<b>transformations 和 actions</b>  
transformations操作理解成一种惰性操作，它只是定义了一个新的RDD，而不是立即计算它。相反，actions操作则是立即计算，并返回结果给程序，或者将结果写入到外存储中。
![trans_act](../pics/BigData/trans_action.jpg)

<p>Spark对于有向无环图Job进行调度，确定<b>阶段（Stage）</b>，<b>分区（Partition）</b>，<b>流水线（Pipeline）</b>，<b>任务（Task）</b>和<b>缓存（Cache）</b>，进行优化，并在Spark集群上运行Job。RDD之间的依赖分为<b>宽依赖</b>（依赖多个分区）和<b>窄依赖</b>（只依赖一个分区），在确定阶段时，需要根据宽依赖划分阶段。根据分区划分任务。</p>

![spark](../pics/BigData/spark_1.jpg)

<p>Spark支持故障恢复的方式也不同，提供两种方式，<b>Linage</b>，通过数据的血缘关系，再执行一遍前面的处理，<b>Checkpoint</b>，将数据集存储到持久存储中。</p>

<p>Spark为<b>迭代式数据处理</b>提供更好的支持。每次迭代的数据可以保存在内存中，而不是写入文件。</p>

<ul><li>抽象层次低，需要手工编写代码来完成，使用上难以上手。</li><ul><li>=&gt;基于RDD的抽象，实数据处理逻辑的代码非常简短。。</li></ul><li>只提供两个操作，Map和Reduce，表达力欠缺。</li><ul><li>=&gt;提供很多转换和动作，很多基本操作如Join，GroupBy已经在RDD转换和动作中实现。</li></ul><li>一个Job只有Map和Reduce两个阶段（Phase），复杂的计算需要大量的Job完成，Job之间的依赖关系是由开发者自己管理的。</li><ul><li>=&gt;一个Job可以包含RDD的多个转换操作，在调度时可以生成多个阶段（Stage），而且如果多个map操作的RDD的分区不变，是可以放在同一个Task中进行。</li></ul><li>处理逻辑隐藏在代码细节中，没有整体逻辑</li><ul><li>=&gt;在Scala中，通过匿名函数和高阶函数，RDD的转换支持流式API，可以提供处理逻辑的整体视图。代码不包含具体操作的实现细节，逻辑更清晰。</li></ul><li>中间结果也放在HDFS文件系统中</li><ul><li>=&gt;中间结果放在内存中，内存放不下了会写入本地磁盘，而不是HDFS。</li></ul><li>ReduceTask需要等待所有MapTask都完成后才可以开始</li><ul><li>=&gt; 分区相同的转换构成流水线放在一个Task中运行，分区不同的转换需要Shuffle，被划分到不同的Stage中，需要等待前面的Stage完成后才可以开始。</li></ul><li>时延高，只适用Batch数据处理，对于交互式数据处理，实时数据处理的支持不够</li><ul><li>=&gt;通过将流拆成小的batch提供Discretized Stream处理流数据。</li></ul><li>对于迭代式数据处理性能比较差</li><ul><li>=&gt;通过在内存中缓存数据，提高迭代式计算的性能。</li></ul></ul>


### map and flatMap
map是将每个元素对应执行f函数，而flatMap对应的是将每个元素执行f函数后将其扁平化
![map](../pics/BigData/spark_map.jpg)
![flatMap](../pics/BigData/spark_flatMap.jpg)


### spark streaming
Spark Streaming支持一个高层的抽象，叫做离散流(discretized stream)或者DStream，它代表连续的数据流。DStream既可以利用从Kafka, Flume和Kinesis等源获取的输入数据流创建，也可以在其他DStream的基础上通过高阶函数获得。在内部，DStream是由一系列RDDs组成。

# jupyter
### [config as public server](https://jupyter-notebook.readthedocs.io/en/stable/public_server.html)
generate config
~~~
ti@spark01:~$ jupyter notebook --generate-config
Overwrite /home/ti/.jupyter/jupyter_notebook_config.py with default config? [y/N]y
Writing default config to: /home/ti/.jupyter/jupyter_notebook_config.py
~~~

generate password
~~~
ti@spark01:~$ jupyter notebook password
Enter password:
Verify password:
[NotebookPasswordApp] Wrote hashed password to /home/ti/.jupyter/jupyter_notebook_config.json
ti@spark01:~$ cat .jupyter/jupyter_notebook_config.json
{
  "NotebookApp": {
    "password": "sha1:3db85c36cbd8:a4d255c9d06952eb6671d2e11c6ad963ae57285d"
  }

~~~

generate keyfile
~~~
ti@spark01:~/bigdata/jupyter-notebook$ openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout mykey.key -out mycert.pem
Generating a 2048 bit RSA private key
.......+++
..........+++
unable to write 'random state'
writing new private key to 'mykey.key'
-----
You are about to be asked to enter information that will be incorporated
into your certificate request.
What you are about to enter is what is called a Distinguished Name or a DN.
There are quite a few fields but you can leave some blank
For some fields there will be a default value,
If you enter '.', the field will be left blank.
-----
Country Name (2 letter code) [AU]:
State or Province Name (full name) [Some-State]:
Locality Name (eg, city) []:
Organization Name (eg, company) [Internet Widgits Pty Ltd]:
Organizational Unit Name (eg, section) []:
Common Name (e.g. server FQDN or YOUR name) []:
Email Address []:

~~~

vi ~/.jupyter/jupyter_notebook_config.py
~~~
# Configuration file for jupyter-notebook.
c.NotebookApp.certfile = u'/home/ti/.jupyter/mycert.pem'
c.NotebookApp.keyfile = u'/home/ti/.jupyter/mykey.key'
c.NotebookApp.ip = '*'
c.NotebookApp.password = u'sha1:3db85c36cbd8:a4d255c9d06952eb6671d2e11c6ad963ae57285d'
c.NotebookApp.open_browser = False
c.NotebookApp.port = 8888
c.NotebookApp.notebook_dir = u'/home/ti/bigdata/jupyter-notebook'
~~~

open with https:localhost:8888


# [PySpark + Kafka](http://spark.apache.org/docs/latest/streaming-kafka-integration.html)
### kafka producer
use confluent_kafka
~~~
from confluent_kafka import Producer
import time

conf = {'bootstrap.servers': '172.16.104.10:9092'}
p = Producer(**conf)
with open('data/hansight.json', 'r') as fi:
    for data in fi.readlines()[0:10]:
        print data
        p.produce('test', data.encode('utf-8'))
        time.sleep(1)
p.flush()
~~~
### Receiver
vi ~/jupyter-notebook/test_pyspark_receiver.py
~~~
from pyspark import SparkContext
from pyspark import SparkConf
from pyspark.streaming import StreamingContext
from pyspark.streaming.kafka import KafkaUtils


def start():
    sconf=SparkConf()
    # sconf.set('spark.streaming.blockInterval','100')
    sconf.set('spark.cores.max' , 8)
    sc=SparkContext(appName='KafkaWordCount',conf=sconf)
    ssc=StreamingContext(sc,10)

    # numStreams = 3
    numStreams = 1
    kafkaStreams = [KafkaUtils.createStream(ssc,"localhost:2181", "test-group",{"test":1}) for _ in range (numStreams)]
    unifiedStream = ssc.union(*kafkaStreams)
    print unifiedStream
    #word count
    result=unifiedStream.map(lambda x:(x[0],1)).reduceByKey(lambda x, y: x + y)
    result.pprint()
    ssc.start()             # Start the computation
    ssc.awaitTermination()  # Wait for the computation to terminate


if __name__ == '__main__':
    start()

~~~

bin/spark-submit --packages org.apache.spark:spark-streaming-kafka-0-8_2.11:2.2.0 ../jupyter-notebook/test_pyspark_receiver.py

### Direct
使用Direct的好处:

   1. 根据topic的分区数默认的创建对应数量的rdd分区数
   2. Receiver的方式需要通过Write AHead Log的方式确保数据不丢失，Direct的方式不需要
   3. 一次处理：使用Kafka Simple API对数据进行读取，使用checkpoint对offset进行记录

问题：基于Zookeeper的Kafka监控工具不能获取offset的值了，需要在每次Batch处理后，可以对Zookeeper的值进行设置

vi ~/jupyter-notebook/test_pyspark_direct.py
~~~
# encoding:utf-8

from pyspark import SparkContext
from pyspark import SparkConf
from pyspark.streaming import StreamingContext
from pyspark.streaming.kafka import KafkaUtils
import json


def tokenize(text):
    return text.split()


def start():
    sconf=SparkConf()
    sconf.set('spark.cores.max' , 8)
    sc=SparkContext(appName='KafkaDirectWordCount',conf=sconf)
    ssc=StreamingContext(sc,10)

    brokers="172.16.104.10:9092"
    topic='test'
    kafkaStreams = KafkaUtils.createDirectStream(ssc,[topic],kafkaParams={"metadata.broker.list": brokers})
    #统计生成的随机数的分布情况
    # result=kafkaStreams.map(lambda x:(x[0],1)).reduceByKey(lambda x, y: x + y)
    # kafkaStreams.pprint()   example: (None, u'qqe\n')
    # words=kafkaStreams.flatMap(lambda x: x[1].split(':'))
    # counts=words.map(lambda x:(x,1)).reduceByKey(lambda x, y: x + y)
    # counts.pprint()
    #打印offset的情况，此处也可以写到Zookeeper中
    #You can use transform() instead of foreachRDD() as your
    # first method call in order to access offsets, then call further Spark methods.
    jsons = kafkaStreams.map(lambda x: json.loads(x[1]))
    # jsons.pprint()
    providers = jsons.filter(lambda x: x if x.get('confidence', 0) >= 70 else None).map(lambda x: x.get('provider', 'NA'))
    counts = providers.map(lambda x: (x, 1)).reduceByKey(lambda x, y: x+y)
    counts.pprint()
    kafkaStreams.transform(storeOffsetRanges).foreachRDD(printOffsetRanges)

    ssc.start()             # Start the computation
    ssc.awaitTermination()  # Wait for the computation to terminate

offsetRanges = []

def storeOffsetRanges(rdd):
    global offsetRanges
    offsetRanges = rdd.offsetRanges()
    return rdd

def printOffsetRanges(rdd):
    for o in offsetRanges:
        print "%s %s %s %s %s" % (o.topic, o.partition, o.fromOffset, o.untilOffset,o.untilOffset-o.fromOffset)

if __name__ == '__main__':
    start()
~~~
bin/spark-submit --packages org.apache.spark:spark-streaming-kafka-0-8_2.11:2.2.0 ../jupyter-notebook/test_pyspark_direct.py


### [Pyspark + Mongodb](https://docs.mongodb.com/spark-connector/master/python-api/)
