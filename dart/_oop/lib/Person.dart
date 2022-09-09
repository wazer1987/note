class Person {
  num qian;
  // 定义私有属性
  num _money = 100;
  Person(this.qian);
  // 可以i通过调取方法 来访问私有属性
  getMoney() {
    return this._money;
  }
}
