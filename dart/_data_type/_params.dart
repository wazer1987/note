void main(List<String> args) {
  // 必填参数
  // 规定 传递参数必须是个字符串 返回一个字符串
  String userInfo(String name) {
    print(name);
    return name;
  }

  userInfo('张三');
  Map user = {'name': '李四'};
  print(user['name']);

  // 可选参数 可以传也可以不传的参数 用中括号包裹起来
  // 这里age 是可选参数 但是因为我们们有传 所以是null 但是我们又标准了他的类型
  String preson(name, [var age]) {
    return '我的名字是$name,年龄是$age';
  }

  print(preson('张三')); //我的名字是张三,年龄是null

  // 这里也可以赋值一个默认的
  String preson1(name, [var age = 0]) {
    return '我的名字是$name,年龄是$age';
  }

  print(preson1('张三')); // 我的名字是张三,年龄是0

  // 命名参数 用大括号包裹起来 在调用函数的时候 要保证跟声明的时候一致
  String getUserInfo(name, {int age = 20}) {
    return '我的名字是$name,年龄是$age';
  }

  // 传参数的时候要保证 跟声明的时候名字一致
  print(getUserInfo('唐伯虎', age: 10)); //我的名字是唐伯虎,年龄是10
}
