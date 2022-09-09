import 'dart:ffi';

import 'dart:math';

enum Color { red, green, blue }

void main(List<String> args) {
  // 通过 index 返回枚举中 具体常量的值
  print(Color.red.index is double); // 0
  // 通过 values 返回常量列表
  print(Color.values); //[Color.red, Color.green, Color.blue]

  List<Color> colors = Color.values;
  print(colors); //[Color.red, Color.green, Color.blue]
  var intValue = Random().nextInt(10);
  print(intValue);
}
