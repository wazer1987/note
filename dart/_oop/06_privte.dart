// 可以这样引入
// import './lib/Person.dart';
// 也可以这样
import 'lib/Person.dart';

void main(List<String> args) {
  Person p = new Person(33);
  print(p.qian); // 33
  // print(p._money); // 报错
  print(p.getMoney()); // 100
}
