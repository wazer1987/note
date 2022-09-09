// 声明一个抽象类
abstract class Phone {
  String name = '手机';
  // 抽象类中可以有抽象方法 也可以没有抽象方法
  // 抽象类中不用实现函数体
  void processor();
  // 抽象类中 也可以有普通方法
  void info() {}
}

// 继承类 必须要实现 抽线类中的方法
class Xiaomi extends Phone {
  @override
  void processor() {
    // TODO: implement processor
    print('我的处理器是骁龙888');
  }

  sayName() {
    print('我的品牌是小米');
  }
}

void main(List<String> args) {
  var p = new Xiaomi();
  print(p.name);
}
