# 模块化设计
## 新建模块
进入根目录，执行：

`php think build --module demo`

生成 `demo` 模块，目录树如下：
```
➜  ixmrc_yxwj git:(master) ✗ tree application/demo
application/demo
├── common.php    #模块公共文件
├── config.php    #模块配置文件
├── controller    #控制器目录
│   └── Index.php
├── model         #模型目录
└── view          #视图目录
```
# 六、模型与关联
对象-关系映射(Object/Relation Mapping, ORM for short)。
一般来说，每个数据表会和一个“模型”对应。
## 6.1 模型定义
```
namespace app\index\model;
use think\Model;
class User extends model
{
  protected $table = 'think_user';
}
```
## 6.2基础操作
### 6.2.1 新增数据
```
<?php
namespace app\index\controller

use app\index\model\User as UserModel

public function add()
{
  $user['nickname'] = 'lwz';
  $user['email'] = 'lwz@qq.com';
  $user['birthday'] = strtotime('1996-08-06');
  if($result = UserModel::create($user)){
    return $result->nickname.' added!';
  }else{
    return 'add failed!';
  }
}
```
### 6.2.2 批量新增
```
public function addList()
{
  $user = new UserModel;
  $list = [
    ['nickname'] => 'hsh', 'email' => 'hsh@qq.com', birthday => strtotime('2002-10-16'),
    ['nickname'] => 'wyx', 'email' => 'wyx@qq.com', birthday => strtotime('2000-01-01'),
  ];
  if ($user->saveAll($list)){
    return 'add list succeed!';
  }else{
    return $user->getError();
  }
}
```
### 6.2.3 查询数据
基础查询
```
public function read($id='')
{
  $user = UserModel::get($id);
  echo $user->nickname.'<br/>';
  echo $user->email.'<br/>';
  echo date('Y/m/d',$user->birthday).'<br/>';
}
```
复杂查询，使用查询构建器
```
public function read()
{
  $user = UserModel::where('nickname','lwz')->find();
  echo $user->nickname.'<br/>';
  echo $user->email.'<br/>';
  echo date('Y/m/d',$user->birthday).'<br/>';
}
```
### 6.2.4 数据列表
```
public function index()
{
  $list = UserModel::all();
  foreach ($list as $user){
    echo $user->nickname.'<br/>';
    echo $user->email.'<br/>';
    echo date('Y/m/d',$user->birthday).'<br/>';
    echo '------------------------------<br/>';
  }
}
```
### 6.2.5 更新数据
```
public function update($id)
{
  $user = UserModel::get($id);
  $user['nickname'] = 'lwzlwz';
  $user['email'] = 'lwz@hotmail.com';
  if(false !== $user->save()){
    return 'update succeed';
  }else{
    return $user->getError();
  }
}
```
更高效的方法
```
public function update($id)
{
  $user['id']= (int)$id;
  $user['nickname'] = 'lwzhsh';
  $user['email'] = 'lwz@hotmail.com';
  $result = UserModel::update($user);
  return 'update succeed!';
}
```
### 6.2.6 删除数据
```
public function delete($id)
{
  $result = UserModel::destroy($id);
  if($result){
    return 'delete succeed!';
  }else{
    return 'user not exists!';
  }
}
```
## 6.3 读取器和修改器
命名方法：`set/get + 属性名的驼峰命名 + Attr`
### 6.3.1 读取器
使用读取器功能可以简化数据处理操作
```
<?php

namespace app\index\model;

user think\Model;

class User extends Model
{
  protected function getBirthdayAttr($birthday)
  {
    return date('Y-m-d', $birthday);
  }
}
```
### 6.3.2 修改器
修改器可以在写入数据前进行格式转换处理
```
<?php

namespace app\index\model;

user think\Model;

class User extends Model
{
  protected function setBirthdayAttr($value)
  {
    return strtotime($value);
  }
}
```
## 6.4 类型转换和自动完成
### 6.4.1 类型转换
可以不定义任何修改器和读取器完成格式转换
```
<php?

namespace app\index\model;

user think\Model;

class User extends Model
{
  protected $type = [
    'birthday' => 'timestamp:Y/m/d',
  ];
}
```
### 6.4.2 自动时间戳
```
<php?

namespace app\index\model;

user think\Model;

class User extends Model
{
  protected $type = [
    'birthday' => 'timestamp:Y/m/d',
  ];
  protected $createTime = 'create_at';
  protected $updateTime = 'update_at';
}
```
### 6.4.3 自动完成
新增时自动写入
```
<?php
namespace app\index\model;

use think\Model;

class User extends model
{
    protected $insert = ['status' => 1]
}
```
属性|描述
:-:|:-:
auto|新增及更新的时候自动完成
insert|仅新增的时候自动完成
update|仅更新的时候自动完成

