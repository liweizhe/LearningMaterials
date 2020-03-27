#!/bin/bash
#这样吧，你们让客户把要查询的ip、domain存到文件里，每行一个ip或domain，不要其他字符，我写个脚本自动把结果跑出来写到文件里。
# curl -H "Content-Type: application/json" -X POST -d '{"iocs":["8.8.8.8", "baidu.com"]}' http://172.16.100.32:80/ti/bulkapi
echo "hello"
lst=()
cat "/Users/lwz/KeepLearning/markdown/ip.txt" | while read line
do
  #echo "File:$line"
  lst+=$line
  echo $line
done
echo 'hhhhh'
#echo $lsts
echo ${lst[@]}
echo 'hhhh'
for l in $lst;do
  echo $l
done
