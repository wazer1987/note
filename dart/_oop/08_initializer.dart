// class Ract {
//   int width;
//   int height;
//   Ract()
//       : width = 200,
//         height = 300 {
//     print('${this.width}======${this.height}');
//   }
// }

// void main(List<String> args) {
//   var r = new Ract();
// }

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
