# 开发cli

## 设置全局变量

- 要想可以向vue那样 执行全局的命令 比如 vue create xxx这样 我们需要做如下步骤

```markdown
1. 使用npm 创建一个工程  创建一个 bin 的文件夹 里面  可以写一个文件
2. 在这个文件 首行需要写入 #! /usr/bin/env node  告诉电脑 用node执行这个文件 当然这里也可以用shell 之类的
3. 在package.json 里 需要 写入bin字段 然后里面key 配置你的命令 指向 你当前工程的bin文件里的文件
4. 最后 使用npm link 把你的包链接到全局 
```

![](F:\新笔记\cli\img\1.png)

```json
{
  "name": "waze",
  "version": "1.0.0",
  "description": "",
  "main": "index.js",
  // 指向当前工程下 bin 下的 文件 这个文件 顶部要写入   #! /usr/bin/env node 
  "bin": {
    "waze": "./bin/waze"
      //这里面可以写多个命令
  },
  "scripts": {
    "test": "echo \"Error: no test specified\" && exit 1"
  },
  "keywords": [],
  "author": "",
  "license": "ISC"
}

```

## 删除全局变量

```js
unlink waze 即可
```



