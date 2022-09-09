// 混入了 可以是一个普通类
class MixinA {
  String? name = 'MixinA';

  sayName(name) {
    name = name;
    print('我是MixinA的$name');
  }
}

// 也可以是一个混入类
mixin MixinB {
  say() {
    print('我是MixinB 我说句化');
  }
  // 如果 MixinB 在 MixinA 后混入 那么 都有 sayName 方法 MixinB 会覆盖 MixinA
  // sayName(){

  // }
}

// 使用with 来 调用 混图类中的方法
class Son with MixinA, MixinB {}

void main(List<String> args) {
  var s = new Son();
  // 调用混入类 MixinA 的方法
  s.sayName('Son实例传入的参数');
  // 调用混入类 MixinB 的方法
  s.say();
  // 调用混入类 MixinA 的属性 调不出来
  print(s.name); // 为null
}
