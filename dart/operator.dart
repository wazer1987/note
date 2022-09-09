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
