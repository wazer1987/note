# Node.JS开发指南

## 全局对象

```markdown
1.  javascript 中有一个特殊的对象 成为全局对象 它及其所有属性都可以在程序的任何地方访问 即全局变量 在浏览器Javascript 中 通常 window 是全局对象
2. 而Node.JS 全局对象是 global 所有全局变量 都是golbal的对象属性 
```

### process

```markdown
1. 用于描述当前Node.js 进程状态的对象 提供了一个与操作系统的简单接口 
```

#### process.argv

```js
1. process.argv 是命令行参数的数组 第一个元素是 node 第二个元素 是脚本文件名称 第三个参数就是每一个元素的运行参数 
```

```js
// 命令行输入
node argv.js 1991 name=byvoid --v "Carbo Kuo"
// argv.js 打印如下 
console.log(process.argv);
// 输出如下
[ 'node', 
 '/home/byvoid/argv.js', 
 '1991', 
 'name=byvoid', 
 '--v', 
 'Carbo Kuo' ]
```

#### process.nextTick(callback)

```markdown
1. 如果这个事件占用大量的 CPU 时间，执行事件循环中的下一个事件就需要等待很久，因此 Node.js 的一个编程原则就是尽量缩短每个事件的执行时间。process.nextTick() 提供了一个这样的工具，可以把复杂的工作拆散，变成一个个较小的事件。
```

#### process.env

```markdown
1. 这个变量 来轻松访问shell环境下的变量
```

```js
一个最常见的环境变量 就是 NODE_ENV 该变量用来控制程序是运行在开发模式下 还是 产品模式下

process.env.NODE_ENV  'production'
```

#### process.exit

```markdown
1. 要让一个应用退出 可以调用 process.exit 并提供一个退出代码 比如当发生错误时 要退出程序 这个时候最好使用退出代码1
```

```js
console.error('An error occurred')
process.exit(1)
```



### util模块

```markdown
1. util 是一个 Node.js 核心模块，提供常用函数的集合，用于弥补核心 JavaScript 的功能过于精简的不足
```

#### util.inherits(constructor, superConstructor)

```markdown
1. 一个实现对象间原型继承的函数。 已经弃用
```

#### **util.inspect** 

```markdown
1. 是一个将任意对象转换为字符串的方法，通常用于调试和错误输出。
```

```js
util.inspect(object,[showHidden],[depth],[colors])
1. 必须要传一个参数 object
2. showHidden 如果为true 将会输出更过隐藏信息
3. depth 如果对象很复杂 可以指定递归层数
4. colors 为 true 输出格式将会以ANSI颜色编码
```

### 事件驱动 events

```markdown
1. events 是 Node.js 最重要的模块，没有“之一”，原因是 Node.js 本身架构就是事件式的，而它提供了唯一的接口，所以堪称 Node.js 事件编程的基石。
```

### 事件发射器

```markdown
1. events 模块只提供了一个对象： events.EventEmitter。
```

```js
var events = require('events'); 
var emitter = new events.EventEmitter(); 
// 2. 订阅
emitter.on('someEvent', function(arg1, arg2) { 
 console.log('listener1', arg1, arg2); 
}); 
emitter.on('someEvent', function(arg1, arg2) { 
 console.log('listener2', arg1, arg2); 
}); 
// 1. 触发
emitter.emit('someEvent', 'byvoid', 1991);
```

```js
EventEmitter.on(event, listener) 为指定事件注册一个监听器，接受一个字符串 event 和一个回调函数 listener。

EventEmitter.emit(event, [arg1], [arg2], [...]) 发射 event 事件，传递若干可选参数到事件监听器的参数表。
                                          
EventEmitter.once(event, listener) 为指定事件注册一个单次监听器，即监听器最多只会触发一次，触发后立刻解除该监听器。   
EventEmitter.removeListener(event, listener) 移除指定事件的某个监听器，listener 必须是该事件已经注册过的监听器。

EventEmitter.removeAllListeners([event]) 移除所有事件的所有监听器，如果指定 event，则移除指定事件的所有监听器。
```

### **error** 事件

```js
// 抛送 error 事件

var events = require('events'); 
var emitter = new events.EventEmitter(); 
emitter.emit('error'); 
运行时会显示以下错误：
node.js:201 
 throw e; // process.nextTick error, or 'error' event on first tick 
 ^ 
Error: Uncaught, unspecified 'error' event. 
 at EventEmitter.emit (events.js:50:15) 
 at Object.<anonymous> (/home/byvoid/error.js:5:9) 
 at Module._compile (module.js:441:26) 
 at Object..js (module.js:459:10) 
 at Module.load (module.js:348:31) 
 at Function._load (module.js:308:12) 
 at Array.0 (module.js:479:10) 
 at EventEmitter._tickCallback (node.js:192:40)
```

### 文件系统fs

```markdown
1. fs 模块是文件操作的封装，它提供了文件的读取、写入、更名、删除、遍历目录、链接等 POSIX 文件系统操作。
2. fs 模块中所有的操作都提供了异步的和同步的两个版本。
3. 有sysc 的就是 同步方法
```

#### **fs.readFile** 

```markdown
1. fs.readFile(filename,[encoding],[callback(err,data)])是最简单的读取文件的函数。
```

```js
filename 读取的文件名称
encoding 可选 文件的字符编码 如果不传 则callback 就是第二个参数 如果指定了编码形式 回调函数里的data 就是解析后的字符串 否则 data 将会是以buffer形式表现的二进制数据
callback 回调函数 用于接收文件内容 
```

