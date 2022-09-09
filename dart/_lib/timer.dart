import 'dart:async';

time() {
  print('1');
  var timer;
  timer = Timer(Duration(seconds: 10), () {
    print('2');
    timer?.cancel();
  });
}

class User {
  late String name;
  late num age;
  User(this.name, this.age);
}

User user = User('张三', 18);

class Vector {
  final int x;
  final int y;
  const Vector(this.x, this.y);

  Vector operator +(Vector v) {
    return new Vector(x + v.x, y + v.y);
  }

  Vector operator -(Vector v) {
    return new Vector(x - v.x, y - v.y);
  }
}

class UserInfo extends Map {
  late String name;
  late int age;
  UserInfo(this.name, this.age);
}

void main(List<String> args) {
  // UserInfo User = new
  // Map user = new UserInfo('name', 1111);
  Map a = new Map();
  print(a);
  final v = new Vector(2, 3);
  final w = new Vector(2, 2);
  final rl = v + w;
  // time();
  // print('3');
}
