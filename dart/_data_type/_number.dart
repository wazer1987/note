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
