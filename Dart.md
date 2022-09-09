## Dart 环境安装 ##

```markdown
1. 去官网下载就好  https://dart.cn/get-dart#release-channels
2. 如果下载是解压好的文件 直接需要配置环境变量即可
3. 验证 dart --version  出现如下就是成功了
Dart SDK version: 2.17.5 (stable) (Tue Jun 21 11:05:10 2022 +0200) on "windows_x64"
4. 生态网站 https://pub.dev
```

## dart 基础语法 ##

```mariadb
1. dart 的 所有的代码运行环境 都在 main 函数里面开始执行
2. dart 的类型声明是放在前面
3. 打印的函数 是 print()
4. 函数和参数都有类型的声明
5. 每行代码结束的时候 必须要写一个结束的分号
6. 运行方式 可以 使用命令行 dart + 文件 运行 
7. dart 的 万物皆是对象 变量是 一个引用 变量存储的是对象的引用
8. 如果一个变量声明 没有赋值 就是 null
9. 变量的值 不会进行隐式转换
```

```dart
void main () {
   print('hellow dart');
} 
```

- 注释

```markdown
1. 单行注释 //
2. 多行注释 /****/
3. 文档注释 /// 可以通过 dartdoc 转换成 markdow文档  
```

### 变量声明 ###

- var

```dart
1. var 声明的变量 没有变量提升的概念
2. 只是单纯的表示  声明的值 类型不固定  是一个动态类型
```

- dynamic

```markdown
1. 和 var 声明变量一样 都是 不确定类型
```

### 常量声明 ###

- const

```markdown
1. 声明一个常量
2. 只能声明 编译时的值
```

- final

```markdown
1. 也是常量声明的关键字
2. 运行时的值也可以
```

- const 和final的却别

```markdown
1. const 不可以声明 正在运行时的值 比如时间戳
```

```dart
const time  = DateTime.now()  // 这里会报错
final time  = DateTime.now()  // 不会报错
```

## 数据类型 ##

- 数据类型

```markdown
1. Number
2. String
3. Boolean
4. List
5. Set
6. Map
7. 其他
```

 ###  Number ###

```markdown
1. dart 中的主子由三个关键字描述
2. num 既可以是整数
3. int 必须是整数
4. double 浮点数 也可以用来表示整数
5. number 上面会有一些常用的api 比如求绝对值啊 转换成字符串 四舍五入啊 等等
```

```dart
void main(List<String> arg) {
  // 声明整数
  int count = 3;
  print(num);
    
  // 声明浮点数
  double price = 3.3;
  double price1 = 3;
  print(price);
  print(price1); //这里会打印 3.0

  // 如果不清楚 是整数 还是浮点数 就可以用num 来声明
  num n1 = 3.3;
  num n2 = 3;
}
```

- 一些常用数字api 

```dart
void main(List<String> arg) {
  // 类型转换
  print(n1.toString()); // 转换为字符串

  print(3.8.toInt()); // 转成整型 不过是向下取整

  // 四舍五入
  print(3.1415826.round());
  print(3.1415826.toStringAsFixed(4)); // 保留四位小数

  // 返回余数
  print(10.remainder(4)); // 2

  // 数字比较 0 相同 1 大于 -1 小于
  print(10.compareTo(12));
}

```

### String ###

```markdown
1. 可以通过 String 声明
2. 单引号 和双引号都可以
3. 三个引号也可以声明包含换行符的字符串
4. 正则表达式 RegExp(r'正则表达式') 需要写一个小写的r RegExp(r'\d+')
```

```dart
void main(List<String> args) {
  // 声明字符串

  String str1 = 'hello,world';
  print(str1);
  String str2 = "你好";
  print(str2);
  print(str2);

  // 通过 3个引号声明字符串 可以是三个单引号 也可以是三 3个装引号

  String str3 = '''
    我是多行文字
    看见我换行了吧
  ''';
  print(str3);  // 这里打印就是换行的字符串
}
```

- 一些常用的字符串api 

```js
void main(List<String> args) {
  // 声明字符串

  String str1 = 'hello,world';
  print(str1);
  String str2 = "你好";
  print(str2);
  print(str2);

  // 通过 3个引号声明字符串 可以是三个单引号 也可以是三 3个装引号

  String str3 = '''
    我是多行文字
    看见我换行了吧
  ''';
  print(str3);

  // 字符串拼接
  print(str1 + str2);

  //模板字符串 直接用$即可

  print('$str1 $str2');

  // 字符串分割

  print(str1.split('')); // 这里会分割成数组

  // 字符串的裁切

  print('   abc   '.trim()); // 可以去除左右两边的空格

  // 判断字符串是否为空

  print(''.isEmpty); // 判断字符串是为空 true
  print(''.isNotEmpty); // 判断字符串不为空 false

  String str4 = '我是教育';
  print(str4.replaceAll('教育', '替换')); // 这里也支持正则 就是把教育替换成 替换
  String str5 = 'time out';
  print(str5.indexOf('o')); // 找到索引 lastindexof 从后面向前找索引
  print(str5.contains('out')); // 查找字符串 看看包含这个字符串
}

```

### List ### 

```markdown
1. List 就是数组
2. 可以使用泛型 来限制数组中的类型
3. 构造函数的方式
```

```dart
void main(List<String> args) {
  // 字面量方式
  List list = [];
  // 规定类型
  List list1 = <int>[123];
  // 构造函数 这个数组是否具有成长性 growable: false 是不能添加数据的
  // 这里面传递的是一个命名参数
  List list2 = List.empty(growable: true);
  list2.add(1);
  print(list2);
  // 通过填充的方式去声明列表 第一个参数 是长度 第二个参数是你的填充的数字
  List L4 = new List.filled(3, 6);
  print(L4); // [6,6,6 ]
  // 扩展操作符

  var L5 = [7, ...L4];
  print(L5); //[7, 6, 6, 6]
  // 断言
  var L6; // L6声明了没有赋值 是null
  //这里null 是不能扩展的 所以会报错   [0,...L6]
  // 扩展运算符后面加一个? 就可以 先判断 L6有无值
  var L7 = [0, ...?L6];
  print(L7); // [0]
  // 打印列表的长度
  print(L7.length);

  // 如果反转之后 会变成一个小括号的集合 已经就不是一个列表了 我们可以使用.toList() 变成列表

  print(L7.reversed); // 打印 (0)
  print(L7.reversed.toList()); // [0]
  // 添加元素
  List L8 = [1, 2, 3];
  L8.addAll([3, 4, 5]);
  // 添加元素 理解为数组的拼接
  print(L8); //  [1, 2, 3, 3, 4, 5]

  // 删除元素
  // 通过 元素来删除
  L8.remove(3); //原有2个3  删除 一个3 还剩一个
  print(L8); // [1, 2, 3, 4, 5]

  // 通过下标来删除
  L8.removeAt(2);
  print(L8); // [1, 2, 4, 5]

  // 插入
  L8.insert(1, 9); // 在下标为1 的后面插入了9  所以2，4，5都向后移动了
  print(L8); // [1, 9, 2, 4, 5]

  // 清空

  L8.clear();
  print(L8); // []

  //  判断是否为空
  print(L8.isEmpty); //true

  // 链接字符串
  List words = ['hello', 'world'];
  print(words.join('-')); // hello-world
}

```

- 遍历

