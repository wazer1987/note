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
