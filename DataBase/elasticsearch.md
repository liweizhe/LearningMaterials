
### list indexes
> curl -XGET 'localhost:9200/\_cat/indices?v&pretty'  

### cat specific index information
> curl -XGET 'localhost:9200/\_cat/indices/cif.observables*?v&s=index&pretty'  

### delete index
> curl -XDELETE 'localhost:9200/twitter?pretty'

### check cluster health
> curl -XGET 'localhost:9200/\_cluster/health?pretty'

### change virtual memory
sudo sysctl -w vm.max_map_count=262144


### search query
    query = {"query": {"match_all": {}},
    "sort": ["_doc"]}
               search_by_id = {
                 "query": {
                   "term": {
                     "_id": ""
          }
      }
    }
    search_by_info = {
      "size": "1",
      "sort": [{"lasttime": "desc"}],
      "query": {
           "bool": {
               "must": [
                   {"match": {"observable": "0.0.0.0"}},
                   {"match": {"provider": ""}},
                   {"match": {"confidence": ""}},
                   # {"match": {"tags": ""}}
                  ]
              }
          }
        }


        {
    "query": {
        "exists" : { "field" : "user" }
      }
    }
