void main(List<String> args) {
  // 声明字符串

  String str1 = 'hello,world';
  print(str1);
  String str2 = "你好";
  print(str2);
  print(str2);

  // 通过 3个引号声明字符串 可以是三个单引号 也可以是三 3个装引号

  String str3 = '''
    我是多行文字
    看见我换行了吧
  ''';
  print(str3);

  // 字符串拼接
  print(str1 + str2);

  //模板字符串 直接用$即可

  print('$str1 $str2');

  // 字符串分割

  print(str1.split('')); // 这里会分割成数组

  // 字符串的裁切

  print('   abc   '.trim()); // 可以去除左右两边的空格

  // 判断字符串是否为空

  print(''.isEmpty); // 判断字符串是为空 true
  print(''.isNotEmpty); // 判断字符串不为空 false

  String str4 = '我是教育';
  print(str4.replaceAll('教育', '替换')); // 这里也支持正则 就是把教育替换成 替换
  String str5 = 'time out';
  print(str5.indexOf('o')); // 找到索引 lastindexof 从后面向前找索引
  print(str5.contains('out')); // 查找字符串 看看包含这个字符串
}
