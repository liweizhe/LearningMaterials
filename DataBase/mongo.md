# 常用指令
## 添加索引
add indexes
> db.clt_name.ensureIndex({'sha256': 1})

or create index at background
> db.clt_name.ensureIndex({'sha256':1},{background:true})

### 查询已创建索引
search created indexes:
> db.new_hash.getIndexes()
## 更改表的列名
`{$rename: { <field1>: <newName1>, <field2>: <newName2>, ... } }`

example:
`db.job.updateMany({'Tel':{$exists:true}},{$rename:{'Tel':'tel'}})`
### MongoDB CMD  
> help	Show help.    
db.help()	Show help for database methods.  
db.<collection>.help()	Show help on collection methods. The <collection> can be the name of an existing collection or a non-existing collection.  
show dbs	Print a list of all databases on the server.  
use <db>	Switch current database to <db>. The mongo shell variable db is set to the current database.  
show collections	Print a list of all collections for current database  
show users	Print a list of users for current database.  
show roles	Print a list of all roles, both user-defined and built-in, for the current database.  
show profile	Print the five most recent operations that took 1 millisecond or more. See documentation on the database profiler for more information.  
show databases	Print a list of all available databases.  
load()	Execute a JavaScript file. See Write Scripts for the mongo Shell for more information.  
{"file_identification":{"MD5" : "37a28cbbe04448f06df5bb74ddf3d32e"}}

### CMD history
> vi ~/.dbshell

### key exist and value not null
db.getCollection('ip').find({"enrich.portlist.port": {$exists : true, $ne : ""}})

### get collection value
db.collection_name.totalSize()

### dump specific collection
mongoexport -h localhost -d virustotal -c ip --jsonArray -o mongo_bak/virustotal_ip
mongoimport -h localhost -d tmp -c ip --jsonArray virustotal_ip

mongoexport -h localhost -d virustotal -c domain -o virustotal_domain
> -h host
-d database name
-c collection_name
-o output file

mongoimport -h localhost -d tmp -c domain --file=virustotal_domain

##### dump files by query
mongoexport -h localhost -d HanSight -c ip --query '{"reporttime": "2017-09-05 11:58:34"}' -o 2017_10_10_ip

mongoimport -h localhost -d tmp -c hhhh --mode upsert --file=2017_10_10_ip
(mongoimport -h localhost -d HanSight -c ip --upsert --file=hansight_ip)
> --mode=[insert|upsert|merge]                insert: insert only. upsert: insert or replace existing documents. merge: insert or modify existing documents. defaults to insert


### mongodump & mongorestore
mongodump -h localhost -d virustotal -c new_hash -q '$QUERY' -o 2017-10-29/

mongorestore -d test 2017-10-29/virustotal/

* 将mongo原来的数据库文件复制到/mongo_extend/virustotal
> cp /var/lib/mongodb/virus* /mongo_extend/virustotal/
* 将中的Hansight中的数据软连接到mongo data配置文件
>  cp /var/lib/mongodb/HanSight* /HanSight/
> ln -s /Hansight  /mongo_extend
> #删除软链接# rm -rf Hansight
> ls -th
* mongodb 服务端启动命令：
> nohup mongod --dbpath "/mongo_extend/" --directoryperdb  --journal &

### distinct
> db.getCollection('session').distinct('source_ip',{'timestamp': {'$gte': ISODate('2017-10-20 00:00:00.000Z'), '$lt': ISODate('2017-10-27 00:00:00.000Z')}})

### multi update:
db.ioc.update({tags:{$exists:0}}, {$set: {tags: ['suspecious']}},{multi:1})

### rename a key:
db.ioc.update({'producer': 'malware feed'}, {'$rename': {'detecion_ratio':'detection_ratio'}}, {multi:1})

### is type list:
The trick is in "dot notation", where you ask for the 0 index element of the array to $exists
{'tags.0':{$exists:0}},

### mongo collection status
> db.collection.stats()

### mongo regex
$regex
`db.getCollection('scan').find({'banner.module': {'$regex':'.*dahua.*'}}, {'_id': 0, 'ip_str':1})`