```js
void main(List<String> args) {
  List L1 = [1, 2, 3, 4];
  // 通过for循环去遍历
  for (var i = 0; i < L1.length; i++) {
    print(i);
    print(L1[i]);
  }
  ;
  print('--------------');
  // 通过 for in 去遍历
  for (var element in L1) {
    print(element);
  }
  print('--------------');
  // 通过forEach 去遍历
  L1.forEach((element) {
    print(element);
  });
  print('--------------');
  // 添加元素
  List L2 = <num>[1, 2, 3];
  List L3 = [];
  for (var i = 0; i < L2.length; i++) {
    L3.add(L2[i] * L2[i]);
  }
  print(L3); // [1, 4, 9]
  print('--------------');
  // map
  final L4 = L2.map((e) => e * e);
  print(L4); // (1, 4, 9) 需要 调用.toList
  print('--------------');
  // where 可以返回符合条件的元素
  // 判断数字是否为奇数

  List L5 = <num>[4, 5, 6];
  // 返回是不是奇数
  bool isOdd(n) {
    return n % 2 == 1;
  }

  ;
  var oddNum = L5.where((item) {
    return isOdd(item);
  });
  print(oddNum); //(5) 需要toList
  print('--------------');
  // any  检测 一个条件是否成立 只要一个条件成立即可
  // 检测 是否有奇数
  bool flag = L5.any((element) => element % 2 == 1);
  print(flag);
  print('--------------');

  // erver 检测是 条件是否全部成立
  List L6 = [1, 3, 7];
  bool flag1 = L6.every((element) => element % 2 == 1);
  print(flag1); // 结果为true 如果有一个不成立 那么就是false
  print('--------------');

  // 扩展 主要是把 二维数组 转成一维
  List L7 = [
    [1, 2],
    [3, 4]
  ];
  var nums = L7.expand((element) {
    print(element);
    return element;
  });
  print(nums); // (1, 2, 3, 4)
}
```

### Set

```markdown
1. Set 是一个无序的 元素唯一的集合
2. 声明方式有两种 字面量  和 构造函数两种声明
3. 不能通过下标取值 
4. 有自己独有的操作 可以求两个集合的 交集  并集 和差集
```

- 一些常用的集合api 

```dart
void main(List<String> args) {
  // 通过字面量形式 来声明set
  const nums = <int>{1, 2, 3};
  print(nums);
  print('------------');

  // 通过构造函数
  final fruits = new Set();
  // 向集合添加一个元素
  fruits.add('香蕉');
  fruits.add('苹果');
  fruits.add('橘子');
  // 把集合转列表
  print(fruits.toList());
  print('------------');
  final fruitsList = fruits.toList();
  print(fruitsList.toSet());

  // 集合特有的操作
  final caocao = {'关羽', '郭嘉', '许褚'};
  final liubei = {'关羽', '诸葛亮', '法正'};
  // 交集
  print(caocao.intersection(liubei)); // {关羽}
  // 并集
  print(caocao.union(liubei)); //{关羽, 郭嘉, 许褚, 诸葛亮, 法正}
  // 差集
  print(caocao.difference(liubei));
  // 返回集合的第一个元素
  print(caocao.first); //关羽
}

```

### Map

```markdown
1. 无需的键值对映射 通常被称作哈希或者字典
2. 通过构造函数声明 通过字面量声明
```

```dart

void main(List<String> args) {
  // 字面量 声明 取值 修改
  Map map1 = {'name': 'zhangsan'};
  print(map1); // {name: zhangsan}
  print(map1['name']); //zhangsan
  map1['name'] = 'lisi';
  print(map1['name']); // lisi
  // 通过构造函数
  var p = new Map(); // 新版本中 new 可以省略
  p['name'] = '张三';
  p['age'] = 22;
  print(p); // {name: 张三, age: 22}

  // 访问 不存在的属性为null
  print(p['sex']); // null
  // 判断map中的key 是否存在
  print(p.containsKey('name')); // true
  print(p.containsKey('sex')); // false
  // 可以直接看看value 存在不存在
  print(p.containsValue(22)); // true
  // 如果这个key 不存在 我们就在里面放值
  p.putIfAbsent('kill', () => '敲代码');
  print(p); //{name: 张三, age: 22, kill: 敲代码}

  // 获取map中所有的 key 和 value
  print(p.keys); //(name, age, kill)
  print(p.values); // (张三, 22, 敲代码)

  // 根据条件删除 kill 被删除了 根据key
  p.removeWhere((key, value) => key == 'kill');
  print(p); // {name: 张三, age: 22}
}

```

## 运算符

```markdown
1. 地板除 (~/) 除法向下取整
2. 类型判断运算符 is is!  判断数据是哪个数据类型
3. 避空运算符 ?? ??= 如果一个值是空 就返回不是空的  ??= 如果是空就赋值
4. 条件属性访问 ?. 防止当使用. 预防访问不存在的属性 报错
5. 级联运算符 .. 对连续的api操作 所简化
```

```dart
void main(List<String> args) {
  // 地板除 除法向下取整
  print(7 ~/ 4); // 1 // 除完等于1.75 但是地板除向下取整了 变成 1

  // 类型判断运算符
  List l1 = [];
  // 判断是不是列表
  print(l1 is List); // true
  // 判断不是列表
  print(l1 is! List); //false

  // 避空运算符 永远返回不是 null的值得

  // print(1 ?? 3); // 返回1
  print(null ?? 3); // 返回3
  var foo;
  print(foo ?? 0); // 返回0
  // 带有赋值效果的 避空运算符

  var a;
  // 如果 a 是null 就赋值为3 如果 a 不是 null 则赋值失败
  a ??= 3;
  print(a); //3

  // 条件属性运算符 保护可能为空的属性
  // 当我们使用 . 去访问成员属性的时候 如果没有这个属性会报错
  var num;
  // 下面num 是没有length 的属性的 当我们用.length 的 下面语法就会报错
  // print(num.length);
  print(num?.length); // 采用 条件运算符  就不会报错

  // 级联运算符号 如果我们要给一个对象里设置多个属性 就需要如下操作
  // Set p = {};
  // p.add ('a')
  // p.add ('b')
  // p.remove('b');
  // print(p);

  // 级联运算符就可以这样
  Set p = {};
  p
    ..add('a')
    ..add('b')
    ..remove('b');
  print(p);
  // Map p1 = {};
  // p1.addAll({'name': 'lisi'});
  // print(p1);
}

```

## 函数

```markdown
1. 直接声明 不需要function 关键字
2. 箭头函数 可以写多行 但是要用代码要用都好分割 且结尾不能有分号
3. 匿名函数
4. 立即执行函数
```

```dart
void printInfo() {
  print('我是打印');
}

// 规定返回值
int getNum() {
  return 1;
}

void main(List<String> args) {
  printInfo();

  // 匿名函数

  var myPrint = (value) {
    print(value);
  };
  List fruits = ['苹果', '香蕉', '橘子'];
  fruits.forEach(myPrint);

  // 箭头函数  函数体中不能写分号结束 而且函数体里多行代码要用,都好隔开

  var fn = (value) => {print(value), print('我是每次遍历结果$value')};
  fruits.forEach(fn);

  // 立即执行函数
  ((value) {
    print(value);
  })(3);
}

```

### 函数参数

