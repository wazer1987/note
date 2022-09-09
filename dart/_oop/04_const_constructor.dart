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
