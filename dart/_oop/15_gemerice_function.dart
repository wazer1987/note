// U getParams<U>(U params) {
//   return params;
// }

// void main(List<String> args) {
//   print(getParams<String>('params'));
//   print(getParams<num>(20));
// }
// 使用 <T> 来声明一个泛型类
// class Peron<T> {
//   // 类型是泛型T
//   T? name;
//   // 参数是泛型T
//   void sayHello(T params) {
//     print(params);
//   }
// }

// void main(List<String> args) {
//   // 实例的时候 规定 你<T> 为 String 类型
//   var p = new Peron<String>();
//   p.sayHello('是我');
// }

//泛型接口

// abstract class FileCach<T> {
//   T? name;
//   getFile(T params);
// }

// class File<T> implements FileCach<T> {
//   @override
//   T? name;

//   @override
//   getFile(T params) {
//     // TODO: implement getFile
//     // throw UnimplementedError();
//     print(params);
//   }
// }

// void main(List<String> args) {
//   var f = new File<String>();
//   f.getFile('params');
// }

// 限制泛型参数
class Fater {
  String? name = '张三';
  sayName() {}
}

class Son<T extends Fater> {
  sonToDo(T obj) {
    print(obj.name);
  }
}

void main(List<String> args) {
  var obj = new Fater();
  var s = new Son<Fater>();
  Map obj1 = {
    "userInfo":'3333'
  }
  s.sonToDo(obj);
}