```markdown
1. 必填参数 参数类型 参数名称
2. 可选参数 放在必选参数后面的参数 通过中括号包裹起来 带默认值的参数
3. 命名参数 用大括号包裹起来 调用函数的时候 传递的名字 需要与声明函数中的名称一致
4. 函数参数
```

```dart
void main(List<String> args) {
  // 必填参数
  // 规定 传递参数必须是个字符串 返回一个字符串
  String userInfo(String name) {
    print(name);
    return name;
  }

  userInfo('张三');
  Map user = {'name': '李四'};
  print(user['name']);

  // 可选参数 可以传也可以不传的参数 用中括号包裹起来
  // 这里age 是可选参数 但是因为我们们有传 所以是null 但是我们又标准了他的类型
  String preson(name, [var age]) {
    return '我的名字是$name,年龄是$age';
  }

  print(preson('张三')); //我的名字是张三,年龄是null

  // 这里也可以赋值一个默认的
  String preson1(name, [var age = 0]) {
    return '我的名字是$name,年龄是$age';
  }

  print(preson1('张三')); // 我的名字是张三,年龄是0

  // 命名参数 用大括号包裹起来 在调用函数的时候 要保证跟声明的时候一致
  String getUserInfo(name, {int age = 20}) {
    return '我的名字是$name,年龄是$age';
  }

  // 传参数的时候要保证 跟声明的时候名字一致
  print(getUserInfo('唐伯虎', age: 10)); //我的名字是唐伯虎,年龄是10 
}

```

### 异步函数

```markdown
1. 使用 future 一个类来实现
2. 也可以使用 async 来使用 只不过是写在命名的后面
```

- future

```dart
// 这个包 是第三方包 所以需要以下的方式引入
import 'dart:convert';

import 'package:http/http.dart' as http;

void main(List<String> args) {
  // 这里就是声明了一个异步函数 跟fetch 差不多
  Future getIpAddress() {
    // 请求一个ip地址返回本机
    final url = 'https://httpbin.org/ip';
    // 这里理解为 返回一个 promise 然后在调用的时候 又可以.then
    return http.get(url).then((Response) {
      // Response 就是响应对象 数据都放在body 里 这里是json 字符串 我们可以用dart 核心包转换以下JOSN对象

      print(Response.body); // { "origin": "222.222.218.199"}
      Map ip = jsonDecode(Response.body);
      return ip;
    });
  }

  getIpAddress().then((ip) {
    print(ip['origin']); //222.222.218.199
  });
}

```

- async await

```dart
// 这个包 是第三方包 所以需要以下的方式引入

import 'package:http/http.dart' as http;

import 'dart:convert';

void main(List<String> args) async {
  // 这里就是声明了一个异步函数 跟fetch 差不多
  Future getIpAddress() async {
    // 请求一个ip地址返回本机
    final url = 'https://httpbin.org/ip';
    // 这里理解为 返回一个 promise 然后在调用的时候 又可以.then
    final Response = await http.get(url);
    return jsonDecode(Response.body);
  }

  var ip = await getIpAddress();
  print(ip); // {origin: 222.222.218.199}
}

```

- 包

```markdown
1. 包都会在 pubspec.yaml 文件里面
2. 添加了包 可以执行 pub get 或者vscode 自动会帮你拉取
```

```yaml
# 名称
name: dart
# dart 版本
environment:
  sdk: '>=2.10.0 <3.0.0'
# 依赖  
dependencies:
  http: ^0.12.2  
```

## 类与对象

```markdown
1. 类
2. 继承
3. 抽象类
4. 接口
5. 混入
6. 泛型
7. 枚举
```

### 类

```markdown
1. 构造器
2. 访问修饰
3. Getter 和Setter
4. 初始化
5. static
6. 元数据
```

- 声明

```dart
// 声明
class Person {
  // 类的属性
  String name = '张三';
  void getInfo() {
    print(this.name);
  }
}

void main(List<String> args) {
  Person p = new Person();
  p.getInfo(); // 张三
}
```

- 构造函数

```markdown
1. dart 构造函数有多种 
2. 默认构造函数 与类同名 在实例化的时候 自动被调用
```

```dart
// 默认构造函数 必须要和 类的名称相同

class Point {
  num x = 0, y = 0;
  Point(x, y) {
    print('默认构造函数');
    this.x = x;
    this.y = y;
  }
}

void main(List<String> args) {
  Point p = new Point(3, 3);
  print(p.x);
}
```

```dart
// 简化写法
class Point {
  num x = 0, y = 0;
  // 这里就等价于我们上面写的this.x =x  
  Point(this.x, this.y);
}

void main(List<String> args) {
  Point p = new Point(3, 3);
  print(p.x);
}

```

- 命名构造函数

```markdown
1. 在类名中使用命名构造器(类名.函数名) 实现多个构造器 可以提供额外的清晰度
2. 可以在实例化构造函数的时候 调用不同的构造器
```

```dart
class Point {
  num? x, y;
  // 命名构造函数 需要 使用类名 加 .的方式来声明
  Point.origin() {
    x = 0;
    y = 0;
  }
  Point.fromJson({num? x, num? y}) {
    this.x = x;
    this.y = y;
  }
}

void main(List<String> args) {
  // 通过命名构造函数 origin 来实例 Point
  Point p1 = new Point.origin();
  print(p1.x);
  // 通过命名构造函数 fromJson 来实例 Point
  Point p2 = new Point.fromJson(x: 3, y: 3);
  print(p2.y);

  // 以上都是调用了不同的构造函数 来实例化了相同的类 这样就可以做到很大的却分
}
```

- 常量构造函数

```markdown
1. 如果类生成的对象 不会改变 那么可以使用常量构造函数
2. 所有的属性必须要用 final 去声明
3. 常量构造函数 要用const 去声明 并且 不能有函数体
4. 调用的时候 通过 const 关键字 去调用
5. 如果使用new 去调用那么就和 普通的类一样
6. 常量不会经过编译 因为声明的时候 就一定知道值了 所以 不会在经过编译计算 效率会高一些
```

```DART
class Point {
  // 属性里面必须都要使用 final 去声明属性
  final num x;
  final num y;
  // 构造函数 要使用const 去声明
  const Point(this.x, this.y);
}

void main(List<String> args) {
  // 使用const  关键字去调用
  Point p1 = const Point(3, 3);
  Point p2 = const Point(3, 3);
  // 因为都是常量 所以 是相等的
  print(p1 == p2); // true

  // 如果使用 new 关键子去实例化 就和普通的类一样
  Point p3 = new Point(3, 3);
  Point p4 = new Point(3, 3);
  print(p3 == p4); // false
}

```

- 工厂构造函数

```markdown
1. 不会自动产生实例 
2. 要通过判断逻辑 去返回固定的实例
3. 通过 factory 去声明 工厂构造函数
4. 工程构造函数中不能使用this 关键字
5. 这里可以理解为一个单列模式
```

```dart
class Person {
  String? name;
  static var incetance;
  factory Person(name) {
    if (Person.incetance == null) {
      Person.incetance = new Person.origin(name);
    }
    ;
    return Person.incetance;
  }
  Person.origin(this.name);
}

void main(List<String> args) {
  var p1 = new Person('关羽');
  print(p1.name); // 关羽
  var p2 = new Person('张飞');
  print(p2.name); // 关羽
}
```

### 修饰符