配合修改器进行条件判断自动完成：
```
<?php
namespace app\index\model;

use think\Model;

class User extends Model
{
  // 定义自动完成的属性
  protected $insert = ['status']
  // status 属性修改器
  protected function setStatusAttr($value, $data)
  {
    return 'lwz' == $data['nickname'] ? 1 : 2;
  }
  // status 属性读取器
  protected function  getStatusAttr($value)
  {
    $status = [ -1 => '删除', 0 => '禁用', 1 => '正常', 2 => '待审核'];
    return $status[$value];
  }
}
```
## 6.5 查询范围
### 6.5.1
常用查询封装成查询范围简化操作，以邮箱地址 lwz@qq.com 和 status=1 两个查询条件为例，查询
范围方法的定义规范为：`scope + 查询范围名称`
```
<?php
namespace app\index\model;

use think\Model;

class User extends Model
{
  // email 查询
  protected function scopeEmail($query)
  {
    $query->where('email', 'lwz@qq.com');
  }
  // status 查询
  protected function scopeStatus($query)
  {
    $query->where('status', 1);
  }
}
```
修改控制器的 index 方法：
```
public function index()
{
  $list = UserModel::scope('email, status') ->all();
  foreach ($list as $user){
    echo $user->nickname.'<br/>';
    echo $user->email.'<br/>';
    echo $user->birthday.'<br/>';
    echo $user->status.'<br/>';
    echo '--------------------<br/>';
  }
}
```
组合而成的查询语句是：
```
SELECT * FROM `think_user` WHERE `email` = 'lwz@qq.com' AND 'status' = 1
```
支持多次调用 scope 方法，并且可以追加新的查询及链式操作，例如：
```
public function index()
{
  $list = UserModel::scope('email')
      ->scope('status')
      ->scope(function ($query)){
        $query->order('id', 'desc')
      }
      ->all()
  foreach ($list as $user){
    echo $user->nickname.'<br/>';
    echo $user->email.'<br/>';
    echo $user->birthday.'<br/>';
    echo $user->status.'<br/>';
    echo '--------------------<br/>';
}
```
查询范围方法支持额外参数：
```
// email 查询
protected function scopeEmail($query, $email = '')
{
  $query -> where('email', $email)
}
```
调用方式如下：
```
$list = UserModel::scope('email', 'lwz@qq.com') ->all();
```
### 6.5.2 全局查询范围
在模型类中添加静态的 base 方法即可实现全局查询：
```
<?php
namespace app\index\model;

use think\Model
class User extends Model
{
  protected static function base($query)
  {
    //查询状态为 1 的数据
    $query->where('status', 1)
  }
}
```

