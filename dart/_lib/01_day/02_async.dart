import 'dart:async';

// void main(List<String> args) {
//   // Future.delayed(Duration(seconds: 2), () => {print('我是Future')});
//   // 此方法 是把 任务放在微任务队列中
//   scheduleMicrotask(myTask);
//   print('我是同步代码,我的行数在微任务后面');
// }

// void myTask() {
//   print('这是微任务');
// }

void main(List<String> args) {
  Future(myTask); // 后执行
  print('我是同步代码'); // 先执行
}

myTask() {
  print('任务在event中');
}