```markdown
1. dart 中没有 public 都可以访问 protected 类自己和子类访问 private 类自己可以访问
2. 我们在dart 中声明的 属性都是 public
3. 以 _ 开头 命名的属性和方法 都是 private
4. 当声明私有属性或者方法的时候 必须单独抽离出去一个文件 如果不抽离 当声明 类的时候 和main 函数 在同一作用域的时候是不生效的  
5. 我们自己抽屉的模块或这文件 需要放在 最好放在lib中
```

- lib / Person.dart

```dart
class Person {
  num qian;
  // 定义私有属性
  num _money = 100;
  Person(this.qian);
  // 可以i通过调取方法 来访问私有属性
  getMoney() {
    return this._money;
  }
}

```

- 06_privte.dart

```dart
// 可以这样引入
// import './lib/Person.dart';
// 也可以这样
import 'lib/Person.dart';

void main(List<String> args) {
  Person p = new Person(33);
  print(p.qian); // 33
  // 访问私有属性
  // print(p._money); // 报错
  // 调用 方法来访问私有属性  
  print(p.getMoney())
}

```

### Getter 和 Setter

```markdown
1. Getter (获取器) 是通过 get 关键字修饰的方法 函数没有小括号 访问时也没有小括号
2. Setter (修改器) 通过set 关键字修饰的方法 访问时 像设置属性一样给函数传参
3. 使用get 关键字 就可以向访问属性一样
4. 理解中js 的get 和 set 即可
```

```dart
class Circle {
  double pi = 3.14;
  num r = 20;
  get rFn {
    return this.r;
  }

  set setR(value) {
    this.r = value;
  }
}

void main(List<String> args) {
  var r = new Circle();
  print(r.rFn); // 20
  r.setR = 10;
  print(r.rFn);
}
```

### 初始化列表

```markdown
1. 在构造函数中设置属性的默认值
2. 在构造函数体执行之前执行
3. 多个参数 使用都好分割
4. 给类的属性设置默认值
```

```dart
class Ract {
  int width;
  int height;
  //下面的参数就是给 属性设置默认值了 和 可选参数设置默认值差不多  
  Ract()
      : width = 200,
        height = 300 {
    print('${this.width}======${this.height}');
  }
}

void main(List<String> args) {
  var r = new Ract();
}

```

### 重定向构造函数

```markdown
1. 调用我们命名构造函数的时候 让他去调用我们的默认构造函数
2. 这样可以分阶段传参数
```

```dart
class Point {
  num x, y, z;
  // 默认实例化 Point 的时候 需要三个坐标 表示三维
  Point(this.x, this.y, this.z);
  // 当调用命名构造函数的时候 就可以实例化 不过是二维 这里会调用 我们的构造函数 去实例化 实现了 阶段传参
  Point.twoD(num x, num y) : this(x, y, 0);
}

void main(List<String> args) {
  Point p = new Point(10, 20, 30);
  print(p.x);
  // 这里当我们调用命名构造函数的时候 其实他重调用 默认构造函数 然后z 坐标传递的为0
  Point p1 = new Point.twoD(30, 40);
  print(p1.z); // 0
}
```

### static

```markdown
1. 通过static 是静态成员 
2. 直接可以通过 类. 的方式 来访问静态成员 
3. 静态方法不能访问 非静态成员 非静态方法可以访问静态成员
4. 静态方法中不能是用this 关键字 不能使用this关键字 访问 静态属性 
```

```dart
class Person {
  // 静态属性
  static String name = '张三';
  //实例属性
  num age;
  Person(this.age);
  // 静态方法
  static getName() {
    // 这里不能使用 this 去访问 静态成员
    // 静态方法里不能访问 非静态成员
    print(name);
    // 在静态方法里访问 实例成员会报错
    // print(age);
  }

  // 实例方法
  getAge() {
    // 实例方法里可以访问 静态成员
    print(name);
    // 可以调用 静态方法
    getName();
    // 这里也可以不用this 去访问 实例成员
    print(age);
  }

  // 可以通过 实例方法 来返回 静态属性的方式 来访问静态成员
  getStaticName() {
    return name;
  }
}

void main(List<String> args) {
  // 访问 静态成员 和实例方法
  print(Person.name); // 张三
  // 调用 静态返方法
  Person.getName(); // 张三
  Person p = new Person(20);
  print(p.age);
  p.getAge();
}
```

### 元数据

```markdown
1. 一类特殊的语法 以@开头
2. 可以给代码标记一些额外的信息
3. 可以对库 类 构造器 函数 字段 参数 或变量声明的前面
4. @override 重写 @required 必填 @deprecated 弃用
```

```dart
class Phone {
  //可能项目最开始的时候 使用的是 activate 方法 后来这个方法不用了 使用 turnOn 这里我们就标注元数据为 deprecated 表示这个方法启用
  @deprecated
  activate() {
    this.turnOn();
  }

  turnOn() {
    print('开机');
  }
}

void main(List<String> args) {
  var p = new Phone();
  p.activate(); // 如果是编辑器里 这里会打上下划线
}

```

### 继承 

```markdown
1. 根据先后顺序 分为父类 和子类
2. 子类通过extends关键字 继承父类 继承后 子类可以使用父类中 可见的内容
3. 子类中如果复写了父类的方法 要通过@overrid 原数据标记
4. 子类中 可以通过super关键字来引用父类中 可见的内容属性
```

```dart
class Father {
  String name = '刘备';
  num monry = 1000;
  sayName() {
    print('我的名字是$name,我有好$monry');
  }
}

// 继承之后 就有了Fater里的属性和方法了
class Son extends Father {}

void main(List<String> args) {
  var p = new Father();
  print(p.name);
  p.sayName();
  var s = new Son();
  print(s.name);
  s.sayName();
}
```

- 复写

```dart
class Father {
  String name = '刘备';
  num monry = 1000;
  sayName() {
    print('我的名字是$name,我有好$monry');
  }
}

// 继承之后 就有了Fater里的属性和方法了
class Son extends Father {
  // 这里标注了以下 复写了父类的方法  
  @override
  sayName() {
    // TODO: implement sayName
    print('复写了父类的方法');
  }
}

void main(List<String> args) {
  var p = new Father();
  print(p.name);
  p.sayName();
  var s = new Son();
  print(s.name);
  s.sayName();
}

```

### super

```markdown
1. super 理解为 父类 可以通过super 去调用父类中的属性和方法
```

```dart
class Father {
  String name = '刘备';
  num monry = 1000;
  sayName() {
    print('我的名字是$name,我有好$monry');
  }
}

// 继承之后 就有了Fater里的属性和方法了
class Son extends Father {
  @override
  sayName() {
    print(super.name); // 这里打印的就是 父类Fahter 中的 name 字段 为刘备
    super.sayName();
    // TODO: implement sayName
    print('复写了父类的方法');
  }
}

void main(List<String> args) {
  var p = new Father();
  print(p.name);
  p.sayName();
  var s = new Son();
  print(s.name);
  s.sayName();
}

```

```dart
// 通过super 传参 重定向到 父类构造函数

class Father {
  String name = '刘备';
  num monry = 1000;
  String job;
  Father(this.job);
  sayName() {
    print('我的名字是$name,我有好$monry');
    print('我的工作是$job');
  }
}

// 如果父类写了构造函数 子类构造函数需要重定向到父类的构造函数
class Son extends Father {
  Son(job) : super(job);
  @override
  sayName() {
    print(super.name); // 这里打印的就是 父类Fahter 中的 name 字段 为刘备
    super.sayName();
    // TODO: implement sayName
    print('复写了父类的方法');
  }
}

void main(List<String> args) {
  var p = new Father('皇上');
  print(p.name);
  p.sayName();
  var s = new Son('皇上');
  print(s.name);
  s.sayName();
}

```

