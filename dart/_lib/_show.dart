// import 'common.dart' show f1, f3;

class Parent {
  run() {
    print('parent');
  }
}

class Son extends Parent {
  Son();
  @override
  run() {
    // TODO: implement run
    print('son');
  }
}

Parent a = new Son();

void main(List<String> args) {
  // f1();
  // f3();
  a.run();
}
