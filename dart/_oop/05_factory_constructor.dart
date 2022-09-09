class Person {
  String? name;
  static var incetance;
  factory Person(name) {
    if (Person.incetance == null) {
      Person.incetance = new Person.origin(name);
    }
    ;
    return Person.incetance;
  }
  Person.origin(this.name);
}

void main(List<String> args) {
  var p1 = new Person('关羽');
  print(p1.name); // 关羽
  var p2 = new Person('张飞');
  print(p2.name); // 关羽

  // 可以通过调用方法 返回的形式 来访问私有属性
}
