// 声明
class Person {
  // 类的属性
  String name = '张三';
  void getInfo() {
    print(this.name);
  }
}

void main(List<String> args) {
  Person p = new Person();
  p.getInfo(); // 张三
}