- 重定向到命名构造函数

```markdown
1. 可以通过 子类的构造函数 重定向到父类的命名构造函数
2. 通过super.命名构造函数即可
3. 也可以通过 子类的命名构造函数重定向到父类的命名构造函数
```

```dart
class Father {
  String name = '刘备';
  num monry = 1000;
  String job;
  Father(this.job);
  Father.origin(this.job);
  sayName() {
    print('我的名字是$name,我有好$monry');
    print('我的工作是$job');
  }
}

// 如果父类写了构造函数 子类构造函数需要重定向到父类的构造函数
class Son extends Father {
  // 子类构造函数 重定向到 父类的命名构造函数 通过 super关键字  
  Son(job) : super.origin(job);
  @override
  sayName() {
    print(super.name); // 这里打印的就是 父类Fahter 中的 name 字段 为刘备
    super.sayName();
    // TODO: implement sayName
    print('复写了父类的方法');
  }
}

void main(List<String> args) {
  var p = new Father('皇上');
  print(p.name);
  p.sayName();
  var s = new Son('皇上');
  print(s.name);
  s.sayName();
}

```

### 抽象类

```markdown
1. 规范继承类的具体字段和方法 继承类必须要实现抽象类中的方法和字段
2. 抽象类 自己实例不了
3. 通过abstract 来修饰类
4. 抽象类 还可以充当接口被实现
```

```dart
// 声明一个抽象类
abstract class Phone {
  String name = '手机';
  // 抽象类中可以有抽象方法 也可以没有抽象方法
  // 抽象类中不用实现函数体
  void processor();
  // 抽象类中 也可以有普通方法
  void info() {}
}

// 继承类 必须要实现 抽线类中的方法
class Xiaomi extends Phone {
  @override
  void processor() {
    // TODO: implement processor
    print('我的处理器是骁龙888');
  }

  sayName() {
    print('我的品牌是小米');
  }
}

void main(List<String> args) {
  var p = new Xiaomi();
  print(p.name);
}
```

### 接口

```markdown
1. 接口在dart 中就是一个类 不需要interface 声明
2. 接口可以是任意类 但一般使用抽象类做接口
3. 一个类可以实现多个接口 多个接口用都好分割 使用 implements 去链接接口
4. 普通类实现接口后 必须重写接口中所有的属性和方法
```

```dart
// 理解为手机的处理器
abstract class Processor {
  String? cores; // 内核 2核 4核
  arch(String name); // 制程  及纳米的
}

// 理解为手机的摄像头
abstract class Camera {
  String? resolution; // 摄像头的分辨率
  brand(String name); // 摄像头的品牌
}

// 那么我们如果要造手机 就必须要有摄像头 和 处理器 就必须要实现上面的两个抽线类
// 使用 关键词 implements
class Phone implements Processor, Camera {
  @override
  String? cores;

  @override
  String? resolution;

  @override
  arch(String name) {
    // TODO: implement arch
    // throw UnimplementedError();
  }

  @override
  brand(String name) {
    // TODO: implement brand
    // throw UnimplementedError();
  }
}

void main(List<String> args) {}

```

### 混入

```markdown
1. 混入是一段公共的代码 
2. 将类当作混入 作为 Mixin的类 只能继承Object 不能继承吉他类 而且不能有构造函数
3. 使用mixin 关键字直接声明 混入类 
4. 可以提高代码复用的效率 普通类 可以通过 with 来使用混入类  多个混入类 使用都好分割
5. 如果 混入类中 有相同的方法  后面的会覆盖掉前面的
6. 如果一个类作为混入类使用了 那么这个类就不能使用原有类的一些特性 比如继承(除了Object类)
```

```dart
// 混入了 可以是一个普通类
class MixinA {
  String? name = 'MixinA';

  sayName(name) {
    name = name;
    print('我是MixinA的$name');
  }
}

// 也可以是一个混入类
mixin MixinB {
  say() {
    print('我是MixinB 我说句化');
  }
  // 如果 MixinB 在 MixinA 后混入 那么 都有 sayName 方法 MixinB 会覆盖 MixinA
  // sayName(){

  // }
}

// 使用with 来 调用 混图类中的方法
class Son with MixinA, MixinB {}

void main(List<String> args) {
  var s = new Son();
  // 调用混入类 MixinA 的方法
  s.sayName('Son实例传入的参数');
  // 调用混入类 MixinB 的方法
  s.say();
  // 调用混入类 MixinA 的属性 调不出来
  print(s.name); // MixinA
}

```

## 泛型

```markdown
1. 在函数 类 接口中 指定宽泛数据类型的语法 比如 函数的返回值 类型是不固定的
2. 如果作用在 函数上 就成为 泛型函数 类上 就是泛型类 作用在接口上就是泛型接口
3. 有的数函数 只有在调用的时候才知道返回的是什么类型 所以就需要一个 <T> 来声明 如果你传的数字类型 那么这个T就是数字  如果你在调用的时候传递的是 字符串 那么 这个T就表示字符串
```

### 泛型函数

```dart

// 泛型函数 开头要用T 表示返回值 <T> 表示 理解为声明一个泛型函数 T 传递的参数
T getParams<T>(T params) {
  return params;
}

void main(List<String> args) {
  // 调用的时候    <String> 表示 传递的泛型 是什么类型
  print(getParams<String>('params'));
  print(getParams<num>(20));
}
```

### 泛型类

```dart
// 使用 <T> 来声明一个泛型类
class Peron<T> {
  // 类型是泛型T
  T? name;
  // 参数是泛型T
  void sayHello(T params) {
    print(params);
  }
}

void main(List<String> args) {
  // 实例的时候 规定 你<T> 为 String 类型
  var p = new Peron<String>();
  p.sayHello('是我');
}
// 字面量泛型的写法
Set s = <int> {}
```

### 泛型接口

```dart
abstract class FileCach<T> {
  T? name;
  getFile(T params);
}
// 这里是 先把泛型传给类 类在把泛型传递给了接口
class File<T> implements FileCach<T> {
  @override
  T? name;

  @override
  getFile(T params) {
    // TODO: implement getFile
    // throw UnimplementedError();
    print(params);
  }
}

void main(List<String> args) {
  File f = new File<String>();
  f.getFile('params');
}
```

### 使用泛型限制参数类型

```dart
// 如果要限制泛型的某些字段 就可以使用下面这种

class Fater {
  String? name = '张三';
  sayName() {}
}

class Son<T extends Fater> {
  // 这里的泛型 就是 Fater 的实例 实例里就规定了 你要有 name sayName 的方法 或者子类 那么
  sonToDo(T obj) {
    print(obj.name);
  }
}

void main(List<String> args) {
  var obj = new Fater();
  var s = new Son<Fater>();
  // 这里就必须要传递 fater 的 实例了
  s.sonToDo(obj);
}

```

## 枚举

```markdown
1. 枚举是数量固定的常量值 通过 enum 关键字声明 enum Color {red,green,blue}
2. 枚举的values常量 可以获取所有枚举值列表
3. List <color> colors = Color.values
4. 可以通过index获取值的索引
5. assert(Color.green.index == 1)
```