```js
var fs = require('fs'); 
fs.readFile('content.txt', function(err, data) { 
 if (err) { 
 console.error(err); 
 } else { 
 console.log(data); 
 } 
}); 
假设 content.txt 中的内容是 UTF-8 编码的 Text 文本文件示例，运行结果如下：
<Buffer 54 65 78 74 20 e6 96 87 e6 9c ac e6 96 87 e4 bb b6 e7 a4 ba e4 be 8b>
```

#### fs.readFileSync

```markdown
1. fs.readFile 的同步版本
2. 如果出现错误 需要用 try catch 处理
```

#### fs.open

```markdown
1. fs.open(path, flags, [mode], [callback(err, fd)])是 POSIX open 函数的封装，与 C 语言标准库中的 fopen 函数类似。它接受两个必选参数，path 为文件的路径，flags 可以是以下值
```

```markdown
flags 的 参数
r ：以读取模式打开文件。
r+ ：以读写模式打开文件。
w ：以写入模式打开文件，如果文件不存在则创建。
w+ ：以读写模式打开文件，如果文件不存在则创建。
a ：以追加模式打开文件，如果文件不存在则创建。
a+ ：以读取追加模式打开文件，如果文件不存在则创建

mode 参数
参数用于创建文件时给文件指定权限，默认是 0666
权限 
文件权限指的是 POSIX 操作系统中对文件读取和访问权限的规范，通常用一个八进制数来表示。例如 0754 表示文件所有者的权限是 7 （读、写、执行），同组的用户权限是 5 （读、执行），其他用户的权限是 4 （读），写成字符表示就是
-rwxr-xr--
```

#### fs.read

```markdown
1. fs.read(fd, buffer, offset, length, position, [callback(err, bytesRead, buffer)])是 POSIX read 函数的封装，相比 fs.readFile 提供了更底层的接口。
2. 可以从指定的文件描述符fd中读取数据并写入buffer执行的缓冲区对象
3. offset 是buffer写入的偏移量
4. length 是要从文件中读取的字节数
5. position是文件读取的起始位置 如果为null 从当前文件指针位置读取
6. 回调函数传递bytesRead 和 buffer 分别表示读取的字节数和缓冲区对象
```

#### fs.readdir

```markdown
fs.readdir(__dirname,(err,files) => {
	files 文件目录下的文件列表
})
```

#### fs.stat

```js
1. 检查文件是否存在
2. 第一个参数 是文件路径和文件名称 第二个参数 是回调 
```

```js
const fs = require('fs')
// 1. 读取当前目录下的文件
fs.readdir(process.cwd(),function(err,files){
    console.log('')
    // 2. 如果文件没有 就跳出
    if(!files.length){
        return console.log('    \033[31m No files to show!\033[32m\n')
    }
    console.log('Select which file or directory you want to see\n')
    function file (i){
        // 3. 如果文件有 
        var filename =  files[i]
        // 4. 要检查一下 是文件夹还是文件
        fs.stat(__dirname+'/'+filename,function(err,stat){
            if(stat.isDirectory()){
                // 这里打印出来 蓝色的的是文件夹
                console.log('   '+i+'    \033[36m' + filename + '/\033[39m')
               
            }else{
                // 这里打印出来 灰色的的是文件
                console.log('   '+i+'    \033[90m' + filename + '/\033[39m')  
            }   
            i++
            if(i == files.length){
                // 这里就开始 出 写入流了 可以 在 命令行里 输入命令
                console.log('')
                process.stdout.write('  \033[33mEnter your choice:\033[39m')
                process.stdin.resume()
            }else{
                file(i)
            }           
        })
    }
    file(0)
})
```

#### fs.watchFile \ fs.watch

```markdown
1. 主要用来 监视文件 或者文件目录有没有改变
```

```js
查找工作目录下所有的css文件 然后监视其是否发生改变

const fs = require('fs')
// 读取目录 
const files = fs.readdirSync(process.cwd())
files.forEach( file => {
    if(/\.css/.test(file)){
        // 如果是css的文件 就监控 看遍了 就输出changed
        fs.watchFile(process.cwd() + '/' + file,() => {
            console.log('-' + file + 'changed')
        })
    }
})
```



## ANSI转义码

``` 
1. 主要是 让终端(命令行文本呈现不同颜色)
```

```js
console.log('\033[90m' + data.replace(/(.*)/g,'$1') + '\033[39m')
\033 表示转移序列开始
[ 表示开始颜色设置
90 便是前景色为亮灰色
m 表示颜色设置结束
最后用的是39  表示 用来讲颜色在设置回去 只对部分文本着色
```



## HTTP服务端与客户端

```markdown
1. http.Server 是一个基于事件的 HTTP 服务器，它的核心由 Node.js 下层 C++ 部分实现，而接口由 JavaScript 封装，兼顾了高性能与简易性。
2. http.request 则是一个HTTP 客户端工具，用于向 HTTP 服务器发起请求。
```

### HTTP服务器

```markdown
1. http.Server 是 http 模块中的 HTTP 服务器对象，用 Node.js 做的所有基于 HTTP 协议的系统，如网站、社交应用甚至代理服务器，都是基于 http.Server 实现的。它提供了一套封装级别很低的 API，仅仅是流控制和简单的消息解析，所有的高层功能都要通过它的接口来实现。
```

```js

```



