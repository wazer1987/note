import 'dart:async';
// void main(List<String> args) {
//   createStream();
// }

// createStream() async {
//   Stream<int> stream = Stream<int>.periodic(Duration(seconds: 1), callback);
//   await for (var i in stream) {
//     print(i);
//   }
// }

// int callback(int value) {
//   return value;
// }

// void main(List<String> args) {
//   createStream();
// }

// createStream() async {
//   print('test start');
//   Future<String> future = Future(() {
//     return '异步任务';
//   });
//   // 从 future 创建 Stream
//   Stream<String> stream = Stream.fromFuture(future);
//   await for (var s in stream) {
//     print(s);
//   }
//   print('test end');
// }

// void main(List<String> args) {
//   // createStream();
//   testTransform();
// }

// createStream() async {
//   print('test start');
//   Future<String> future1 = Future(() {
//     sleep(Duration(seconds: 5));
//     return 'future1';
//   });
//   Future<String> future2 = Future(() {
//     return 'future2';
//   });
//   Future<String> future3 = Future(() {
//     return 'future3';
//   });

//   Stream<String> stream =
//       Stream<String>.fromFutures([future1, future2, future3]);

//   await for (var s in stream) {
//     print(s);
//   }
//   print('test end');
// }

// // 从集合创建一个流
// createStream() async {
//   print('test start');
//   Stream<int> stream = Stream<int>.fromIterable([1, 2, 3, 4]);
//   await for (var s in stream) {
//     print(s);
//   }
//   print('test end');
// }

// Stream.take 控制流的数量

// createStream() async {
//   print('test start');
//   Stream<int> stream = Stream<int>.periodic(Duration(seconds: 1), (value) {
//     return value;
//   });

//   stream = stream.take(10);
//   await for (var s in stream) {
//     print(s);
//   }
//   print('test end');
// }

// Stream.takeWhile 从结果来决定 是否还要发送事件流
// createStream() async {
//   print('test start');
//   Stream<int> stream = Stream<int>.periodic(Duration(seconds: 1), (value) {
//     return value;
//   });
//   // 如果流的结果小于3 就不发送了
//   stream = stream.takeWhile((data) {
//     print(data);
//     return data < 3;
//   });
//   await for (var s in stream) {
//     print(s);
//   }
//   print('test end');
// }

// Stream.skip 可以指定跳过流事件 和 从第一流事件开始
// createStream() async {
//   print('test start');
//   Stream<int> stream = Stream<int>.periodic(Duration(seconds: 1), (value) {
//     return value;
//   });

//   stream = stream.take(10);
//   stream = stream.skip(2);
//   await for (var s in stream) {
//     print(s);
//   }
//   print('test end');
// }

// createStream() async {
//   print('test start');
//   Stream<int> stream = Stream<int>.periodic(Duration(seconds: 1), (value) {
//     return value;
//   });

//   stream = stream.take(10);
//   stream = stream.skipWhile((data) {
//     // 只要回调里的参数 小与5的都跳过 输出 5-9
//     return data < 5;
//   });
//   await for (var s in stream) {
//     print(s);
//   }
//   print('test end');
// }

// createStream() async {
//   print('test start');
//   Stream<int> stream = Stream<int>.periodic(Duration(seconds: 1), (value) {
//     return value;
//   });

//   stream = stream.take(10);
//   List<int> listData = await stream.toList();
//   print(listData); // [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
//   print('test end');
// }

// createStream() async {
//   print('test start');
//   Stream<int> stream = Stream<int>.periodic(Duration(seconds: 1), (value) {
//     return value;
//   });

//   stream = stream.take(5);
//   stream.listen(
//     (data) {
//       print(data);
//     },
//     onError: () {
//       print('发生错误');
//     },
//     onDone: () {
//       print('结束了');
//     },
//   );
//   print('test end');
// }

// testTransform() async {
//   var stream = Stream<int>.fromIterable([12346, 322445, 112233]);
//   var st =
//       StreamTransformer<int, String>.fromHandlers(handleData: (int data, sink) {
//     if (data == 112233) {
//       sink.add('密码输入正确');
//     } else {
//       sink.add('密码输入错误...');
//     }
//   });

//   stream.transform(st).listen((data) {
//     print(data);
//   }, onError: (e) {
//     print('发生错误');
//   });
// }

// 单订阅流
void main(List<String> args) {
  StreamController<String> streamController = StreamController();
  // 使用下面方法就可以 转多订阅流 开启多个监听
  Stream stream = streamController.stream.asBroadcastStream();

  stream.listen((event) {});
  stream.listen((event) {});
  // 添加数据
  streamController.add('aaaa');
  streamController.sink.add('bbbb');
  streamController.add('ccc');
  // 关闭流
  streamController.close();
}

// 多订阅流
// void main(List<String> args) {
//   // broadcast 方法 可以创建多订阅流
//   StreamController<String> streamController = StreamController.broadcast();
//   // 可以开监听
//   streamController.stream.listen((event) {
//     print('第一次监听的数据' + event);
//   }, onError: (e) {
//     print(e);
//   });
//   // 可以开启多个监听
//   streamController.stream.listen((event) {
//     print('第二次监听的数据' + event);
//   });

//   // 添加数据
//   streamController.add('aaaa');
//   streamController.sink.add('bbbb');
//   streamController.add('ccc');
//   // 关闭流
//   streamController.close();
// }
