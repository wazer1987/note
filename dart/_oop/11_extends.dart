class Father {
  String name = '刘备';
  num monry = 1000;
  String job;
  Father(this.job);
  Father.origin(this.job);
  sayName() {
    print('我的名字是$name,我有好$monry');
    print('我的工作是$job');
  }
}

// 如果父类写了构造函数 子类构造函数需要重定向到父类的构造函数
class Son extends Father {
  Son(job) : super.origin(job);
  @override
  sayName() {
    print(super.name); // 这里打印的就是 父类Fahter 中的 name 字段 为刘备
    super.sayName();
    // TODO: implement sayName
    print('复写了父类的方法');
  }
}

void main(List<String> args) {
  var p = new Father('皇上');
  print(p.name);
  p.sayName();
  var s = new Son('皇上');
  print(s.name);
  s.sayName();
}
