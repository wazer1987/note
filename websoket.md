# Websoket

```markdown
1. 一种 服务端 和 客户端保持 适时 通信 协议
2. 在没有 Websokt 之前 我们只采用 HTTP通信 协议 实现双工通信有三种方法
3. 轮询 iframe 和 EventSource 流
```

## 轮询

```markdown
1. 原理就是 用定时器 发请求 然后 后端相应
2. 以下 nodejs 起的服务
```

### 后端代码

```js
let express = require('express');
let app = express();
// http://localhost:8000/ 静态资源目录 http://localhost:8000 的时候 就会访问该目录下的 index.html
app.use(express.static(__dirname));
//  /clock 请求  前台会访问 这个接口  然后 给前台返回时间 
app.get('/clock',function(req,res){
   res.send(new Date().toLocaleString())
});
app.listen(8000);
```

### 前台代码

```html
1. 开启定时器 每一秒钟 就会去 请求 /clock 接口

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Document</title>
</head>
<body>
    <div id="clock"></div>
<script>
let clock = document.querySelector('#clock');
 // 开启定时器 不停的去 /clock 发送请求  然偶拿到结果 把数据渲染在页面上
 setInterval(function(){
    let xhr = new XMLHttpRequest;
    xhr.open('GET','/clock',true);
    xhr.onreadystatechange = function(){
        if(xhr.readyState == 4 && xhr.status == 200){
            clock.innerHTML = xhr.responseText;
        }
    }
    xhr.send();
 },1000);    
</script>    
</body>
</html>

```

## iframe流

```markdown
1. 就是通过 iframe 去请求接口 后台每秒都返回 对应的 script 脚本文件 里面代码体就是 条用我们前台写好的函数
2. 前台定义好的函数 可以拿到后台脚本调用的传参
3. 确定是 因为 请求不会断开 所以 标签页 上 会一直转圈圈
```

### 后台代码

```js
let express = require('express');
let app = express();
// http://localhost:8000/
app.use(express.static(__dirname));
1. 前台的 iframe标签 会一直 请求这个接口 然后后台开始定时 不停的想iframe标签里 调用 html 里写好的函数 
app.get('/clock',function(req,res){
   res.header('Contnet-Type','text/html');
   setInterval(function(){
      2. 这里 parent 代表的就是window setTime 就是我们在html页面里定义好的函数
      3. 这里用 write的原因是 不希望链接关闭  如果用send发送 响应完一次 链接就关闭
      res.write(`
      <script>
         parent.setTime("${new Date().toLocaleString()}");
      </script>
      `);
   },1000);
  
});
app.listen(9000);
```

### 前台代码

```HTML
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Document</title>
</head>
<body>
    <div id="clock" style="border:1px solid red;height:200px;"></div>
    1.这里 iframe 标签就调用了 我们上面的 /clock 接口 然后 返回的脚本里面 执行了下面的函数
    <iframe src="/clock" style="height:0;border:0;"></iframe>
<script>
//window.setTime = 
function setTime(ts){
  document.querySelector('#clock').innerHTML = ts;
}
</script>    
</body>
</html>
```

## EventSource 流

```js
1. 类似 iframe流 也是一种  响应 长连接
2. 不过 不会一直出现 浏览器页签一直转圈圈的情况
```

### 后台代码

```js
let express = require('express');
let app = express();
// http://localhost:8000/

app.use(express.static(__dirname));
app.get('/clock',function(req,res){
  res.header('Content-Type','text/event-stream');
  let counter = 0;
  1. 下面是固定写法 id 就是每个 EventSource 流的id event:message 就是你前台要监听的事件 \n 就是需要换行 data就是你要给发哦是那个的数据  结尾必须有 \n\n 代表结束 就想古代的打字机一样
  let $timer = setInterval(function(){
    res.write(`id:${counter++}\nevent:message\ndata:${new Date().toLocaleString()}\n\n`);
  },1000);
  res.on('close',function(){
     clearInterval($timer);
  });
});
app.listen(7777);
```

### 前台代码

