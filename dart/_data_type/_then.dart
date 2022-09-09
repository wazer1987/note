// 这个包 是第三方包 所以需要以下的方式引入
import 'dart:convert';

import 'package:http/http.dart' as http;

void main(List<String> args) {
  // 这里就是声明了一个异步函数 跟fetch 差不多
  Future getIpAddress() {
    // 请求一个ip地址返回本机
    final url = 'https://httpbin.org/ip';
    // 这里理解为 返回一个 promise 然后在调用的时候 又可以.then
    return http.get(url).then((Response) {
      // Response 就是响应对象 数据都放在body 里 这里是json 字符串 我们可以用dart 核心包转换以下JOSN对象

      print(Response.body); // { "origin": "222.222.218.199"}
      Map ip = jsonDecode(Response.body);
      return ip;
    });
  }

  getIpAddress().then((ip) {
    print(ip['origin']); //222.222.218.199
  });
}
