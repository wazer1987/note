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