```HTML
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Document</title>
</head>
<body>
<div id="clock"></div>
<script>
  //eventSource 不能跨域 
  let eventSource = new EventSource('/clock');
  let clock = document.querySelector('#clock');
  //监听服务器发过来的消息 因为后台写的是 event:message 所以这里我们就要用 onmessage
  eventSource.onmessage = function(event){
    let message = event.data;
    clock.innerHTML = message;
  }
  eventSource.onopen = function(event){
    console.log('onopen',event.data);
  }
  //监听连接请求失败的错误事件
  eventSource.onerror = function(event){}
</script>    
</body>
</html>
```

## 简单的websoket

## 后台代码

```js
let app = express();
app.use(express.static(__dirname));

app.listen(3000);
服务端这里需要安装 ws 依赖包
let WebSockerServer = require('ws').Server;
let server = new WebSockerServer({port:9999});
// 1. 服务端 建立 链接 
server.on('connection',function(socket){
    console.log('2. 服务器端监听到了客户端的连接');
    //2. 监听客户端发过来的消息
    socket.on('message',function(message){
        console.log('4. 客户端连接过来的消息',message);
        // 3. 给客户端发消息回去
        socket.send('5. 服务器说:'+message);
    });
}); 
```

## 前台代码

```HTML
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>websocket</title>
</head>
<body>
<script>
     1. 建立一个 WebSoket链接  注意端口号要相同 支持跨域
     let socket = new WebSocket('ws://localhost:9999');
     socket.onopen = function(){
        2. 打开链接 然后给服务端发送消息 
        console.log('1. 客户端连接上了服务器');
        socket.send('hello');
     }
	    3.  监控到了 服务端发来的消息
     socket.onmessage = function(event){
        console.log(event.data);
     }
</script>
</body>
</html>
```

## ws原理

```js
1. 我们首先要知道 响应头的意思
```

```HTML
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>websocket</title>
</head>
<body>
<script>
     let socket = new WebSocket('ws://localhost:9999');
     socket.onopen = function(){
        console.log('1. 客户端连接上了服务器');
        socket.send('hello');
     }

     socket.onmessage = function(event){
        console.log(event.data);
     }
</script>
</body>
</html>
```

```markdown
1. 前端 建立链接 是 websoket链接 就会向后端发送固定的响应头
2. 其实请求头的每行都带有 换行符号 /r/n 只不过浏览器没有显示而已

3. 告诉服务我简历一个 websoket链接
GET ws://localhost:8888/ HTTP/1.1/r/n
4. 告诉后端 我要升级协议
Connection: Upgrade/r/n
5. 我升级的协议是什么协议
Upgrade: websocket/r/n
6. 然后告诉我的协议的版本号是多少
Sec-WebSocket-Version: 13/r/n
7. 最后发送他给密钥
Sec-WebSocket-Key: O/SldTn2Th7GfsD07IxrwQ==/r/n
/r/n
```

```markdown
1. 后端接收到我们的请求头以后 需要返回对应固定的格式 我们先看一下格式 在来 书写对应的代码


HTTP/1.1 101 Switching Protocols
1. 和前端发送的请求头 一一对应
Upgrade: websocket
Connection: Upgrade
2. 拿到 前端请求头的  Sec-WebSocket-Key 完成加密 最后返回给前端
Sec-WebSocket-Accept: H8BlFmSUnXVpM4+scTXjZIwFjzs= 

```

### 实现

