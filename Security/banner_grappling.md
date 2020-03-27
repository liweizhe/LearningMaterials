# banners
Banner grabbing is a technique used to gain information about a computer system on a network and the services running on its open ports. Administrators can use this to take inventory of the systems and services on their network. However, an intruder can use banner grabbing in order to find network hosts that are running versions of applications and operating systems with known exploits.

[tutorial](http://blog.csdn.net/zixuanfy/article/details/52506228)


# 设备指纹
针对移动互联网推广与运营中所面临的设备识别与追踪的问题，数字设备指纹技术成为了行业关注的焦点。业内设备指纹技术一般采用Javascript代码或SDK，在客户端主动地收集与设备相关的信息和特征，通过对这些特征的识别来辨别不同的设备和相关用户。这种主动式设备指纹技术有其特有的优点和适用场景，但是在实际的应用中，也暴露出了一些不足与局限。

主动式设备指纹技术需要在客户端上植入自己的Javascript或SDK代码，主动收集设备相关的特征，用以标识设备和用户。在特征的选取上，需要考虑特征的稳定性和准确度。理想的特征应该在一定的时间段内不会因为外界的条件变化、或是用户的操作行为而发生变化，同时在不同的设备上具有显著的差异。通常可用的特征有：
* 浏览器本身的特征，包括UA，版本，操作系统信息等；
* 浏览器中插件的配置，主要是插件的类型与版本号等；
* 浏览器的Canvas特征，影响该特征的因素有GPU特性造成的渲染差异，屏幕的分辨率以及系统不同字体的设置等；
* 系统flash的配置；
* 设备的传感器特征，比如麦克风、加速传感器的特征等；
* 设备操作系统的特征，比如是否越狱等；
* 设备的网络配置；

主动式设备指纹技术已经在互联网领域得到了大量的应用，但与此同时该项技术本身固有的一些局限性也逐步显现出来：
* 主动式设备指纹技术存在用户隐私相关的风险，其原因是该技术需要在客户端收集设备和用户的相关信息。该风险不仅包括用户的隐私被收集、泄露和滥用的风险，也包括因为违反Apple和Google的用户隐私保护政策而造成APP下架的风险。
* 主动式设备指纹技术不能实现Web与APP间的设备关联。由于嵌入Web页面的Javascript代码和移动APP中的SDK收集的设备特征不同，导致生成的设备指纹标识符也不相同。从而造成了同一设备上Web访问和APP使用的相关事件无法关联在一起，限制了主动式设备指纹技术使用的范围。
* 主动式设备指纹技术在欺诈与反欺诈的对抗中，处于被动应对的状态。欺诈者可以通过反编译等技术，破解客户端中嵌入Javascript代码和SDK，知晓设备指纹算法选取的特征，从而在欺诈与反欺诈的攻防战中占据主动的优势地位。