```dart
import 'dart:ffi';

enum Color { red, green, blue }

void main(List<String> args) {
  // 通过 index 返回枚举中 具体常量的值
  print(Color.red.index is double); // 0
  // 通过 values 返回常量列表
  print(Color.values); //[Color.red, Color.green, Color.blue]

  List<Color> colors = Color.values;
  print(colors); //[Color.red, Color.green, Color.blue]
}

```

## 库

```markdown
1. 自定义库 自己写的
2. 系统库 sdk自带的
3. 第三方库 别人写的 
4. 生态 https://pub.dev/
5. 管理库的配置文件 是 pubspec.yaml 对应js的 package.json 命令就是 npm
```

### 自定义库

```markdown
1. 一般放在 lib 下 通过 library 声明 可以理解为 一个main 函数的dart文件就是一个库 library默认就存在的
2. 通过 import 引入 后面可以加文件
3. 不同类型的库 引入方式不同
```

```dart
lib 下的 myCustom.dart
// library myCustom 可写 可不写    
library myCustom //名称尽量是 小写字母 加 下滑线这种形式
class myCustom {
    String name = 'myCustom';
    info () {
        print(name);
    }
}

main () {
    
}
```

```DART
custom.dart 文件
// 引入了    
import 'lib/myCustom.dart'    
    
main () {
    
}    
```

### 系统库

```markdown
1. 系统库引入的方式 如下 import 'dart:库名称'
```

```dart
import 'dart:math' // 引入数学对象 
```

### 第三方库

### 引入部分库

```markdown
1. 可以 理解为按需加载
2. show 关键字 包含引入 引入的库只用 那些函数 用show 关键字
3. hide 排除引入 引入的库 不需要的函数 用hide关键字
```

```dart
// 声明一个 common.dart的库 有f1 f2 f3 三个函数
f1() {
  print('f1 is running');
}

f2() {
  print('f2 is running');
}

f3() {
  print('f2 is running');
}

void main(List<String> args) {}

```

```dart
// 然后在 show.dart 引入 common.dart 只用到 f1 和 f2 函数
// 这里就使用 show 关键字 只用f1 和 f3函数
import 'common.dart' show f1, f3;

void main(List<String> args) {
  f1();
  f3();
}
//hide 相反
```

### 引入冲突处理

```markdown
1. 当引入的多个库的时候 可能存在 命名冲突的问题
2. 当库名冲突的时候 可以通过as关键字 给库声明一个前缀
```

```dart
import 'lib/common.dart'; 这里有f1 函数
import 'lib/function.dart' as func; 这里也有f1函数 不过我们用as命名为 func了
void main () {
    f1();  // 这里调用的就是 common.dart 的f1 函数
    //如果要调用 function.dart 的 f1函数 就需要如下调用
    func.f1();
}    
```

### 延迟引入

```markdown
1. 延迟引入库
2. 使用关键字 deferred as 来标识需要延迟加载的库
3. 需要使用 loadLibrary函数 去加载 延迟的内容
```

```dart
import 'lib/function.dart' deferred as func; // 这里面有f1 函数
void main () {
    // 如果这里 直接调用发f1 函数 是没有作用的 deferred as 关键子 只是建立了 function.dart 和我们当前文件的关联关系
   // func.f1() 这里调用会报错
   print('1') 
   greet() // 这里就可以直接调用了
   print('2')     
   print('3') 
   // 运行结果 1 2 3 然后 调用 f1函数    
}

// 1.  如果调用 这里我们需要 使用  loadLibrary 记住这里是异步调用的 所以要返回一个 Future
Future greet async () {
    await func.loadLibrary();可以理解为 加载了 function.dart 文件
    // 然后这里调用了 f1 函数 
    func.f1()  
}
```

### part part of来组装库

```markdown
1. 如果一个库 需要多个库去组成 那么就需要用 part  part of 来组装一个库
2. 如果我们一个大库 分为 主库 和分库的话  那么  part of 关键字 就是 分库 与主库建立关联关系的关键字 part就是 主库和分库建立关联关系的关键字
```

```dart
//sub1.dart 分库1
prat of util.dart // 分库和主库建立关联关系
sub1 () {
    print('我是sub1.dar的函数')
} 

//sub2.dart 分库1
prat of util.dart // 分库和主库建立关联关系
sub2 () {
    print('我是sub2.dar的函数')
} 

// util.dart 主库

library util

part sub1.dart;  //主库和分库建立关联关系 用 part 关键字
part sub2.dart;

void util() {
    print('我是主库');
}

// 调用

import 'util.dart';
// 下面 既可以调用 主库的 函数 也可以调用分库的函数
main () {
    sub1();
    sub2();
    util();
}
```

### 第三方库

```markdown
1. 来源 
https://pub.dev
// 下面是两个镜像
https://pub.flutter-io.cn/packages
https://pub.dartlang.org/flutter
2. 使用 需要创建 pubspec.yaml文件 在文件中声明第三方库
3. 命令执行 pub get 按钻过
4. 引入第三方库 import 'package:xxxx.dart'
5. 第三方下载完毕之后 会有一个.package的文件 这里面是包的目录和地址
6. .dart_tool 文件夹下 也是包的一些信息 当我们运行 pub 命令的时候会去这里面找对应的包
```

```yaml
name:	包名称 必填
description：项目描述
publish_to： 发布的仓库地址 发布到 https://pub.dev 还是 其他的镜像网址
version: 版本号
environment: 配置dart 的环境 dart 的版本号码
  sdk: '>2.7.0<3.0.0'
dependencies: 开发以来
  flutter:
    sdk:flitter
  cupertino_icons: ^1.0.0
dev_dependencies: 生产依赖
  flutter_test:
    sdk: flutter
flutter: flutter里的配置
  
```

## 事件循环

- dart 和js 语言类似采用事件驱动的体系结构 
- 结构为 单个事件循环 和两个队列的单线程执行模型
- 会先执行同步代码 然后 查看 MicroRask Queue 微任务队列 没有任务 查看 Evenet Queue

### 将任务放在微任务队列中

```dart
import 'dart:async';

void main(List<String> args) {
  // Future.delayed(Duration(seconds: 2), () => {print('我是Future')});
  // 此方法 是把 任务放在微任务队列中
  scheduleMicrotask(myTask); // 后输出
  // 或者使用如下方法 把任务放在微任务队列中
  // Future.microtask(myTask);  
  print('我是同步代码,我的行数在微任务后面'); // 先输出
}

void myTask() {
  print('这是微任务');
}

```

### 将任务放在event中

```dart
void main(List<String> args) {
  Future(myTask); // 后执行
  print('我是同步代码'); // 先执行
}

myTask() {
  print('任务在event中');
}
```

### 延迟任务

```dart
void main(List<String> args) {
  print('main start');
  // 此方法的意思 是 要过1秒 才把回调加入到event队列中  
  Future.delayed(Duration(seconds: 1), () => print('延迟任务'));
  // 这里是 直接加入了   event队列中   但是执行的时候先睡眠5秒
  Future(() {
    // 这延迟睡眠了 5 秒  
    sleep(Duration(seconds: 5));
    print('耗时5秒');
  });
  print('main stop');
}

// 因为 Future.delayed 是延迟了一秒才把回调放入到 event队列中   所以 Future的代码要比Future.delayed先放入了 event 中 然后同步执行 start  和 stop 最后在去 event队列中 拿到队列执行 

输出 
main start
'main stop' 
 '耗时5秒'
'延迟任务'    
```

