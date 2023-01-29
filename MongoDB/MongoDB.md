# MongoDB

## 安装

- 这里我们使用的Mac 安装 直接修改环境变量即可

```javascript
vim ~/.zprofile 进入环境变量配置文件
// 这里 就是bin 下面就是我们的一些命令 mongod 启动的 mongo 开启客户端的  
export MONGODB_HOME=/usr/local/mongoDB
export PATH=$PATH:$MONGODB_HOME/bin
```

- 除了以上配置 我们还要新建数据存储目录 和日志存储目录

- 然后启动的时候 如下

```javascript
--dbpath 指定我们的存储目录  --logpath 指定我们的日志存储目录 --fork 后台启动
mongod --dbpath /usr/local/var/mongodb --logpath /usr/local/var/log/mongodb/mongo.log --fork
```

- 停止服务

```javascript
// 通过 命令查看 mongo的启动id
ps -ef | grep mongo
// 通过 kill 杀掉进程

也可以通过 mac 活动的监视器 关掉进程

mongod --port=27017 --dbpath=/usr/local/var/mongodb --shutdown

也可以通过 mongo 客户端 来 进入到 admin 库执行命令关闭
db.shutdownServer()

```

## 配置文件启动

```js
1. 新建配置文件 mongo.conf 格式遵循yaml

systemLog:
  destination: file
  path: /usr/local/var/log/mongodb/mongo.log
  logAppend: true
storage:
  dbPath: /usr/local/var/mongodb
  engine: wiredTiger #存储引擎
  journal: 
    enabled: true
net:
  bindIp: 0.0.0.0
  port: 27017
processManagement:
  fork: true
```

- 启动命令

```js
// 配置文件目录 
mongod -f /usr/local/mongo.conf
```

## 组成

```markdown
1. 主要 有库名称 组成 show dbs 显示所有数据库
2. 每个库下面 又有集合组成(可以理解为表) show tables 显示表名
3. db 显示当前所在的库
4. 切换数据库 use 数据库名称 如果没有这个数据库 会自动创建
5. 查看 版本 db.version()
6. show users 显示当前数据库的用户列表
7. show roles 显示当前数据库的角色列表 需要切换到 admin 库查看
8. show profile 显示最近的操作
```

## 集合操作

```markdown
1. show collections 或者 show tables 显示集合
2. db.createCollection('emp') 创建一个集合
3. db.集合名称.drop() 删除集合

4. 创建集合命令 db.createCollection(name, options) 有两个参数 第一个是 集合的名称 第二个 options如下

capped 布尔 可选 如果为true 创建固定的集合 环形集合 如果达到最大数 会覆盖第一个
size 数字 可选 给集合指定一个最大值 以字节计算
max 数字 指定集合包含文档的最大数量
```

## 安全认证

```markdown
1. 可以给指定的数据库指定用户和密码
2. 需要切换到 admin 数据库
3. 使用 db.createUser({user:'fox',pwd:'fox',roles:['root']})
4. show users 查看用户
5. db.dropUser('fox') 删除用户
```

### 常用权限列表

```markdown
read 允许用户读取指定数据库
readWrite 允许用户读写指定数据库
dbAdmin 允许用户在指定的数据库中 执行管理函数 如索引创建 删除 查看 统计或访问 system.profile
dbOwner 允许用户在指定的数据库中执行任意 操作 增删改查等
userAdmin 允许用户像 system.user集合中写入 可以在指定数据库里创建 删除 和管理用户
clusterAdmin 只在admin 数据库中可用 赋予用户所有分片和复制集相关函数的管理权限
readAnyDatabase 只在 admin 数据库中可用 赋予用户所有的数据库 读 权限
readWriteAnyDatabase 只在 admin数据库中可用 赋予用户所有数据库的读写权限
userAdminAnyDatabase 只在 admin 数据库中可用 赋予所有数据库 userAdmin 权限
dbAdminAnyDatabase 只在admin数据库中可用 赋予用户所有的数据库的dbAdmin权限
root 只在admin数据库中可用 超级账号 超级权限
```

### 权限启动

```markdown
1. 启动的时候 需要用权限启动
mongod -f /usr/local/mongo.conf --auth
2. 连接的时候 需要指定库户密码 这样在进入的时候就可以看到数据库的信息了 如果用mongo连 什么也看不到
mongo -ufox -pfox --authenticationDatabase=admin
```

## 创建数据库

```mongodb
使用use 创建数据库的时候 最开始是存放在内存中的 如果该数据库中没有集合 那么 show dbs 是显示不出来创建的数据库
admin 存放权限 local 集群的时候 永远不会复制 config 都是mongo默认的数据库


use 数据库名称  如果有此名称的数据库 就会自动切换到该数据库 如果没有 则创建一个新的数据库
use articledb 创建了一个叫 articledb 的数据库。
show dbs 查看所有数据库
db 查看 当前 所使用的数据库

db.dropDatabase() 删除数据库 去要切换到 该数据库
```

