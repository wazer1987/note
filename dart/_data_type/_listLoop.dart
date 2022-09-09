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
