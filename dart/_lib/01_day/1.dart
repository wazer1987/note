import 'dart:mirrors';

abstract class Animal {
  eat();
}

class Person {
  run() {
    print('走不');
  }
}

class Person1 {
  run() {
    print('走不1');
  }
}

class Student extends Animal with Person, Person1 {
  @override
  eat() {
    // TODO: implement eat
    print('学生吃完');
    this.run();
  }
}

enum StatuType { DEFAULT, STATUS_404, STATUS_500 }

class MyError implements Exception {
  StatuType type;
  String msg;
  MyError({this.type = StatuType.DEFAULT, required this.msg});
  String toString() {
    return this.msg ??= '错误异常';
  }
}

void main(List<String> args) {
  // print(StatuType.DEFAULT);
  test() {
    throw MyError(type: StatuType.STATUS_500, msg: '错误');
  }

  test();
  // var interable = [1, 2, 3];

  // print(interable.toList().toString());

  // 过滤集合
  // var objects = [1, 'a', 2, 'b', 3];
  // var ints = objects.whereType<int>();
  // print(ints.toList());

  // var s = r'\n这是第一行我文本\n这是第二行文本\n这是第三行文本\t一\t个tab位置';
  // print(s);

  // var value = 0;
  // assert(value <= 0);

  // var map = {"name": '222'};
  // print(map.length);
  // int age = 22;
  // assert(age < 0); // age本身就应该是大于0的，如果小于0则表示出现了非常规性的错误。
  // print(age);

  // Map obj = {};

  // obj.putIfAbsent('name', () => 333);

  // print(obj);

  // Student s = new Student();
  // s.eat();
}
