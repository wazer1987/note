import 'dart:io';
import 'dart:async';

// void main(List<String> args) {
//   print('main start');
//   Future.delayed(Duration(seconds: 1), () => print('延迟任务'));
//   Future(() {
//     sleep(Duration(seconds: 5));
//     print('耗时5秒');
//   });
//   print('main stop');
// }

// void main(List<String> args) {
//   // 第一个执行
//   print('1');
//   // 第二个执行 因为是 sync 所以会立即执行
//   Future.sync(() => print('2'));
//   // 最后执行
//   Future(() => print('3'));
// }

// void main(List<String> args) {
//   print('main start');
//   Future fu = Future.value('Future的值为30');
//   fu.then((value) => print(value));
//   Future(
//     () {
//       print('async task');
//     },
//   ).then(((value) {
//     print('async task complete');
//   })).then(((value) {
//     print('async task after');
//   }));

//   print('main stop');
// }

// wait
void main(List<String> args) {
  print('main start');

  Future task1 = Future(() {
    print('task1');
    return 1;
  });

  Future task2 = Future(() {
    print('task2');
    return 2;
  });

  Future task3 = Future(() {
    print('task3');
    return 3;
  });
  Future future = Future.wait([task1, task2, task3]);
  future.then((responses) => print(responses));

  print('main stop');
}
