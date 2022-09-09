void main(List<String> args) {
  // 通过字面量形式 来声明set
  const nums = <int>{1, 2, 3};
  print(nums);
  print('------------');

  // 通过构造函数
  final fruits = new Set();
  // 向集合添加一个元素
  fruits.add('香蕉');
  fruits.add('苹果');
  fruits.add('橘子');
  // 把集合转列表
  print(fruits.toList());
  print('------------');
  final fruitsList = fruits.toList();
  print(fruitsList.toSet());

  // 集合特有的操作
  final caocao = {'关羽', '郭嘉', '许褚'};
  final liubei = {'关羽', '诸葛亮', '法正'};
  // 交集
  print(caocao.intersection(liubei)); // {关羽}
  // 并集
  print(caocao.union(liubei)); //{关羽, 郭嘉, 许褚, 诸葛亮, 法正}
  // 差集
  print(caocao.difference(liubei));
  // 返回集合的第一个元素
  print(caocao.first); //关羽
}