## 集合操作

- 显示创建

```mongodb
db.createCollection(name)
在当前数据库下 创建一个 test 的集合
db.createCollection('test')
```

- 显示集合

```mongodb
show collections || show tables
```

- 删除集合

```mongodb
db.集合名称.drop()

db.test.drop()
如果返回true。则删除成功
```

## 集合CRUD

### 单条插入

```mongodb
db.集合.insert(JSON格式)
db.集合.save(JSON格式)

db.comment.save({"articleid":"1000","content":"今天天气真好,阳光明媚","nickname":"北城韩雨"})
WriteResult({ "nInserted" : 1 }) 插入成功

db.comment.insert({"articleid":"1000","content":"天气真不错","nickname":"墨晓邪"})
WriteResult({ "nInserted" : 1 }) 插入成功
```

### 批量插入

```mongodb
db.集合.insertMany([{},{}])

db.comment.insertMany([{"articleid":"10030","content":"天气真不错","nickname":"墨晓邪2"},{"articleid":"10200","content":"天气真不错","nickname":"墨晓邪1"}])
```

### 批量插入错误

```mongodb
如果在使用批量插入的时候 某一条失败了 是不会回滚的 所以我们可以使用try catch 来执行批量插入

try{
	db.comment.insertMany([{"articleid":"10030","content":"天气真不错","nickname":"墨晓邪2"},{"articleid":"10200","content":"天气真不错","nickname":"墨晓邪1"}])
} catch(e) {

}
```



### 查询

```mongodb
db.集合.find() 查询所有

db.comment.find()
```

### 单条查询

```mongodb
db.集合.find({"nickname":'北城韩雨'})

db.comment.find({"nickname":'北城韩雨'})
```

### 查询第一条

```mongodb
如果有多个nickname 叫北城韩雨 那么 只会返回查询到的第一条
db.comment.findOne({"nickname":'北城韩雨'})

```

### 投影查询

```mongodb
如果 查询的出来的数据 字段 太多 此时我们希望之显示其中一些字段 就可以用投影查询

如下命令查询出来 就只会显示 所有 天气真不错 数据 只显示content 字段 和_id
如果添加 _id:0 则 _id 不会显示
db.comment.find({"content":"天气真不错"},{"content":1,"nickname":1,'_id':0})

下面是 查询comment 集合下所有的数据 但是 值显示 content字段
db.comment.find({},{"content":1,"nickname":1,'_id':0})
```

### 单条更新

```mongodb
db.集合名称.update(query,update,options)

query 是你的查询条件 找到 id 为 xxx 的数据 更新 content字段

覆盖更新 就是整条文档 都会变成你更新的字段和内容 更新完毕之后 整条数据就剩下  content":'我是更新的内容'
db.comment.update({_id:ObjectId("63134cfb21379141cc5a48c9")},{"content":'我是更新的内容'})

局部更新 需要用$set 包裹起来

db.comment.update({_id:ObjectId("63134c4f705d46618761cfd3")},{$set:{"content":'我是更新的内容'}})
```

### 多条更新

```mongodb
如果查询出来content 是多条数据 那么 添加 multi:true 就可以把多条数据都改成 nickname:北城韩雨

db.comment.update({"content" : "天气真不错"},{$set:{"nickname":"北城韩雨"}},{multi:true})
```

### 列值增长修改

```mongodb
点在的时候 数据库里的数据 需要自增

每次点赞 id 为 3 的 likenum 字段 都会加1
db.comment.update({"id" : "3"},{$inc:{"likenum":numberInt(1)}})
```

### 删除

```mongodb
db.集合.remove()
全部删除
db.集合.remove({})

按条件删除
db.comment.remove({"content":"天气真不错"})
```

### 统计查询

```js
统计查询使用 count()方法 可以查询 集合里有多少条数据

整体查询
db.test.count() 

按条件查询 age 为30的数据

db.test.count({"age":30})
```

### 分页查询

```javascript
//可以使用limit方法 来读取指定数量的数据 使用skip方法来跳过指定数量的数据

//返回指定条数 默认返回条数 是20
db.test.find().limit(3)

// 表示前三条数据不要
db.test.find().skip(3)
// 表示一共查3条 但是 要跳过第一条 去查三条
db.test.find().limit(3).skip(1)
```

### 排序查询

```javascript
sort方法 对数据进行排序 并且使用1 -1 来指定排序方式 1 代表升序 -1 代表降序
// 按userid为降序的查询 likenum 为升序查询
db.test.find().sort({userId:-1,likenum:1})
```

## 更多查询

### 正则查询

- mongodb 的模糊查询是通过正则的方式来实现的

```javascript
查询匹配正则的所有数据

查询出 content 字段 厘米包含是我文字的 所有数据
db.test.find({content:/是我/})
```

### 比较查询

