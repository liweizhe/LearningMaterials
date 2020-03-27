# Kafka
[tutorial-link](http://www.infoq.com/cn/articles/kafka-analysis-part-1#anch120241)


### consumer group, multi topics
[understanding kafka consumer lag](https://www.opsclarity.com/understanding-kafka-consumer-lag/)
![A Consumer Group’s Relationship to Partitions](pics/BigData/kafka_multi_topics.jpg)
kafka group 只负责协调那些订阅同一topic的consumer。即使同在一个group，订阅不同topic的consumer之间也互无影响。