### Future

- 对未来结果的一个代理 发返回的并不是被调用的任务的返回值 表示将来可以从future取一个值

```;
1.  Future();
2.  Future.microtask(); // 放入微任务 队列的方法
3.  Future.sync(); // 同步方法 会立即执行
4. Future.value();
5. Future.delayed();
6. Future.error()
```

- Future.sync

```dart
void main(List<String> args) {
  // 第一个执行
  print('1');
  // 第二个执行 因为是 sync 所以会立即执行
  Future.sync(() => print('2'));
  // 最后执行
  Future(() => print('3'));
}
```

```dart
void main(List<String> args) {
  print('main start');
  Future fu = Future.value('Future的值为30');
  fu.then((value) => print(value));
  Future(
    () {
      print('async task');
    },
  ).then(((value) {
    print('async task complete');
  })).then(((value) {
    print('async task after');
  })).catchError((e){}); // 可以使用 .catchError 来捕获错误

  print('main stop');
}
// 输出如下  then 里的回调 可以认为是异步的
main start
main stop
Future的值为30
async task
async task complete
async task after
```

### wait

- 等三个任务执行完成后才会执行其回调方法

```dart
void main(List<String> args) {
  print('main start');

  Future task1 = Future(() {
    print('task1');
    return 1;
  });

  Future task2 = Future(() {
    print('task2');
    return 2;
  });

  Future task3 = Future(() {
    print('task3');
    return 3;
  });
  // 都放入到 wait 中  
  Future future = Future.wait([task1, task2, task3]);
  // 等上面三个任务都执行完毕 才会执行 回调  
  future.then((responses) => print(responses));
  print('main stop');
}


输出
main start
main stop
task1
task2
task3
[1, 2, 3]
```

## Stream

- 单订阅流 最多只能有一个监听器
- 多订阅流 可以有多个监听器

### 单订阅流

```dart
void main(List<String> args) {
  createStream();
}

createStream() async {
  // 此方法表示每隔1秒会生成一个流 然后执行回到   
  Stream<int> stream = Stream<int>.periodic(Duration(seconds: 1), callback);
  await for (var i in stream) {
    print(i);
  }
}

int callback(int value) {
  return value;
}

// 输出 1 ，2 ，3，4，5 ....
```

### Stream.fromFuture

```mariadb
1. 可以把 future 放入到 Stream 中
2. 然后从 Stream 中读取结果
```

```dart
createStream() async {
  print('test start');
  Future<String> future = Future(() {
    return '异步任务';
  });
  // 从 future 创建 Stream
  Stream<String> stream = Stream.fromFuture(future);
  await for (var s in stream) {
    print(s);
  }
  print('test end');
}

// 输出
test start
异步任务
test end
```

### Stream.fromFutures

```mariadb
1. 该方法可以从多个Future 创建Stream
2. 将一系列的异步任务放入 Stream 每个Future按顺序执行 执行完成后将任务放入Stream
```

```dart
createStream() async {
  print('test start');
  Future<String> future1 = Future(() {
    sleep(Duration(seconds: 5));
    return 'future1';
  });
  Future<String> future2 = Future(() {
    return 'future2';
  });
  Future<String> future3 = Future(() {
    return 'future3';
  });

  Stream<String> stream =
      Stream<String>.fromFutures([future1, future2, future3]);

  await for (var s in stream) {
    print(s);
  }
  print('test end');
}

// 输出
test start
// 延迟五秒输出    
future1
future2
future3
test end
```

### Stream.fromlterable

```mariadb
1. 从一个集合创建 Stream
```

```dart
// 从集合创建一个流
createStream() async {
  print('test start');
  Stream<int> stream = Stream<int>.fromIterable([1, 2, 3, 4]);
  await for (var s in stream) {
    print(s);
  }
  print('test end');
}
```

## Stream 操作方法

### Stream.take

```markdown
1. Stream.periodic 创建了一个每个一秒发送一次事件流 无限发送
2. Stream.take 可以指定发送事件流的数量
```

```dart
createStream() async {
  print('test start');
  Stream<int> stream = Stream<int>.periodic(Duration(seconds: 1), (value) {
    return value;
  });
  // 这里规定了 流的数量
  stream = stream.take(10);
  await for (var s in stream) {
    print(s); // 所以打印的时候 只会打印到0-9
  }
  print('test end');
}
```

### Stream.takeWhile

```markdown
1.  可以从结果上来规定 是否 还发送流事件
```

```dart
// Stream.takeWhile 从结果来决定 是否还要发送事件流
createStream() async {
  print('test start');
  Stream<int> stream = Stream<int>.periodic(Duration(seconds: 1), (value) {
    return value;
  });
  // 如果流的结果小于3 就不发送了 所以结果只会打印到 0-2
  stream = stream.takeWhile((data) {
    print(data);
    return data < 3;
  });
  await for (var s in stream) {
    print(s);
  }
  print('test end');
}
```

### Stream.skip

```markdown
1. 可以指定跳过流事件
```

```dart
createStream() async {
  print('test start');
  Stream<int> stream = Stream<int>.periodic(Duration(seconds: 1), (value) {
    return value;
  });

  stream = stream.take(10);
  // 流事件 从第二个开始发送 打印结果 是从2开始 2-9  
  stream = stream.skip(2);
  await for (var s in stream) {
    print(s);
  }
  print('test end');
}
```

### Stream.skipWhile

```markdown
1. 可以指定跳过的条件
```

```dart
createStream() async {
  print('test start');
  Stream<int> stream = Stream<int>.periodic(Duration(seconds: 1), (value) {
    return value;
  });

  stream = stream.take(10);
  stream = stream.skipWhile((data) {
    // 只要回调里的参数 小与5的都跳过 输出 5-9
    return data < 5;
  });
  await for (var s in stream) {
    print(s);
  }
  print('test end');
}
```

### Stream.toList

```mariadb
1. 将流中的回调函数参数 收集并存放在List中 返回 Future<List>对象
```

```dart
createStream() async {
  print('test start');
  Stream<int> stream = Stream<int>.periodic(Duration(seconds: 1), (value) {
    return value;
  });

  stream = stream.take(10);
  List<int> listData = await stream.toList();
  print(listData); // [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
  print('test end');
}
```

### Stream.listen

```markdown
1. 可以用于监听数据流的方式 和 forEach 效果一致
2. 返回的 StreamSubscription对象
3. 参数如下
onData 是接收到数据的处理 必须要实现的方法
onError 流发生错误时的处理
onDone 流读取完成的时的回调
cancelOnError 发生错误是否立马终止
```

```dart
createStream() async {
  print('test start');
  Stream<int> stream = Stream<int>.periodic(Duration(seconds: 1), (value) {
    return value;
  });

  stream = stream.take(5);
  stream.listen(
    (data) {
      print(data);
    },
    onError: () {
      print('发生错误');
    },
    onDone: () {
      print('结束了');
    },
  );
  print('test end');
}
```

### stream.transform

