class Person {
  // 静态属性
  static String name = '张三';
  //实例属性
  num age;
  Person(this.age);
  // 静态方法
  static getName() {
    // 这里不能使用 this 去访问 静态成员
    // 静态方法里不能访问 非静态成员
    print(name);
    // 在静态方法里访问 实例成员会报错
    // print(age);
  }

  // 实例方法
  getAge() {
    // 实例方法里可以访问 静态成员
    print(name);
    // 可以调用 静态方法
    getName();
    // 这里也可以不用this 去访问 实例成员
    print(age);
  }

  // 可以通过 实例方法 来返回 静态属性的方式 来访问静态成员
  getStaticName() {
    return name;
  }
}

void main(List<String> args) {
  // 访问 静态成员 和实例方法
  print(Person.name); // 张三
  // 调用 静态返方法
  Person.getName(); // 张三
  Person p = new Person(20);
  print(p.age);
  p.getAge();
}