```js
1. 引入网络链接模块
let net = require('net');
2. 这个是加密的字符串 其实就是把前端传过来的 Sec-WebSocket-Key: O/SldTn2Th7GfsD07IxrwQ==/r/n 进行加密
let CODE = '258EAFA5-E914-47DA-95CA-C5AB0DC85B11';
3. 加密的类
let crypto = require('crypto');
4. 开始创建链接
let server = net.createServer(function(socket){
    //once来自于EventEmitter on once 就链接一次
    5. 这里的data就是前台的请求头也就是我们上面的那些
    socket.once('data',function(data){
        data  = data.toString();
        6. 这里 如果匹配到了 你是要升级协议 我们就返回对应的响应头
        if(data.match(/Connection: Upgrade/)){
            7. 开始分割 加工响应头
            let rows = data.split('\r\n');
            rows = rows.slice(1,-2);
            let headers = {};
            rows.reduce((memo,item)=>{
                let [key,value] = item.split(': ');
                memo[key] = value;
                return memo;
            },headers);
            8. 开始 判断版本号  然后开始加密
            if(headers['Sec-WebSocket-Version'] == '13'){
                let secWebSocketKey = headers['Sec-WebSocket-Key'];
                let secWebSocketAccept = crypto.createHash('sha1').update(secWebSocketKey+CODE).digest('base64');
                let response = [
                    'HTTP/1.1 101 Switching Protocols',
                    'Upgrade: websocket',
                    'Connection: Upgrade',
                    `Sec-WebSocket-Accept: ${secWebSocketAccept}`,
                    '\r\n'
                ].join('\r\n');
                9. 最后返回响应头
                socket.write(response);
            }
        }
    });
});

server.listen(9999);
```

## socket.io

```js
1. 实现 聊天室功能
2. 私聊 功能
3. 聊天记录入库
```

### 后端

```js
1. 这里我们知道 socket 链接第一次还是基于http 所以我们直接 把我们的链接 注册到 express 的 http 即可
2. 这里要安装 socket.io
```

```js
var app = require('express')();
1. 创建一个http 服务 开始http握手
var server = require('http').Server(app);
2. 把socket.io 链接到http上
var io = require('socket.io')(server);
3. 开始 80 端口
server.listen(80);
4. 访问 / 的时候 就去返回 index.html文件
app.get('/', function (req, res) {
  res.sendfile(__dirname + '/index.html');
});
5. 建立链接
io.on('connection', function (socket) {
  socket.emit('news', { hello: 'world' });
  socket.on('my other event', function (data) {
    console.log(data);
  });
});
```

### 前端

```js
1. 我们刚才完成了 服务端的注册
2. 因为我们这里不是前后段分离的 所以在加载库的时候 前台也会 加载到一个 /socket.io/socket.io.js 的包 我们要请求服务的这个包
```

```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@3.3.7/dist/css/bootstrap.min.css">
    <style>
         .user{
             color:green;
             cursor: pointer;
         }
    </style>
    <title>聊天室</title>
</head>
<body>
<div class="container" style="margin-top:30px">
</div> 
 1. 这里前台 就会 去后台请求这个包 这里就拿到了 socket 这个对象
<script src="/socket.io/socket.io.js"></script>
<script>
</script>
</body>
</html>
```

### 建立链接

```markdown
1. 后端代码
```

```js
var app = require('express')();
var server = require('http').Server(app);
var io = require('socket.io')(server);

server.listen(80);

app.get('/', function (req, res) {
  res.sendfile(__dirname + '/index.html');
});
1. 开始建立链接 回调参数的 socekt 可以理解为 是每个客户端
io.on('connection', function (socket) {
  2. 开始广播 消息 使用 emit 每个 客户段都会收到消息
  socket.emit('news', { hello: 'world' });
  socket.on('my other event', function (data) {
    console.log(data);
  });
});
```

```markdown
1. 前端代码
2. 这里前端 需要开辟一个自己的空间  可以理解为 数据自己的客户端链接
```

```js
1. 监听到了 后天服务器 广播的 news 时间 然后是消息 然后 开始 向服务广播 事件 是 my other event 
2. 然后服务端 也可以 监听到 my other event 事件 并且 可以拿到 参数
socket.on('news', function (data) {
    console.log(data);
    socket.emit('my other event', { my: 'data' });
});
```

### send方法

```markdown
1. send 其实 就是 emit 语法糖 事件名称就是 message
2. emit('事件名称',参数) 就用 on('事件名称') 
```

### 后端