## 6.6 输入和验证
### 6.6.1 表单提交
创建视图模板文件 `application/index/view/user/create.html`:
```
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Create User</title>
    <style>
        body{
            font-family: "Microsoft Yahei", "Helvetica Neue", Helvetica, Arial, sans-serif;
            font-size: 16px;
            padding: 5px;
        }
        .form{
            padding: 15px;
            font-size: 16px;
        }
        .form.text{
            padding: 3px;
            margin: 2px 10px;
            width: 240px;
            height: 24px;
            line-height: 28px;
            border: 1px solid #D4D4D4;
        }
        .form.btn{
            margin: 6px;
            padding: 6px;
            width: 120px;

            font-size: 16px;
            border: 1px solid #D4D4D4;
            cursor: pointer;
            background: #eee;
        }
        a{
            color: #868686;
            cursor: pointer;
        }
        a:hover{
            text-decoration: underline;
        }
        h2{
            color: #4288ce;
            font-weight: 400;
            padding: 6px 0;
            margin: 6px 0 0;
            font-size: 28px;
            border-bottom: 1px solid #eee;
        }
        div{
            margin: 8px;
        }
        .info{
            padding: 12px 0;
            border-bottom: 1px solid #eee;
        }
        .copyright{
            margin-top: 24px;
            padding: 12px 0;
            border-top: 1px solid #eee;
        }
    </style>
</head>
<body>
<h2>Create User</h2>
<form method="post" class="form" action="{:url('index/user/add')}">
    昵称:<input type="text" class="text" name="nickname"><br/>
    邮箱:<input type="text" class="text" name="email"><br/>
    生日:<input type="text" class="text" name="birthday"><br/>
    <input type="hidden" name="__token__" value="{$Request.token}"/>
    <input type="submit" class="btn" value="Submit">
</form>
    <div class="copyright">
        <a title="Personal Website" href="http://huangshihan.com">HSH</a>
        <span>LOVE</span>
        <span>{U Forever}</span>
    </div>
</body>
</html>
```
User 控制器增加新的操作方法 create 如下：
```
public function create()
{
  return view();
}
```
### 6.6.2 表单验证
添加 User 验证器，位于`application/index/validate/User.php`:
```
<?php
namespace app\index\validate;
use think\Validate

class User extends Validate
{
    protected $rule = [
      ['nickname', 'require|min:5', '昵称不能为空|不能短于5个字符'],
      ['email', 'checkMail:qq.com', '邮箱格式错误'],
      ['birthday', 'dataFormat:Y-m-d', '生日格式错误'],
    ];
    protect function chechMail($value, $rule)
    {
      $result = preg_math('/^\w+([-+.]\w+)*@'.$rule.'$/', $value);
      if (!$result){
        return 'email can just be '.$rule;
      }else{
        return true;
      }
    }
}
```
### 6.6.3 控制器验证
验证器类不变，修改控制器类：
```
namespace app\index\controller;

use app\index\model\User as UserModel;
user think\Controller;

class User extends Controller
{
  public function create()
  {
    return view();
  }
  public function add()
  {
    $data = input('post.');
    $result = $this->validate($date, 'User');
    if (true !== $result){
      return $result;
    }
    $user = new UserModel;

    $user->allowField(true)->save($data);
    return $user->nickname.' add succeed!';
  }
}
```
# 7 关联
## 7.1 基本定义
关联采用对象化的操作模式，无需继承不同的模型类，只需把关联定义成一个方法，即可直接通过当前模型
对象的属性名获取定义的关联数据。以用户模型 User 用于许多模型对象 Book 为例：
```
<?php
namespace app\index\model;

use thin\Model;

class User extends Model
{
  public function books()
  {
    return $this->hasMany('Book')
  }
}
```

* 一对一关联：`HAS_ONE`与相对的`BELONGS_TO`
* 一对多关联：`HAS_MANY`与相对的`BELONGS_TO`
* 多对多关联：`BELONGS_TO_MANY`
### 7.1.1 一对一关联
以每个‘用户’拥有一份‘档案’为例建立数据表：
```
DROP TABLE IF EXISTS `think_user`;
CREATE TABLE IF NOT EXISTS `think_user`(
  `id` int(6) UNSIGNED NOT NULL AUTO_INCREMENT,
  `nickname` varchar(25) NOT NULL,
  `name` varchar(25) NOT NULL,
  `password` varchar(50) NOT NULL,
  `create_time` int(11) UNSIGNED NOT NULL,
  `update_time` int(11) UNSIGNED NOT NULL,
  `status` tinyint(1) DEFAULT 0,
  PRIMARY KEY (`id`)
  )ENGINE=MyISAM DEFAULT CHARSET=utf8

DROP TABLE IF EXISTS `think_profile`;
CREATE TABLE IF NOT EXISTS `think_profile`(
  `id` int(6) UNSIGNED NOT NULL AUTO_INCREMENT,
  `truename` varchar(25) NOT NULL,
  `birthday` int(11) NOT NULL,
  `address` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `user_id` int(6) UNSIGNED NOT NULL,
  PRIMARY KEY (`id`)
  )ENGINE=MyISAM DEFAULT CHARSET=utf8;
```
### 7.1.2 关联定义
User 模型类中添加关联定义方法，在方法中调用 hasOne 方法：
```
<?php
namespace app\index\model;

use think\Model;

class User extends Model
{
  // 定义关联方法
  public function profile()
  {
    return $this->hasOne('Profile');
  }
}
```
hasOne 具有 5 个参数，依次为：

`hasOne('关联模型名'， ‘关联外键’， ‘主键’， ‘别名定义’， ‘join类型’)`

默认的外键为：__当前模型名_id__,主键则是自动获取
