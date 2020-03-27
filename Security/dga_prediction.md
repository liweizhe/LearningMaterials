# DAG Classifier
> [source code](https://github.com/rrenaud/Gibberish-Detector)  
> 训练集 conficker_alexa_training.txt， alexa top 10k 为反例，其余为正例

### 基本特征
> * 随机性和熵  
* gibberish detection 判断一个字符串是不是能用人类语言念出来  
>> [source code](https://github.com/rrenaud/Gibberish-Detector)
> * 连续 vs 分散  
* n-gram 平均排名  
* [马尔可夫链](http://en.wikipedia.org/wiki/Markov_chain)
* 领域特征: ccTLD