```js
var app = require('express')();
var server = require('http').Server(app);
var io = require('socket.io')(server);

server.listen(80);

app.get('/', function (req, res) {
  res.sendfile(__dirname + '/index.html');
});

io.on('connection', function (socket) {
  console.log('进入链接了')
  1. 这里就是emit的语法糖 前台 on(message) 就能监听到 send  
  socket.send( { hello: 'world' });
  socket.on('message', function (data) {
    console.log(data,'前台发来的消息');
  });
});
```

### 前端

```HTML
<script>
    var socket = io.connect('http://localhost');
    socket.on('message', function (data) {
        console.log(data,'===后台发来的消息');
        socket.send({ my: '我是客户端发来的消息' });
    });
</script>
```

## 聊天室

```markdown
1. 前台 用的 bootstrap 样式
2. 简单就是 有个发言按钮 和输入框 到时候都能发送消息
```

### 前端

```js
// 1. 拿到按钮  和消息
        let textMsg = document.querySelector('#textMsg');
        let sendBtn = document.querySelector('#sendBtn');
        // 3. 消息列表
        let messageList = document.querySelector('#messageList');
        var socket = io.connect('http://localhost');
        socket.on('message', function (data) {
      // 4. 逻辑就是 服务段 收到 你发来的消息 就开始 用send 去发送 然后 客户端 监听到之后 就向ul 标签里插入消息
            let li = document.createElement('li');
            li.innerHTML = getMessage(data);
            li.className = 'list-group-item';
            messageList.appendChild(li);

        });
        // 2. 发送消息
        function sendMsg() {
            let content = textMsg.value
            socket.send(content)
        }
        // 3. 拿到服务端发送过来的消息 插入到ul 里面
        function getMessage(msgObj) {
            return `<li>${msgObj}</li>`;
        }
        function handleKeyUp(){

        }
```

### 后端

```js
1. 在拿到客户端所有的消息时候 服务端 使用 io.emit 就可以向所有的 socket客户端 进行广播
2. 客户端 会 监听到 message 就做对应的消息插入
```

```js
var app = require('express')();
var server = require('http').Server(app);
var io = require('socket.io')(server);

server.listen(80);

app.get('/', function (req, res) {
  res.sendfile(__dirname + '/index.html');
});

io.on('connection', function (socket) {
  1. 监听到 客户端发来的消息之后 服务端 向所有的客户端 广播消息 每个客户端就能看到了
  socket.on('message', function (data) {
    io.emit('message',data)
  });
});
```

## 私聊

```markdown
1. 这里我们知道 每个客户段过来之后都会有自己的链接
2. 回调参数的 sokcket 就 可以理解为每个客户端标识
3. 所以我们在每次链接的时候 就把每个 客户端的链接建立表示 
4. 然后客户@谁的时候 就拿到标识 去找到他自己对应的 socket 去广播 就可以做到私聊
```

### 后端

```js
这里 存放 所有的 socket 客户端 都有标识
let sockets = {}
io.on('connection', function (socket) {
  let username
  socket.on('message', function (data) {
    if(username){
        // 4. 第二次进来 用户名已经有人了 我们这里私聊是 @xxx:内容 这种方式 进行私聊开始匹配 你@的谁 和发送的内容
        let result = content.match(/@([^ ]+) (.+)/)
        if(result){
            //5. 拿到 你@的人 拿到 你 要给他发送的内容
            let toUser = result[1]
            let toContent = result[2]
            //6. 然后去找到 你@的那个对应的 socket 也就是 你@的 那个 客户端 
            let toSocket = sockets[toSocket]
            //7. 然后 让他自己的 socket 广播自己 就拿到了私聊效果
            toSocket && toSocket.emit('message',getMsg(toContent,username))
        }else{
            io.emit('message',getMsg(content,username))
        }
    }else{
        // 1. 第一次进来 先拿到 客户端的用户名 这里我们 默认 以你第一次发送的内容为用户名
        username = content
        // 2. 把自己的用户名 和自己的 socket 做个关联 等到私聊的时候可以去这里面找要私聊的人
        sockets[username] = socket
        // 3. 这里是广播 自己看不到 别人都可以看到 说加入了聊天室
        socket.broadcast.emit('message',getMsg(`${username}加入聊天室`))
    }
  });
});
```



