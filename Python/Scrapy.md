# 创建项目
`scrapy startproject MySpiders`
目录树如下
```
➜  GitHub tree MySpiders
MySpiders
├── MySpiders
│   ├── __init__.py
│   ├── __pycache__
│   ├── items.py
│   ├── middlewares.py
│   ├── pipelines.py
│   ├── settings.py
│   └── spiders
│       ├── __init__.py
│       └── __pycache__
└── scrapy.cfg
```
* scrapy.cfg: 项目的配置文件
* tutorial/: 该项目的python模块。之后您将在此加入代码。
* tutorial/items.py: 项目中的item文件.
* tutorial/pipelines.py: 项目中的pipelines文件.
* tutorial/settings.py: 项目的设置文件.
* tutorial/spiders/: 放置spider代码的目录


# Attention!!!!
Scrapy does not process TBODY in Xpath and CSS selector!!!

`It is because tbody is tag automatically added by browsers like Firefox and Chrome!!!`


# 模拟登陆
使用Selenium和ChromeDriver填写用户名和密码，实现登录练习页面，然后将登录以后的Cookies转换为JSON格式的字符串并保存到Redis中
