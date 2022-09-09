void printInfo() {
  print('我是打印');
}

// 规定返回值
int getNum() {
  return 1;
}

void main(List<String> args) {
  printInfo();

  // 匿名函数

  var myPrint = (value) {
    print(value);
  };
  List fruits = ['苹果', '香蕉', '橘子'];
  fruits.forEach(myPrint);

  // 箭头函数  函数体中不能写分号结束 而且函数体里多行代码要用,都好隔开

  var fn = (value) => {print(value), print('我是每次遍历结果$value')};
  fruits.forEach(fn);

  // 理解执行函数
  ((value) {
    print(value);
  })(3);
}
