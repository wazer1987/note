// 这个包 是第三方包 所以需要以下的方式引入

import 'package:http/http.dart' as http;

import 'dart:convert';

// void main(List<String> args) async {
//   // 这里就是声明了一个异步函数 跟fetch 差不多
//   Future getIpAddress() async {
//     // 请求一个ip地址返回本机
//     final url = 'https://httpbin.org/ip';
//     // 这里理解为 返回一个 promise 然后在调用的时候 又可以.then
//     final Response = await http.get(url);
//     return jsonDecode(Response.body);
//   }

//   var ip = await getIpAddress();
//   print(ip); // {origin: 222.222.218.199}
// }

Future getIp() {
  final url = 'https://httpbin.org/ip';
  return http.get(url).then((response) => response);
}

void main(List<String> args) {
  print('我是1');
  getIp().then((response) => print(response['body']));
  print('我是3');
}
