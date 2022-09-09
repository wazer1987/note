import 'dart:io';
import 'dart:isolate';
import 'dart:async';

void main(List<String> args) {
  print('main isolate start');
  // 创建一个新的 isolate
  creat_isolate();

  print('main isolate end');
}

creat_isolate() async {
  // 发送消息的端口
  late SendPort sendPort;
  // 接收消息的端口
  ReceivePort receivePort = ReceivePort();

  // 创建一个新的isolate 传入要执行任务方法 doWork 传入新的isolate 发送的端口 receivePort.sendPort
  Isolate newIsolate = await Isolate.spawn(doWork, receivePort.sendPort);

  // 接收消息端口监听新isolate发送过来的消息
  receivePort.listen((message) {
    print('main isolate listen:$message');
    if (message['type'] == 'port') {
      // 将新的isolate发送给股哦来的端口赋值给sendPort
      sendPort = message['data'];
      // print(sendPort);
    } else {
      // 当 sendPort对象实例化后 可以向新isolate发送消息了
      sendPort.send({'type': 'message', 'data': 'main isolate message'});
    }
  });
}

// 处理耗时任务 接受一个可以向主isolate 发送消息的端口

void doWork(SendPort sendPort) {
  // 新的isolate 启动
  print('new isolate start');
  // 接受消息端口
  ReceivePort receivePort = ReceivePort();

  receivePort.listen((message) {
    print('new isolate listen' + message['data']);
  });

  sendPort.send({"type": 'port', "data": receivePort.sendPort});

  sleep(Duration(seconds: 5));

  sendPort.send({"type": 'message', "data": 'task finished'});

  print('new isolate end');
}
