# wget use proxy
### Via ~/.wgetrc file:
>use_proxy=yes  
http_proxy=127.0.0.1:8080  
### or via -e options placed after the URL:
>wget ... -e use_proxy=yes -e http_proxy=127.0.0.1:8080 ...


# use ti bulkapi
>curl -H "Content-Type: application/json" -X POST -d '{"iocs":["8.8.8.8", "baidu.com"]}' http://172.16.100.32:80/ti/bulkapi
