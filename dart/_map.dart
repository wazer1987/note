import 'dart:io';

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