```dart
//模拟了输入
testTransform() async {
  var stream = Stream<int>.fromIterable([12346, 322445, 112233]);
  var st =
      StreamTransformer<int, String>.fromHandlers(handleData: (int data, sink) {
    if (data == 112233) {
      sink.add('密码输入正确');
    } else {
      sink.add('密码输入错误...');
    }
  });
  // 这里相当把 上面 st 每次的 handleData 里的add函数的参数 给了 listen 中回调里的data
  stream.transform(st).listen((data) {
    print(data);
  }, onError: (e) {
    print('发生错误');
  });
}
```

### StreamController

```markdown
1. 我们可以通过 实例化 StreamController 来创建一个 stream
```

- 单订阅流

```dart
void main(List<String> args) {
  StreamController<String> streamController = StreamController();

  streamController.stream.listen((event) {
    print(event);
  });

  // 添加数据
  streamController.add('aaaa');
  streamController.sink.add('bbbb');
  streamController.add('ccc');
  // 关闭流
  streamController.close();
}
```

- 多订阅流

```dart
void main(List<String> args) {
  // broadcast 方法 可以创建多订阅流
  StreamController<String> streamController = StreamController.broadcast();
  // 可以开监听
  streamController.stream.listen((event) {
    print('第一次监听的数据' + event);
  }, onError: (e) {
    print(e);
  });
  // 可以开启多个监听
  streamController.stream.listen((event) {
    print('第二次监听的数据' + event);
  });

  // 添加数据
  streamController.add('aaaa');
  streamController.sink.add('bbbb');
  streamController.add('ccc');
  // 关闭流
  streamController.close();
}
```

- 单订阅流转多订阅流

```dart
void main(List<String> args) {
  StreamController<String> streamController = StreamController();
  // 使用下面方法就可以 转多订阅流 开启多个监听
  Stream stream = streamController.stream.asBroadcastStream();
  stream.listen((event) {});
  stream.listen((event) {});
  // 添加数据
  streamController.add('aaaa');
  streamController.sink.add('bbbb');
  streamController.add('ccc');
  // 关闭流
  streamController.close();
}
```

### flutter 中的使用

```dart
class Home extends StatelessWidget {
  Home({Key? key}) : super(key: key);
  int _count = 0;
  // 这里创建了一个流控制器  
  final StreamController<int> _streamController = StreamController();
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(children: [
        Center(
          // 使用   StreamBuilder 组件 可以监听流 
          child: StreamBuilder<int>(
            // 监听的流  
            stream: _streamController.stream,
            //   回调函数 
            builder: (context, snapshot) {
              // 这里向流里输送的数据 在   snapshot.data上 即使没有用setData函数也可以改变页面
              return snapshot.data == null
                  ? Text(
                      "0",
                      style: TextStyle(fontSize: 36.0),
                    )
                  : Text(
                      "${snapshot.data}",
                      style: TextStyle(fontSize: 36.0),
                    );
            },
          ),
        ),
        ElevatedButton(
            onPressed: () {
              // 向流里添加数据  
              _streamController.sink.add(++_count);
            },
            child: const Text('向流里添加数据'))
      ]),
    );
  }
}
```

## Isolate

```markdown
1. 异步的事件循环 仍有可能 造成阻塞
2. 所以 就有 Isolate 可以理解为 是一个新的线程 更恰当的说是微线程 或者 协程
3. 两个 Isolate 是完全独立的执行 不能共享内存 所以不存在锁竞争 每个 Isolate 都有自己的事件循环 
4. 他们之间通过发送消息进行通信 所以它的资源开销低于线程
5. 一般在一个工作需要实行几百毫秒之上的时候 需要使用 Isolate 比如Json解码 数据加密处理 图像处理 网络请求
```

- spawnUri 来创建 Isolate
- spawn 来创建 Isolate

### spawn

```markdown
1.  需要新建一个收消息的端口 到时候 新线程跟当前线程通信的时候 利用这个端口监听
2.  使用 await Isolate.spawn(doWork, receivePort.sendPort)新建线程  doWork就是你要新线程执行的代码	receivePort.sendPort 是新线程给当前线程通信事调用的方法
3. 新线程也需要新建端口 用于监听 当前线程发送的消息 也需要 给当前线程传递 receivePort.sendPort 用来 当前线程发送给新线程的消息的方法调用
```

```dart
creat_isolate() async {
  // 发送消息的端口
  late SendPort sendPort;
  // 接收消息的端口
  ReceivePort receivePort = ReceivePort();

  // 创建一个新的isolate 传入要执行任务方法 doWork 传入新的isolate 发送的端口 receivePort.sendPort
  Isolate newIsolate = await Isolate.spawn(doWork, receivePort.sendPort);

  // 接收消息端口监听新isolate发送过来的消息
  receivePort.listen((message) {
    print('main isolate listen:$message');
    if (message['type'] == 'port') {
      // 这里存放的是 新线程的发送方法 用于当前线程给新线程通信用 
      sendPort = message['data'];
      // print(sendPort);
    } else {
      // 当 sendPort对象实例化后 可以向新isolate发送消息了
      sendPort.send({'type': 'message', 'data': 'main isolate message'});
    }
  });
}


// 处理耗时任务 接受一个可以向主isolate 发送消息的端口

void doWork(SendPort sendPort) {
  // 新的isolate 启动
  print('new isolate start');
  // 新线程接收消息的端口
  ReceivePort receivePort = ReceivePort();

  receivePort.listen((message) {
    print('new isolate listen' + message['data']);
  });
  // 这里就是当前线程 传过来的 给当前线程发送消息的方法 我们在把 自己发送消息的方法传递给当前线程	
  sendPort.send({"type": 'port', "data": receivePort.sendPort});

  sleep(Duration(seconds: 5));

  sendPort.send({"type": 'message', "data": 'task finished'});

  print('new isolate end');
}
```

## 网络编程

- 使用 http库 Dio库
- 使用 HttpClient 

### http库

```dart
import 'package:http/http.dart' as http;

http.get(url).then((response){
    response.statusCode // 状态码
    response.body // 响应体    
})
```

### HttpClient

```DART
// 实例化一个 HttpClient对象
HttpClient httpClient =  HttpClient()
// 发起请求
HttpClientRequest request = await httpClient.getUrl(
	Uri.parse('http://127.0.0.1:3000/getHttpClientData')
)   
// 等待服务器返回数据    
HttpClientResponse response = await request.close();    

// 使用utf8.decoder从 response里解析数据

var result = await response.transform(utf8.decoder).join()
// 输出响应头
print(result);
// 官博
httpClient.close()
```

### Dio库

```dart
// 
Response response;
Dio dio = Dio();
dio.options.contentType = ContentType.parse('application/x-www-form-urlencoded');

// 发送 post请求 传入url 及表单参数

response = await dio.post(url,data:formData);

if(response.statusCode == 200){
    return response
}else{
    throw Exception('后端接口异常')
}
```

### 文件上传

```markdown
1. 需要两个库
2. dio 和 image_picker
3. image_picker 可以选择手机相册 或 选择拍照图片
```

```dart
var _pick = ImagePicker();

File _image;
// 打开相册 选择图片
var imgData = await image.pickImage(source: ImageSource.gallery);
setState((){
    // 设置图片
    _image = imgData
})
    
    
// 文件上传
// 创建FormData 表单    

 FormData formData = FormData.from({
     "file":UploadFileInfo(_image,'imageName.png')
 });

var response = await Dio().post('http:xxxx',data:formData); 
    
```