~~~
{
    "ns" : "HanSight.ioc",
    "count" : 32009532,
    "size" : 46768430144.0,
    "avgObjSize" : 1461,
    "storageSize" : 47941619408.0,
    "numExtents" : 43,
    "nindexes" : 13,
    "lastExtentSize" : 2146426864,
    "paddingFactor" : 1.0,
    "systemFlags" : 0,
    "userFlags" : 1,
    "totalIndexSize" : 23223200336.0,
    "indexSizes" : {
        "_id_" : 1024444624,
        "index_1" : 1557274544.0,
        "ioc_hashed" : 1488694256.0,
        "timestamp_1" : 1517498304.0,
        "provider_1" : 1488538912.0,
        "tags_1" : 1932389424.0,
        "producer_1" : 1802906112.0,
        "additional_data_1" : 904527232,
        "type_1" : 1010341024,
        "type_1_timestamp_-1_index_1" : 2643709600.0,
        "lasttime_-1" : 2078175680.0,
        "lasttime_-1_producer_1" : 2736744304.0,
        "lasttime_-1_producer_1_type_1" : 3037956320.0
    },
    "ok" : 1.0
}
~~~

### mongo index size
> db.collection.totalIndexSize()

### restart
`sudo service mongodb restart`

### mongo example
`db.scan.aggregate([ {'$match':{'tags':'proxy'}}, {'$project': {'_id':0, 'country_name':1}}, {'$group':{'_id':'$country_name', 'count':{'$sum':1}}},{'$sort': {'count':-1}} ])`

~~~
> db.ipinfo_new02.aggregate([
  {'$limit':10000},
  {'$project': {'portlist':1}},
  {'$unwind':'$portlist'},
  {'$group':{'_id':'$portlist.transport','count':'$sum':1}}}
  ])
{ "_id" : null, "count" : 1128 }
{ "_id" : "tcp", "count" : 10367 }
{ "_id" : "udp", "count" : 483 }
~~~

~~~
db.ioc.aggregate([
  {'$project':  {'ioc': 1, '_id': 0}},
  {'$group': {'_id':'$ioc'}},
  {'$group': {'_id':null, 'count': {'$sum': 1}}} ],
  {allowDiskUse:true})
~~~


### mongostat
```
ti@ti:~/GitHub/Tools$ mongostat
connected to: 127.0.0.1
insert  query update delete getmore command flushes mapped  vsize    res faults      locked db idx miss %     qr|qw   ar|aw  netIn netOut  conn       time
     8     *0     *0     *0       0     2|0       0   496g   992g  8.07g      1 HanSight:59.9%          0       1|0     0|1   588b     3k    26   10:14:31
    10     *0     *0     *0       0     1|0       0   496g   992g  8.08g      1 HanSight:92.4%          0       2|0     0|1     1k     3k    26   10:14:33
```

### mongo create unique index
db.collection.createIndex({'key': 1}, { unique: true})
```
> db.members.createIndex( { "user_id": 1 }, { unique: true } )

> db.members.insert({'user_id':1,'name':'nanhe'})

> db.members.insert({'name':'kumar'})

> db.members.find();
{ "_id" : ObjectId("577f9cecd71d71fa1fb6f43a"), "user_id" : 1, "name" : "nanhe" }

{ "_id" : ObjectId("577f9d02d71d71fa1fb6f43b"), "name" : "kumar" }

> db.members.insert({'user_id':1,'name':'aarush'})
WriteResult({ "nInserted" : 0, "writeError" : { "code" : 11000, "errmsg" : "E11000 duplicate key error collection: student.members index: user_id_1 dup key: { : 1.0 }" } })
```


### 复合索引与单索引
1. 索引的建立以牺牲插入（insert）和更新（update）时间已经部分存储空间为代价，换来查询（find）时更高的效率。
2. 建立索引应该以选择性为原则，即所建索引在搜索时能够筛选掉的数据越多则索引越有效。
3. 复合索引中第一个索引可视作单索引，但是之后的都不行。比如复合索引‘producer_1_lasttime_-1’可以提高producer的查询效率， 但是对lasttime的查询没有提升作用。


### pymongo 遇到doc不能json化的问题
可解决 ObjectId、datetime等JSONEncodeError问题。
```
import json
from bson import json_util
import pymongo

clt = pymongo.MongoClient()['HanSight']['ioc']
doc = clt.find_one()
doc_str = json.dumps(doc, default=json_util.default)
print doc_str
print json.loads(doc_str, object_hook=json_util.object_hook)
```

### mongo全网监听（在共网上需要安全配置）
`mongod --bind_ip 0.0.0.0 --dbpath data/db`