```javascript
< <= > >=
  
db.test.find({id:{&gt:value}})  // 查询id 大于value 的数据
db.test.find({id:{&lt:value}})  // 查询id 小于 value的数据
db.test.find({id:{&gte:value}})  // 查询id 大于等于 value的数据
db.test.find({id:{&lte:value}})  // 查询id 小于等于 value的数据
db.test.find({id:{&ne:value}})  // 查询id 不等于 value的数据
```

### 包含查询

```js
包含使用$in  不包含 使用$nin
查询id 包含 1 或者 2 的数据
db.test.find({"id":{$in:["1","2"]}})

```

### 条件查询

```javascript
// 当我们需要查询同时满足两个以上条件 需要使用$and操作符 来进行关联

$and :[{查询字段1}，{查询字段2}]

// 查询 country_id 并且 code 为 6 的数据
db.test.find({$and:[{"country_id":"226"},{"code":"6"}]})

// 当我们需要或者查询的时候 可以是用 $or
查询 country_id 为226 或者  code 为 6 的数据 如果 第一个条件没有 就会查第二个
db.test.find({$or:[{"country_id":"226"},{"code":"6"}]})
```

## 索引

### 概述

```markdown
如果没有索引 mongodb 必须执行全集合扫描 及扫描集合中的每条数据 
```

### 索引类型

```javascript
单字段索引
复合索引
其他索引 地理空间索引 文本索引 哈西索引
```

### 索引的操作

- 索引的查看

```javascript
db.test.getIndexes()

[
    {
        "v" : 2, // 索引引擎的版本号
        "key" : { // 在_id字段上加的索引 1 代表升序的方式
            "_id" : 1
        },
        "name" : "_id_", // 索引的字段名
        "ns" : "map.test" // 索引存放的位置。map库下 的 test集合里
    }
]
```

### 创建索引

```javascript
db.集合.createIndex(keys,options)

给id 添加一个 升序的索引 
db.test.createIndex({"id":1})
// 再次查询索引
[
    {
        "v" : 2,
        "key" : {
            "_id" : 1
        },
        "name" : "_id_",
        "ns" : "map.test"
    },
    {
        "v" : 2,
        "key" : {
            "id" : 1.0
        },
        "name" : "id_1",
        "ns" : "map.test"
    }
]

添加复合索引 id是升序索引 name 是 降序索引

db.test.createIndex({"id":1,"name":-1})


```

### 索引移除

```javascript
db.集合.dropIndex(index)
db.test.dropIndex({"id":1})
```

### 移除所有索引

```javascript
db.test.dropIndexes()
```

## 索引的使用

### 执行计划

```javascript
在查询的时候 想知道 我们建立索引之后 查询的性能 是否有效 就需要通过执行计划来查看
```

```javascript
db.集合.find(query,options).explain(options)

db.test.find({"id":1}).explain()
// 返回如下
{
    "queryPlanner" : {
        "plannerVersion" : 1,
        "namespace" : "map.test",
        "indexFilterSet" : false,
        "parsedQuery" : {
            "id" : {
                "$eq" : 1.0
            }
        },
        "queryHash" : "6DAB46EC",
        "planCacheKey" : "6DAB46EC",
         // 主要是看这里 stage 显示的 COLLSCAN 代表文档扫描 没有用到索引
        "winningPlan" : {
            "stage" : "COLLSCAN",
            "filter" : {
                "id" : {
                    "$eq" : 1.0
                }
            },
            "direction" : "forward"
        },
        "rejectedPlans" : []
    },
    "serverInfo" : {
        "host" : "beichenghanyudeMacBook-Pro.local",
        "port" : 27017,
        "version" : "4.2.21",
        "gitVersion" : "b0aeed9445ff41af07449fa757e1f231bce990b3"
    },
    "ok" : 1.0
}
```

```javascript
{
    "queryPlanner" : {
        "plannerVersion" : 1,
        "namespace" : "map.test",
        "indexFilterSet" : false,
        "parsedQuery" : {
            "id" : {
                "$eq" : 1.0
            }
        },
        "queryHash" : "6DAB46EC",
        "planCacheKey" : "801B9D84",
        "winningPlan" : {
          	// 这里能看到 就是通过索引去查询的
            "stage" : "FETCH",
            "inputStage" : {
                "stage" : "IXSCAN",
                "keyPattern" : {
                    "id" : 1.0
                },
                "indexName" : "id_1",
                "isMultiKey" : false,
                "multiKeyPaths" : {
                    "id" : []
                },
                "isUnique" : false,
                "isSparse" : false,
                "isPartial" : false,
                "indexVersion" : 2,
                "direction" : "forward",
                "indexBounds" : {
                    "id" : [ 
                        "[1.0, 1.0]"
                    ]
                }
            }
        },
        "rejectedPlans" : []
    },
    "serverInfo" : {
        "host" : "beichenghanyudeMacBook-Pro.local",
        "port" : 27017,
        "version" : "4.2.21",
        "gitVersion" : "b0aeed9445ff41af07449fa757e1f231bce990b3"
    },
    "ok" : 1.0
}
```





