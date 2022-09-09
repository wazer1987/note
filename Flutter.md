#  Flutter

## 环境搭建

```markdown
1. windows下只能 搭建Android 开发环境
2. mac 可以 搭建 ios 和 安卓	
```

## win搭建安卓环境

```markdown
1. 需要安装JDK
2. 也需要安装 Android Studio Android SDK Android 模拟器
3. 安装Flutter SDK
```

- 配置资源镜像

```dart
PUB_HOSTED_URL=https://pub.flutter-io.cn

FLUTTER_STORAGE_BASE_URL=https://storage.flutter-io.cn

在系统变量 新建环境变量 里 新建  
变量名称 PUB_HOSTED_URL 值 https://pub.flutter-io.cn
变量名称 FLUTTER_STORAGE_BASE_URL 值 https://storage.flutter-io.cn
```

- 下载JDK

```markdown
1. JDK 是 java 开发套件的简称 既然要做原生应用 而且基于 安卓的 所以需要安装JDK
2. https://www.oracle.com/java/technologies/javase/javase-jdk8-downloads.html
3. 通过 java -version 可以查看版本号 
```

- 下载 Android Studio

```markdown
1. 直接下一步即可
2. 在下载过程中 会帮我们安装 Android Emulator 模拟器 Android SDK Tools  
3. 这里 flutter 开发 必须需要  Android SDK 
4. 这里注意 就是在安装 安卓编辑器的时候 Android SDK  一定要安装好
```

```markdown
1. 我们可以打开编译器 在 Tools 中 找到 SDK Manager去安装 SDK
2. 安装模拟器 在 Tools 中 找到 Device Manager 去安装
3. 需要安装flutter 插件才能开发 flutter 项目 file settings Plugins Marketplace 搜索flutter 点击 安装
```

- 下载 flutter SDK

```markdown
1. 去官网下载即可 下载之后 就是一些文件 
2. 运行 有两种方式 同构 flutter_console.bat 发开命令行 然后在命令行中运行flutter 命令
方法二 可以同构 绑定环境变量
3. 安装好了之后 可以切换版本 命令是 
切换分支
flutter channel beta
升级版本
flutter upgrade
重新检测
flutter doctor
```

```markdown
这里我们用绑定环境变量的模式  
找到环境变量 系统环境变量 然后 Path 编辑 
D:\sdk\flutter\bin 粘贴进去
在命令行中 输入 flutter doctor 检测以下 
```

## 初始化项目

```markdown
1. 通过命令行 去初始化 flutter create myproject 
2. 通过 flutter run 去运行即可
3. 通过 Android Studio 去创建 这里 需要安装 flutter 插件才可以
4. 通过 vs code 去创建flutter 项目 也必须安装 flutter 插件
```

## 修改镜像源

```markdown
1. 修改镜像源有两种方式
2. 第一在 创建的项目里  myproject\android\build.gradle  
3. 第二种方式 就是直接修改 flutter SDK 下的 flutter.gradle 文件 D:\sdk\flutter\packages\flutter_tools\gradle\flutter.gradle 文件
4. build.gradle 配置文件  就是一个项目构建工具 类似 webpack
```

```json
// 在 创建的项目里修改
buildscript {
    ext.kotlin_version = '1.6.10'
    repositories {
        // 修改如下 下面两个函数注释      
        // google()
        // mavenCentral()
        maven {url 'https://maven.aliyun.com/repository/google'}
        maven {url 'https://maven.aliyun.com/repository/jcenter'}
        maven {url 'https://maven.aliyun.com/repository/public'}
    }

    dependencies {
        classpath 'com.android.tools.build:gradle:7.1.2'
        classpath "org.jetbrains.kotlin:kotlin-gradle-plugin:$kotlin_version"
    }
}

allprojects {
    repositories {
        // 修改如下 下面两个函数注释      
        // google()
        // mavenCentral()
        maven {url 'https://maven.aliyun.com/repository/google'}
        maven {url 'https://maven.aliyun.com/repository/jcenter'}
        maven {url 'https://maven.aliyun.com/repository/public'}
    }
}

rootProject.buildDir = '../build'
subprojects {
    project.buildDir = "${rootProject.buildDir}/${project.name}"
}
subprojects {
    project.evaluationDependsOn(':app')
}

task clean(type: Delete) {
    delete rootProject.buildDir
}

```

```json
flutter\packages\flutter_tools\gradle\flutter.gradle 
// 找到 buildscript 如下
buildscript {
    repositories {
        // google()
        // mavenCentral()
        maven { url 'https://maven.aliyun.com/repository/google' }
        maven { url 'https://maven.aliyun.com/repository/jcenter' }
        maven { url 'https://maven.aliyun.com/repository/public' }
    }
    dependencies {
        /* When bumping, also update ndkVersion above. */
        classpath 'com.android.tools.build:gradle:4.1.0'
    }
}
```

## 项目启动

```markdown
1. 启动就是用flutter run 
2. 启动之前 要看下模拟器 输入 flutter emulators 会显示 模拟器列表 这个我们在 安卓编辑器上安装过
Pixel_3a_API_30 • Pixel 3a API 30 • Google • android
3. 启动模拟器 flutter emulators --launch Pixel_3a_API_30
4. 启动项目 flutter run 出自运行会比较慢 需要下载一些内容
5. 通过vscode 启动 需要点击运行 启动调试即可F5 这样是热更新的
```

## 一些常用命令

```markdown
1. 修改重启 在命令行按r 比如修改了一些代码 在命令行 按r 就可以 重新编译
2. q 推出模拟器
3. p 模拟器出现网格
4. o 切换 安卓和 ios
```

## 项目目录

```markdown
flutter_app
|--android  #安卓目录
|--build    #构建目录
|--ios	    #ios目录
|--lib	    #开发目录
|  |----main.dart   #入口文件
|--test     #测试目录
|--.gitignore
|--pubspec.lock 
|--pubspec.yaml  #项目依赖
```

```markdown
1. Material Design  可以理解成UI 框架 比如 bootsrap 之类的
2. 这里写好了一些组件 
3. https://material-io.cn
4. 在flutter 中一切内容都是组件 Widget
5. widget 分为 无状态 StatelessWidget 有状态 StatefulWidget
```

## 运行

```markdown
1. 我们要使用  Material Design 就必要要在 dart 里引入 // material 引入了 material组件
import 'package:flutter/material.dart';
2. main.dart就是入口文件 main函数里要 调用runApp方法 里面 放的是 Material的组件
3. 以下可以省略 new 关键字
```

```dart
// material 引入了 material组件
import 'package:flutter/material.dart';

void main(List<String> args) {
  runApp(
   // Center 居中的组件 可以让排版剧中  接受一个命名参数 child 
   Center(
    // Text 文字组件 可以设置渲染文字  里面有好多属性 比如 文字排列顺序等
    child: Text(
      'Hello flut11terdsdsfg',
      textDirection: TextDirection.ltr,
    ),
  ));
}

```

- 无状态组件

```markdown
1. 我们可以基于以上代码 分装一个无状态的组件
2. 可以使用 st 代码片段生成
```

```dart
// material 引入了 material组件
import 'package:flutter/material.dart';

void main(List<String> args) {
  runApp(MyWidget());
}

// 1. StatelessWidget  是一个抽象类
// 2. 必须实现一个 build方法 返回一个 Widget组件
class MyWidget extends StatelessWidget {
  const MyWidget({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) { 
    return Center(
      child: Text(
        'Hello 222222',
        textDirection: TextDirection.ltr,
      ),
    );
  }
}
```

## APP结构

```markdown
1. app 一般都有自己的结构 比如 头部 主题 和底部菜单
2. material 提供了两个 做APP 结构的组件 一个是 MaterialApp  一个是 Scaffold
```

### MaterialApp

- tille 任务管理器中的标题  当手机 切换app 的时候 会显示的title
- home 主要内容 里面就可以放我们的 Scaffold 组件 就是APP 页面了 
- debugShowCheckedModeBanner 是否显示左上角调式标记

### Scaffold

- appBar 应用头部
- body 应用主体
- floatingActionButton 浮动按钮
- drawer 左侧抽屉菜单
- endDrawer 右侧抽屉菜单

```dart
// material 引入了 material组件
import 'package:flutter/material.dart';

void main(List<String> args) {
  //myApp 是一个无状态组件 返回了一个   MaterialApp 组件
  runApp(const myApp());
}

class myApp extends StatelessWidget {
  const myApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Flutter APp',
      // myHome 是一个应用组件 返回了一个   Scaffold组件
      home: myHome(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class myHome extends StatelessWidget {
  const myHome({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar属性 表示头部 值类型是一个Widget 可以用 AppBar  
      appBar: AppBar(
          // 如下属性 title 顶部文字
          title: const Text('首页'),
          // 左侧的 图标
          leading: const Icon(Icons.menu),
          // 有测图标 widget 组件的数组
          actions: const [Icon(Icons.settings)],
          // 阴影
          elevation: 0.0,
          // 是否剧中
          centerTitle: true),
      // 中间的主题内容   
      body: const Center(child: Text('Hello Flutter')),
    );
  }
}

```

```dart
// 以上也可以抽离出去成一个 单独的文件
index.dart
    import 'package:flutter/material.dart';

class myApp extends StatelessWidget {
  const myApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Flutter APP',
      home: myHome(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class myHome extends StatelessWidget {
  const myHome({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('首页111'),
          leading: const Icon(Icons.menu),
          actions: const [Icon(Icons.settings)],
          elevation: 0.0,
          centerTitle: true),
      body: const Center(child: Text('Hello Flutter')),
    );
  }
}
```

```dart
main.dart 引入
// material 引入了 material组件
import 'package:flutter/material.dart';
import 'index.dart';

void main(List<String> args) {
  runApp(const myApp());
}    
```

## 基础组件

### 常用

#### Text

```markdown
TextDirection 文本方向
TextStyle  文本样式
    Colors 文本颜色
    FontWeight 字体粗细
    FontStyle 字体样式
TextAlign 文本对齐
TextOverflow 文本溢出
maxLines 指定显示的行数
```

```dart
class myHome extends StatelessWidget {
      body: Column(children: const [
        Text(
          '我是flutter的 Text 组件 我有下面的属性',
          textDirection: TextDirection.rtl, // 文字的方向 从左向右 或者从右向左
          style: TextStyle(
              // 文字的样式
              fontSize: 30, // 字体大小
              color: Color.fromARGB(255, 90, 12, 6), // 字体颜色
              fontWeight: FontWeight.w700, // 字体粗细
              fontStyle: FontStyle.italic, // 字体样式 斜体 之类的
              decoration: TextDecoration.lineThrough, // 加上中划线
              decorationColor: Colors.blue // 中划线的颜色
              ),
          textAlign: TextAlign.left, // 多行字体对齐的方向 左对齐 右对齐
          maxLines: 3, // 字体最多显示几行
          overflow: TextOverflow.ellipsis, // 超出宽度... 显示
          textScaleFactor: 1.5, // 字体放大的倍数 在原有的 fontSize上
        )
      ]),
    );
  }
}

```

#### RichText 与 TextSpan

```markdown
给一段文本 设置不同的样式 RichText 和 TextSpan 搭配使用
```

```dart
import 'package:flutter/material.dart';


class myHome extends StatelessWidget {
  const myHome({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('首页111'),
          leading: const Icon(Icons.menu),
          actions: const [Icon(Icons.settings)],
          elevation: 0.0,
          centerTitle: true),
          body: Column(children: [
            RichText(
              // 一行文本  
              text: const TextSpan(
                text: 'Hello1111 ',
                style: TextStyle(fontSize: 20, color: Colors.blue),
                children: <TextSpan>[
                  TextSpan(
                      text: 'bold', style: TextStyle(fontWeight: FontWeight.bold)),
                      TextSpan(text: ' world!', style: TextStyle(color: Colors.red)),
                ],
              ),
            )
          ]),
    );
  }
}

```

#### 自定义字体

```markdown
1. 下载并导入字体文件 https://fonts.google.com  将字体文件赋值到Flutter项目中
2. 在pubspec.yaml 中 声明字体
3. 可以为整个应用设置默认字体 也可以为某个组件设置字体
```

```yaml
flutter:
  fonts:
    #family 属性决定了字体的名称 将会在TextStyle 的 fontFamily 属性中用到
    - family: SourceSansPro
      fonts: 
        #存放字体文件的位置
        - asset: fonts/Source_Sans_Pro/SourceSansPro-black.ttf
        - asset: fonts/Source_Sans_Pro/SourceSansPro-blackItalic.ttf
        # weight 属性指定了文件中字体轮廓的自重为100 的整数倍
        weight: 400
        # style 属性指定了文件中 字体轮廓是否为 斜体之类的
        style: normal
```

```dart
// 使用字体 如果是全局使用 可以在 MaterialApp 跟组件中使用
class myApp extends StatelessWidget {
  const myApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter APP',
      // 这里使用字体  
      theme: ThemeData(fontFamily: 'maobi'),
      home: const myHome(),
      debugShowCheckedModeBanner: false,
    );
  }
}
```

```dart
// 单独在组件中使用就 要在style:TextStyle(fontFamily) 使用
body: Column(children: [
        const Text(
          '我是flutter的 Text 组件 我有下面的属性',
          textDirection: TextDirection.rtl, // 文字的方向 从左向右 或者从右向左
          style: TextStyle(
              // 这里单独使用
              fontFamily: 'maobi',
              ),
        )
    ]
```

#### Icon

```markdown
1. Flutter 中的图标库
2. Icon(Icons.具体名称)
3. 在线预览 https://material.io/resources/icons
```

```dart
appBar: AppBar(
          title: const Text('首页111'),
    	  // 在头部使用	
          leading: const Icon(Icons.menu),
          actions: const [Icon(Icons.settings)],
          elevation: 0.0,
          centerTitle: true),
```

#### color

```markdown
1. Flutter 中 通过 ARGB来声明颜色 使用Color 组件 来声明
2. const Color(0xff42A5F5) // 16 进制的ARGB = 透明度 + 六位十六进制颜色
3. 可以通过 Color.fromARGB(0xff,0x42,0xA5,0xF5) // 十六进制
   Color.fromARGB(255,66,165,245) 十进制来声明
   Color.fromRGBO(66,165,245,1.0) 最后一位 是透明度
   Colors.red 声明一个红色
```

```dart
style: TextStyle(
              fontFamily: 'maobi',
              // 文字的样式
              fontSize: 30, // 字体大小
              color: Color.fromARGB(255, 90, 12, 6), // 字体颜色
              fontWeight: FontWeight.w700, // 字体粗细
              fontStyle: FontStyle.italic, // 字体样式 斜体 之类的
              decoration: TextDecoration.lineThrough, // 加上中划线
              decorationColor: Colors.blue // 中划线的颜色
              ),
```

### 布局

#### Container

```markdown
1. 理解为 div 和模型	
child 声明子组件
padding  margin  内外边距 值 EdgeeInsets(all()设置所有的内外边距的值 fromLTRB() 左上右下的值 only() 一个的值)
decoration 盒模型 模式 值 BoxDecoration(边框 圆角 渐变 阴影 背景色 背景图片)
alignment 控制盒子对齐的 值 Alignment 内容对齐
transform 来控制 盒子变形 Matrix4(平移 translate 旋转 routate 缩放 scale 斜切 skew)
```

```dart
class ContainerDemo extends StatelessWidget {
  const ContainerDemo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text('我是一段文字我在container组件里'),
      //可以写宽高
      // width: 200.0,
      // height: 200.0,
      // 适配手机的 宽度和高度 也就是跟手机的屏幕的高度或者宽度一致
      width: double.infinity,
      height: double.infinity,
      // 设置padding EdgeInsets.all 所有的边距都是10 也可以使用 EdgeInsets.fromLTRB
      padding: const EdgeInsets.fromLTRB(10.0, 40.0, 10.0, 10.0),
      margin: EdgeInsets.fromLTRB(0.0, 40, 0, 0),
      // 文字居中
      alignment: Alignment.center,
      // 平移三个轴
      // transform: Matrix4.translationValues(100, 0, 0),
      // 旋转
      // transform: Matrix4.rotationZ(0.1),
      // 斜切
      transform: Matrix4.skewX(0.3),
      // 设置盒子边框 上下左右
      decoration: BoxDecoration(
          // 设置四角的 边框
          border: Border.all(color: Colors.red, width: 10.0),
          // border: Border(
          //     top: BorderSide(color: Colors.red, width: 10.0),
          //     left: BorderSide(color: Colors.red, width: 10.0),
          //     right: BorderSide(color: Colors.red, width: 10.0),
          //     bottom: BorderSide(color: Colors.red, width: 10.0)),
          // 这是四个方向的圆角
          // borderRadius: BorderRadius.all(Radius.circular(30)),
          // 设置一个具体的方向
          borderRadius: const BorderRadius.only(topLeft: Radius.circular(30)),
          // 设置背景颜色
          color: Colors.blue,
          // 渐变背景
          gradient:
              const LinearGradient(colors: [Colors.lightBlue, Colors.white12])
      ),
    );
  }
}
```

#### Column

- Column 中的主轴方向是垂直方向
- mainAxisAlignment: MainAxisAlignment 主轴的对齐方式
- crossAxisAlignment:CrossAxisAlignment 交叉轴对齐方式
- children 内容

#### Row

- Row 中的主轴方向 是水平方向
-  其余的属性和column一致

```dart
// 这里参考 flex 布局  纵轴和横轴
class ColumnDemo extends StatelessWidget {
  const ColumnDemo({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // 参考flex 布局
    return Container(
        // 跟手机设备一样的宽
        width: double.infinity,
        child: Column(
          children: [
            Text(
              '我是组件',
              style: TextStyle(color: Colors.red),
            ),
            Text(
              '我是组件',
              style: TextStyle(color: Colors.red),
            ),
            const Text(
              '我是组件',
              style: TextStyle(color: Colors.red),
            ),
            Text(
              '我是组件',
              style: TextStyle(color: Colors.red),
            ),
            Text(
              '我是组件',
              style: TextStyle(color: Colors.red),
            )
          ],
          // 这里要注意宽度 才会右效果
          crossAxisAlignment: CrossAxisAlignment.center,
          // 纵轴的最底下
          // mainAxisAlignment: MainAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
        ));
  }
}
```

#### Flex

- Flex 区别与 Row 和 Column  Flex 可以指定轴的方向 也可以指定 水平方向或者纵轴的排列顺序等
- direction 声明主轴的方向
- mainAxisAlignment 声明主轴对齐方式
- textDirection 声明水平方向的排列顺序
- crossAxisAlignment 声明交叉轴对齐方式
- verticalDirection 声明垂直方向的排列顺序
- children 声明子组件

#### Expanded 可伸缩组件

- 类似Container 但是不用指定宽高 会找父元素的宽高
- flex 声明弹性布局所占的比例 理解为 css3 中flex 中flex
- child 声明子组件

```dart
class FlexDemo extends StatelessWidget {
  const FlexDemo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Container(
              color: Colors.red,
              height: 50,
              // 必须要指定宽度 否则显示不出来
              width: 50,
            ),
            // 这里没有指定宽度 但是 盒子 会弹性展开 抛出上面盒子的宽度 就是 自己的宽度
            Expanded(
              child: Container(
                color: Colors.green,
                height: 50,
              ),
            )
          ],
        ),
        // 弹性布局 指定了 水平轴是主轴
        Flex(
          direction: Axis.horizontal,
          // 指定了主轴的排列方式
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          // 声明水平方向的排列方式  没有添加的时候 是 1，2，3，4 现在添加的是从右向左 变成 4，3，2，1
          textDirection: TextDirection.rtl,
          children: const [
            Icon(
              Icons.access_alarm,
              size: 50,
            ),
            Icon(
              Icons.access_alarm_outlined,
              size: 50,
            ),
            Icon(
              Icons.settings,
              size: 50,
            ),
            Icon(
              Icons.add_box,
              size: 50,
            )
          ],
        ),
        //如果 Flex 组件里 有 Expanded 组件 那么 宽度就会失效 就可以用flex 属性来设置每个 Expanded 所有的比例
        Flex(
          direction: Axis.horizontal,
          children: [
            Expanded(
              // 这个 Expanded 组件栈宽度的4份  4/5
              flex: 4,
              child: Container(
                color: Colors.green,
                height: 50,
              ),
            ),
            // 占位符 也参与flex 计算 可以理解为 当 flex 和 flex 中需要一些空袭的时候可以使用这个组件  
            Spacer(
              flex: 1,
            ),
            Expanded(
              // 这个 Expanded 组件栈宽度的1份 1/5
              flex: 1,
              child: Container(
                color: Colors.red,
                height: 50,
              ),
            ),
          ],
        )
      ],
    );
  }
}
```

#### 流式布局

- 当我们使用Row  和 Column 中 子组件的尺寸超出了 那么 Flutter 会报错 并不会向web中往后排列
- 所以我们需要用 Wrap 组件 解决内容溢出问题 
- spacing 主轴方向子组件的间距
- alignment 主轴方向的对齐方式
- runSpacing 纵轴方向子组件的间距
- runAlignment 纵轴方向的对齐方式

#### Chip 标签组件

#### CircleAvatar  圆形头像组件

```dart
import 'package:flutter/material.dart';

class WrapDemo extends StatelessWidget {
  List<String> _list = ['曹操', '郭嘉', '司马懿', '许褚', '典韦'];
  List<Widget> _weiGuo() {
    return _list.map((item) {
      return Chip(
          label: Text(item),
          avatar: const CircleAvatar(
            backgroundColor: Colors.blue,
            child: Text('魏国'),
          ));
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // 这如果是 row 组件并不会横向压缩 而是会报错 这里我们用Wrap 就不会
        // Wrap(children: const [
        //   // 一个标签组件 形式就是一个圆角的长方形 然后 label 是标签的名字 然后前面右个头像 圆形的
        //   Chip(
        //       label: Text('关羽'),
        //       avatar: CircleAvatar(
        //         backgroundColor: Colors.blue,
        //         child: Text('蜀国'),
        //       )),
        //   Chip(
        //       label: Text('关羽'),
        //       avatar: CircleAvatar(
        //         backgroundColor: Colors.blue,
        //         child: Text('蜀国'),
        //       )),
        //   Chip(
        //       label: Text('关羽'),
        //       avatar: CircleAvatar(
        //         backgroundColor: Colors.blue,
        //         child: Text('蜀国'),
        //       )),
        //   Chip(
        //       label: Text('关羽'),
        //       avatar: CircleAvatar(
        //         backgroundColor: Colors.blue,
        //         child: Text('蜀国'),
        //       )),
        //   Chip(
        //       label: Text('关羽'),
        //       avatar: CircleAvatar(
        //         backgroundColor: Colors.blue,
        //         child: Text('蜀国'),
        //       )),
        //   Chip(
        //       label: Text('关羽'),
        //       avatar: CircleAvatar(
        //         backgroundColor: Colors.blue,
        //         child: Text('蜀国'),
        //       ))
        // ]),
        // 当然这里我们也可以抽离出去
        Wrap(
          // 水平方向的间距
          spacing: 18.0,
          // 主轴对齐方式
          alignment: WrapAlignment.spaceAround,
          // 垂直方向的间距
          runSpacing: 100,
          // 交叉轴的对齐方式
          runAlignment: WrapAlignment.spaceAround,
          // 这里可以调用方法 来生成列表
          children: [..._weiGuo()],
        )
      ],
    );
  }
}
```

#### Stack 层叠布局 

- 理解为 z-index
- **Stack 组件可以完成层叠布局 搭配 Positioned组件 使用**
- alignment 声明未定位组件的对齐方式  textDirection 声明未定位子组件的排列顺序
- **Positioned 绝对定位组件 搭配Stack 使用**
- child 声明子组件
- left top right bottom 上下左右的位置
- width height 宽高
- **NetworkImage 网络图片组件**
- NetworkImage(网络图片地址) 需要项目开启http 请求权限

```markdown
1. 配置http 访问权限 需要更改 myproject\android\app\src\main\AndroidManifest.xml 文件
2. 添加 <uses-permission android:name="android.permission.INTERNET"/>
```

```yaml
<manifest xmlns:android="http://schemas.android.com/apk/res/android"
    package="com.example.myproject">
    #添加如下
    <uses-permission android:name="android.permission.READ_PHONE_STATE" />
    <uses-permission android:name="android.permission.INTERNET" />
    <uses-permission android:name="android.permission.ACCESS_NETWORK_STATE" />
    <uses-permission android:name="android.permission.ACCESS_WIFI_STATE" />
   <application
        android:label="myproject"
        android:name="${applicationName}"
        android:usesCleartextTraffic="true"
        android:icon="@mipmap/ic_launcher">
        <activity
            android:name=".MainActivity"
            android:exported="true"
            android:launchMode="singleTop"
            android:theme="@style/LaunchTheme"
            android:configChanges="orientation|keyboardHidden|keyboard|screenSize|smallestScreenSize|locale|layoutDirection|fontScale|screenLayout|density|uiMode"
            android:hardwareAccelerated="true"
            android:windowSoftInputMode="adjustResize">
            <!-- Specifies an Android theme to apply to this Activity as soon as
                 the Android process has started. This theme is visible to the user
                 while the Flutter UI initializes. After that, this theme continues
                 to determine the Window background behind the Flutter UI. -->
            <meta-data
              android:name="io.flutter.embedding.android.NormalTheme"
              android:resource="@style/NormalTheme"
              />
            <intent-filter>
                <action android:name="android.intent.action.MAIN"/>
                <category android:name="android.intent.category.LAUNCHER"/>
            </intent-filter>
        </activity>
        <!-- Don't delete the meta-data below.
             This is used by the Flutter tool to generate GeneratedPluginRegistrant.java -->
        <meta-data
            android:name="flutterEmbedding"
            android:value="2" />
    </application>
</manifest>

```

```dart
// ignore_for_file: sort_child_properties_last

import 'package:flutter/material.dart';

class StackDemo extends StatelessWidget {
  const StackDemo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const CircleAvatar(
          backgroundImage: NetworkImage(
              'https://tse3-mm.cn.bing.net/th/id/OIP-C.C1hVRW91V30RGje3Hph6ewHaGD?pid=ImgDet&rs=1'),
          radius: 200,
        ),
        // 这里就可以使用定位了 把这个文本放在 Stack 的 一个位置 这个 Positioned 是放在 上一个图像后面 所以在显示上他会在 图像上面
        Positioned(
          child: Container(
            child: const Text(
              '我是一个大好人',
              style: TextStyle(color: Colors.red),
            ),
            color: Colors.blue,
          ),
          top: 200,
          right: 0,
        ),
        // 对应这种没有 使用Positioned 组件 嵌套的 可以使用 Stack上的 alignment 和一些其他的属性来 调试位置
        const Text(
          '我没有套用Positionedddddd组件',
          style: TextStyle(color: Colors.red),
        ),
      ],
      alignment:
          Alignment.bottomLeft, // 比如 上面的 我没有套用Positionedddddd组件 就在 stack 的左下角
    );
  }
}

```

#### Card 组件

- child 子组件
- color 背景色
- shadowColor 阴影色
- elevation 阴影高度
- shape 边框样式
- margin 外边距

#### ListTile 组件

- leading 头部组件
- title 标题
- subtitle 子标题

```dart
class CardDemo extends StatelessWidget {
  const CardDemo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Card(
            // 卡片的背景颜色
            color: Colors.purpleAccent,
            // 阴影颜色
            shadowColor: Color.fromARGB(255, 185, 132, 129),
            // 阴影高度
            elevation: 20,
            // 边框
            shape: RoundedRectangleBorder(
                // 边框的圆角
                borderRadius: BorderRadius.circular(40),
                // 边框的尺寸
                side: BorderSide(color: Colors.yellow, width: 3)),
            margin: EdgeInsets.all(20),
            child: Container(
              child: Column(
                children: const [
                  ListTile(
                    leading: Icon(
                      Icons.accessible_forward_sharp,
                      size: 50,
                    ),
                    title: Text(
                      '张三',
                      style: TextStyle(fontSize: 30),
                    ),
                    subtitle: Text('董事长'),
                  ),
                  // 分割线
                  Divider(),
                  ListTile(
                    leading: Icon(
                      Icons.accessible_forward_sharp,
                      size: 50,
                    ),
                    title: Text(
                      '张三',
                      style: TextStyle(fontSize: 30),
                    ),
                    subtitle: Text('董事长'),
                  )
                ],
              ),
            ))
      ],
    );
  }
}
```



###  按钮

- Flutter 1.22 之前的按钮 和 1.22之后的按钮不一样
- FlatButton 扁平按钮 RaisedButton 凸起按钮 OutlineButton 轮廓按钮 1.22 之前
- TextButton 扁平按钮 ElevatedButton 凸起按钮 OutlinedButton 轮廓按钮
- 新按钮 统一控制按钮比较方便 把所有的样式都设置到ButtonStyle 属性中
- IconButton 图标按钮 也可以通过 TextButton.icon()  ElevatedButton.icon() OutlinedButton.icon()  声明
- ButtonBar 按钮组
- FloatingActionButton 浮动按钮
- BackButton 回退按钮
- CloseButton 关闭按钮

```dart
//三个按钮 和同构 style ButtonStyle 来书写一些样式
import 'package:flutter/material.dart';
class ButtonDemo extends StatelessWidget {
  const ButtonDemo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(10),
        child: Wrap(
          runSpacing: 20,
          children: [
            Container(
              width: double.infinity,
              height: 50,
              child: TextButton(
                child: Text('我是文字按钮'),
                onPressed: () {
                  print('我点击了文字按钮');
                },
              ),
            ),
            Container(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                child: Text('我是凸起按钮'),
                onPressed: () {
                  print('我点击了凸起按钮');
                },
              ),
            ),
            Container(
              // width: double.infinity,
              height: 50,
              child: OutlinedButton(
                // 以上按钮 都可以通过style 属性来修改按钮样式 现在按钮就是文字在左上
                style: ButtonStyle(
                    // 阴影
                    shadowColor: MaterialStateProperty.all(Colors.yellow),
                    // 阴影距离
                    elevation: MaterialStateProperty.all(20),
                    // 边框
                    side: MaterialStateProperty.all(
                        BorderSide(color: Colors.pink, width: 2)),
                    // 可以理解为形状
                    shape: MaterialStateProperty.all(
                        // StadiumBorder 就是体育场的形状 所以现在这个按钮是 胶囊样式的
                        StadiumBorder(
                            side: BorderSide(color: Colors.pink, width: 2))),
                    // 按钮大小
                    minimumSize: MaterialStateProperty.all(Size(100, 60)),
                    // 设置水波纹颜色
                    overlayColor: MaterialStateProperty.all(Colors.purple),
                    // 下面是修改了文字样式 所有修改按钮的类型 都是 MaterialStateProperty 类型
                    textStyle:
                        MaterialStateProperty.all(TextStyle(fontSize: 30)),
                    foregroundColor:
                        // resolveWith 用具体的内容来实现样式设置
                        MaterialStateProperty.resolveWith((states) {
                      // states 就是状态值 当前有没有长按这个按钮 下面 if 里的条件就在长按按钮的过程中 返回了文字颜色
                      if (states.contains(MaterialState.pressed)) {
                        return Colors.red;
                      }
                      return Colors.blue;
                    }),
                    // 长按按钮过程中 背景颜色设置为 黄色
                    backgroundColor:
                        MaterialStateProperty.resolveWith((states) {
                      if (states.contains(MaterialState.pressed)) {
                        return Colors.yellow;
                      }
                      return Colors.green;
                    })),
                child: Text('我是轮廓按钮'),
                onPressed: () {
                  print('我点击了轮廓按钮');
                },
                onLongPress: () {
                  print('我是长按的事件');
                },
              ),
            )
          ],
        ));
  }
}
```

```dart
import 'package:flutter/material.dart';

// 通过主题 设置样式
class ButtonDemo extends StatelessWidget {
  const ButtonDemo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(10),
        child: Wrap(
          runSpacing: 20,
          children:[
            Container(
                width: double.infinity,
                height: 50,
                // 这里还可以通过主题去设置样式
                child: ElevatedButtonTheme(
                  data: ElevatedButtonThemeData(
                      style: ButtonStyle(
                          overlayColor: MaterialStateProperty.all(Colors.red))),
                  child: ElevatedButton(
                    child: Text('我是凸起按钮'),
                    onPressed: () {
                      print('我点击了凸起按钮');
                    },
                  ),
                )),
          ],
        ));
  }
}

```

- 图标按钮

```dart
// 可以通过命名函数的形式 去声明 图标按钮 
import 'package:flutter/material.dart';

class ButtonDemo extends StatelessWidget {
  const ButtonDemo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(10),
        child: Wrap(
          runSpacing: 20,
          children: [
            Container(
              // 图标按钮
              child: IconButton(
                // 点击的时候水波纹颜色
                splashColor: Colors.lightBlue,
                // 高亮 和 上面的只能选一个
                highlightColor: Colors.purple,
                // 长按的时候 会有提示
                tooltip: '怎么了',
                // 图标
                icon: const Icon(
                  Icons.add_alarm,
                  color: Colors.red,
                ),
                // 事件
                onPressed: () {},
              ),
            ),
            // 也可以通过命名构造函数 来声明 文字按钮 凸起按钮 和轮廓按钮
            TextButton.icon(
                onPressed: () {},
                style: ButtonStyle(
                    minimumSize: MaterialStateProperty.all(Size(800, 60))),
                icon: Icon(Icons.add_circle),
                label: Text(
                  '是我',
                  style: TextStyle(fontSize: 20.0),
                ))
          ],
        ));
  }
}

```

- 按钮组

```dart
//按钮组
class ButtonDemo extends StatelessWidget {
  const ButtonDemo({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(10),
        child: Wrap(
          runSpacing: 20,
          children: [
            Container(
              width: double.infinity,
              // 按钮组 是从右向左排列 横向 如果 按钮数量查出了 就会从上向下排列
              child: ButtonBar(children: [
                OutlinedButton(onPressed: () {}, child: Text('按钮1')),
                OutlinedButton(onPressed: () {}, child: Text('按钮1')),
                OutlinedButton(onPressed: () {}, child: Text('按钮1')),
                OutlinedButton(onPressed: () {}, child: Text('按钮1')),
                // OutlinedButton(onPressed: () {}, child: Text('按钮1')),
                // OutlinedButton(onPressed: () {}, child: Text('按钮1'))
              ]),
            )
          ],
        ));
  }
}

```

- 其他按钮

```dart
class ButtonDemo extends StatelessWidget {
  const ButtonDemo({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(10),
        child: Wrap(
          runSpacing: 20,
          children: [
            // 就是一个左侧的小箭头
            const BackButton(),
            // 关闭按钮 就是一个小xx
            CloseButton()
          	]),
            )
          ],
        ));
  }
}

```

- 浮动按钮

```dart
// 这里的浮动按钮 要配合Scaffold 组件来使用 和appbar body 是同级关系
class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Flex',
          style: TextStyle(color: Colors.red),
        ),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: ButtonDemo(),
      // 浮动按钮  
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
```

### 图片

#### Image.asset

- 加载本地图片
- 需要在Flutter 项目下 创建图片存储目录
- 需要在 pubspec.yaml 添加图片配置

```yaml
需要在 pubspec.yaml 中指定你的图片地址
flutter:
  # asset 中指定你的图片
  assets:
    - images/01e0c155438ba00000019ae99edfaa.jpg@1280w_1l_2o_100sh.jpg
    # - images/a_dot_ham.jpeg
  fonts: 
    - family: maobi
      fonts:
        - asset: asset/maobi.ttf
          weight: 400
          style: normal  
  uses-material-design: true

```

```dart
// 然后就可以使用了
class ImgDemo extends StatelessWidget {
  const ImgDemo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          child: Image.asset(
            'images/01e0c155438ba00000019ae99edfaa.jpg@1280w_1l_2o_100sh.jpg',
            width: 200,
            height: 200,
            // 设置图片裁切模式 有平铺之类的
            fit: BoxFit.cover,
          ),
        )
      ],
    );
  }
}
```

#### Image.network

- 加载网络图片
- 设置网络权限 参考 Card
- 允许通过http协议访问

```dart
// 需要配配置 android\app\src\main\AndroidManifest.xml 文件 开启网络权限 和配置 允许http 访问 
class ImgDemo extends StatelessWidget {
  const ImgDemo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          child: Image.network(
            'https://img.zcool.cn/community/01f21f5b4055c8a80120b95900fa20.jpg@2o.jpg',
            width: 200,
            height: 200,
            // 设置图片裁切模式 有平铺之类的
            fit: BoxFit.cover,
            // 跟背景颜色混合
            colorBlendMode: BlendMode.colorDodge,
          ),
        )
      ],
    );
  }
}
```

### 列表

#### SingleChildScrollView 

- 类似 Android 中的 ScrollView
- 只能显示一个子组件 子组件太大显示不开 才滚动
- child 子组件 padding 内边距 scrollDirection 滚动方向水平还是垂直
- reverse 初始滚动位置 false 头部 true 尾部
- physics 滚动的效果 ClampingScrollPhysics 安卓的下围观效果 BouncingScrollPhysics 苹果下弹性效果

```DART
class SingleChildScrollViewDemo extends StatelessWidget {
  const SingleChildScrollViewDemo({Key? key}) : super(key: key);
  List<Widget> btnList() {
    List<Widget> list = <Widget>[];
    for (var i = 0; i < 20; i++) {
      list.add(OutlinedButton(onPressed: () {}, child: Text('按钮$i')));
    }
    return list.toList();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SingleChildScrollView(
          // 水平方向滚动
          scrollDirection: Axis.horizontal,
          // 这里还可以给内边距
          padding: EdgeInsets.all(10),
          // 给了这个属性 就是从最后向开始滚动了
          reverse: true,
          child: Row(
              // 按钮已经超出屏幕了 所以需要设置滚动了
              children: [
                ...btnList(),
              ]),
        ),
        SingleChildScrollView(
          // 这是滚动的方向 这里是垂直
          scrollDirection: Axis.vertical,
          // 如果不设置下面 就不会有下拉的效果
          physics: BouncingScrollPhysics(),
          child: Column(
            // 生成一个数组  
            children: List.generate(
                20,
                (index) =>
                    OutlinedButton(onPressed: () {}, child: Text('按钮$index'))),
          ),
        )
      ],
    );
  }
}
```

#### ListView

- 列表组件 可以自己滚动
- ListTile 在布局组件中有介绍
- 这列表一定要在外层元素有设置高度

```dart
class ListViewBasic extends StatelessWidget {
  const ListViewBasic({Key? key}) : super(key: key);
  Widget list(index) {
    return ListTile(
      leading: Icon(Icons.assessment_outlined),
      title: Text('我是第$index个图标'),
      subtitle: Text('我是第$index子图标'),
      trailing: Icon(Icons.keyboard_double_arrow_right),
      // 表示 第三个选中
      selected: index == 3 ? true : false,
      selectedColor: Colors.pink, // 设置了选中的颜色
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // 这里一定要给定高度  
      height: 400,
      child: ListView(
        // 这个属性可以指定 垂直滚动还是 水平滚动
        // scrollDirection: Axis.horizontal,
        // padding: EdgeInsets.all(20),
        children: List.generate(40, list),
      ),
    );
  }
}
```



#### ListView.builder

- 可以按需加载组件 适用于组件较多的场景

```dart
class ListViewBuild extends StatelessWidget {
  ListViewBuild({Key? key}) : super(key: key);
  List<Widget> list = new List<Widget>.generate(
      20,
      (index) => ListTile(
            leading: Icon(Icons.assessment_outlined),
            title: Text('我是第$index个图标'),
            subtitle: Text('我是第$index子图标'),
            trailing: const Icon(Icons.keyboard_double_arrow_right),
            // 表示 第三个选中
            selected: index == 3 ? true : false,
            selectedColor: Colors.pink, // 设置了选中的颜色
          ));
  @override
  Widget build(BuildContext context) {
    print(list);
    return Container(
      height: 150,
      child: ListView.builder(
          // 需要指定列表的长度
          itemCount: list.length,
          // 每一项的高度
          // itemExtent: 30,
          // 返回每一项
          itemBuilder: (context, int) {
            return list[int];
          }),
    );
  }
}
```



#### ListView.separated

- 比ListView.builder 多了 分隔器 

```dart
class ListViewSeparate extends StatelessWidget {
  ListViewSeparate({Key? key}) : super(key: key);
  List<Widget> list = new List<Widget>.generate(
      20,
      (index) => ListTile(
            leading: Icon(Icons.assessment_outlined),
            title: Text('我是第$index个图标'),
            subtitle: Text('我是第$index子图标'),
            trailing: const Icon(Icons.keyboard_double_arrow_right),
            // 表示 第三个选中
            selected: index == 3 ? true : false,
            selectedColor: Colors.pink, // 设置了选中的颜色
          ));
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      child: ListView.separated(
          // padding: 也可以设置 内边距
          // 返回了分割线组件 当然这里你也可以用 别的组件 把列表分割开 这里可以通过int 拿到列表的每一项 做控制
          separatorBuilder: (context, int) {
            return Divider();
          },

          // 需要指定列表的长度
          itemCount: list.length,
          // 每一项的高度
          // itemExtent: 30,
          // 返回每一项
          itemBuilder: (context, int) {
            return list[int];
          }),
    );
  }
}
```

```dart
class ListViewSeparate extends StatelessWidget {
  ListViewSeparate({Key? key}) : super(key: key);
  List<Widget> list = new List<Widget>.generate(
    40,
    (index) => ListTile(
      leading: Icon(Icons.assessment_outlined),
      title: Text('我是第$index个图标'),
      subtitle: Text('我是第$index子图标'),
      trailing: const Icon(Icons.keyboard_double_arrow_right),
      // 表示 第三个选中
      selected: index == 3 ? true : false,
      selectedColor: Colors.pink, // 设置了选中的颜色
    ),
  );
  @override
  Widget build(BuildContext context) {
    // 这里如果向沾满全屏 可以使用   Expanded 组件
    return Expanded(
        child: ListView.separated(
            separatorBuilder: (context, int) {
              return Divider();
            },
            // 表示用子组件的高度
            // shrinkWrap: true,
            // physics: NeverScrollableScrollPhysics(),
            // 需要指定列表的长度
            itemCount: list.length,
            // 每一项的高度
            // itemExtent: 30,
            // 返回每一项
            itemBuilder: (context, int) {
              return list[int];
            }));
  }
}
```

#### GridView 网格布局

- children 子组件
- scrollDirection 滚动方向
- gridDelegate 值有 SliverGridDelegateWithFixedCrossAxisCount 指定列数宽度自适应 和 SliverGridDelegateWithMaxCrossAxisExtent 指定宽度 列数自适应
- GridView.count 列数固定宽度自适应 和 GridView.extend 宽度固定列数自适应 以上都是 上一项的语法糖
- GridVIew.build 动态网格布局
- crossAxisSpacing 和 mainAxisSpacing 宫格和宫格之间的间隔 这个 跟轴的方向有关
- childAspectRadio 值得有 childWidth 和 ChildHeight 子组件的宽高
- crossAxisCount 指定的个数

```dart
// 列数固定 宽高自适应
class GridViewDemo extends StatelessWidget {
  const GridViewDemo({Key? key}) : super(key: key);
  List<Widget> list() {
    return List.generate(
        20,
        (index) => Container(
              color: Color.fromARGB(255 - index * 2, 192, index * 10, 0),
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
      child: GridView(
        //列数固定 宽高自适应 控制列数 宫格与宫格之间的距离 还有 子元素的狂高比例等
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            // 列数固定 宽高自适应
            //控制列数
            crossAxisCount: 2,
            mainAxisSpacing: 10, // 宫格和宫格之间的间距 水平
            crossAxisSpacing: 10, // 宫格和宫格之间的间距 垂直
            // 子组件的狂高比例
            childAspectRatio: 1.5),
        children: [...list()],
      ),
    );
  }
}
```

```dart
// 宽高固定 列数自适应
class GridViewDemo1 extends StatelessWidget {
  const GridViewDemo1({Key? key}) : super(key: key);
  List<Widget> list() {
    return List.generate(
        20,
        (index) => Container(
              color: Color.fromARGB(255 - index * 2, 192, index * 10, 0),
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
      child: GridView(
        // 宽高固定 列数自适应
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          // 设置子组件的宽高 会根据宽高设置的不同 列数自动设置 比如100的时候 就是4列 200百的时候就是2列
          maxCrossAxisExtent: 100,
          mainAxisSpacing: 10, // 宫格和宫格之间的间距 水平
          crossAxisSpacing: 10, // 宫格和宫格之间的间距 垂直
          // 子组件的狂高比例
        ),
        children: [...list()],
      ),
    );
  }
}
```

- GridVIew 命名构造函数

```dart
//GridView.count 固定列数 宽高自适应

class GridViewDemo extends StatelessWidget {
  const GridViewDemo({Key? key}) : super(key: key);
  List<Widget> list() {
    return List.generate(
        20,
        (index) => Image.asset(
            'images/01e0c155438ba00000019ae99edfaa.jpg@1280w_1l_2o_100sh.jpg'));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
      child: GridView.count(
        children: [...list()],
        // 控制列数
        crossAxisCount: 2,
        // 横向间隔
        mainAxisSpacing: 10,
        // 纵向间隔
        crossAxisSpacing: 10,
        // 只压缩了宫格的比例 图片的比列不会被压缩
        // childAspectRatio: 1.5,
        // 内边距 水平方向 和垂直方向
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      ),
    );
  }
}
```

```dart
// Grid.extent 固定宽高 列数自适应
class GridViewDemo1 extends StatelessWidget {
  const GridViewDemo1({Key? key}) : super(key: key);
  List<Widget> list() {
    return List.generate(
        20,
        (index) => Image.asset(
            'images/01e0c155438ba00000019ae99edfaa.jpg@1280w_1l_2o_100sh.jpg'));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
      child: GridView.extent(
        children: [...list()],
        // 控制宽高
        maxCrossAxisExtent: 100,
        // 横向间隔
        mainAxisSpacing: 10,
        // 纵向间隔
        crossAxisSpacing: 10,
        // 只压缩了宫格的比例 图片的比列不会被压缩
        // childAspectRatio: 1.5,
        // 内边距 水平方向 和垂直方向
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      ),
    );
  }
}
```

```dart
// GridView.builder 自定义列表 跟我们的自定义ListView 类似
class GridViewDemo2 extends StatelessWidget {
  const GridViewDemo2({Key? key}) : super(key: key);
  List<Widget> list() {
    return List.generate(
        20,
        (index) => Container(
              color: Color.fromARGB(255 - index * 3, 6, index * 10, 173),
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
      child: GridView.builder(
          // 这里需要是按列数固定 还是 宽高固定
          gridDelegate: const  (
              crossAxisCount: 2,
              // mainAxisExtent: 10,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10),
        // 滚动的反弹效果
       // physics: BouncingScrollPhysics(),
       // 夹住的效果 还有两种 一个是不滚动 一个是 正常滚动不太常用
       // physics: ClampingScrollPhysics(),
          itemCount: list().length,
          // 列表的长度 这里 可以在这里 函数里做很多的事情
          itemBuilder: (BuildContext, int) {
            return list()[int];
          }),
    );
  }
}
```

### 其他

- Material 安卓等个的组件 使用的时候 import 'package:flutter/material.dart';
- Cupertino IOS风格的组件 使用的时候  import 'package:flutter/cupertino.dart'; 

```dart
//  比如弹框组件 安卓 和ios 的风格不一致 这里就需要我们根据是那个平台去判断使用什么样的组件
//  这里可以通过 import 'dart:io' 核心库来判断平台

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io';

class myApp extends StatelessWidget {
  const myApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Flutter APP',
      // theme: ThemeData(fontFamily: 'maobi'),
      home: Home(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'cupertino',
          style: TextStyle(color: Colors.red),
        ),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: MyBody(),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {},
      //   tooltip: 'Increment',
      //   child: const Icon(Icons.add),
      // ),
    );
  }
}

class MyBody extends StatelessWidget {
  const MyBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //Platform 这个是 dart:io中的 平台 可以通过这个来判断 ios 还是 android
    print(Platform.isIOS);
    return Column(
      children: [Platform.isIOS ? IosAlert() : AndRiodAlert()],
    );
  }
}
// 安卓的弹框
class AndRiodAlert extends StatelessWidget {
  const AndRiodAlert({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      // 弹框标题
      title: const Text('提示'),
      // 内容
      content: const Text('弹框内容'),
      // 底部按钮
      actions: [
        TextButton(
            onPressed: () {
              print('点击AndRoid取消');
            },
            child: Text('取消')),
        TextButton(
            onPressed: () {
              print('点击AndRoid确定');
            },
            child: Text('确定'))
      ],
    );
  }
}
// IOS风格的弹框
class IosAlert extends StatelessWidget {
  const IosAlert({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      title: const Text('提示'),
      content: const Text('弹框内容'),
      actions: [
        TextButton(
            onPressed: () {
              print('点击IOS取消');
            },
            child: Text('取消')),
        TextButton(
            onPressed: () {
              print('点击IOS确定');
            },
            child: Text('确定'))
      ],
    );
  }
}

```

#### safeArea

- 主要是解决 异性屏幕问题 比如刘海屏
- 可以理解为container

#### RefreshIndicator

- 下拉刷新

```dart
class _RefreshLoadState extends State<RefreshLoad> {
  int itemCount = 10;
  List<String> _list = [
    '张飞',
    '关于',
    '黄忠',
    '马超',
    '赵云',
    '许褚',
    '典韦',
    '曹彰',
    '吕布',
    '周泰'
  ];
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
        
        // 指示器显示距顶部位置
        displacement: 80,
        // 指示器颜色
        color: Colors.red,
        // 是否应处理滚动通知检查
        notificationPredicate: defaultScrollNotificationPredicate,
      
        child: ListView.builder(
            itemCount: itemCount,
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.all(30),
                child: Text('${_list[index]}'),
              );
            }),
        onRefresh: _onRefresh);
  }

  Future _onRefresh() {
    return Future.delayed(Duration(seconds: 2), () {
      setState(() {
        // itemCount = 10;
        _list = ['宋江', '晁盖', '吴用', '卢俊义', '秦明', '呼延灼', '徐宁', '刘唐', '王英', '李逵'];
      });
    });
  }
}
```

#### 上拉加载

- 就是利用列表的 滑动监视器去做

```dart
class _ScrollLoadState extends State<ScrollLoad> {
  // 添加滚动控制器 这里别忘了 给 我们的listview 组件  
  ScrollController _scrollController = ScrollController(); //listview 的控制器
  List _list = [];
  int _page = 1;
  bool isLoading = false;

  @override
  // 在初始化的时候 就开启监听  
  void initState() {
    super.initState();
    _getData();
    //监听划到最底部就进行if内的操作
    _scrollController.addListener(() {
      print('滑动了');
      // 这个是判定 屏幕滑动到哪里了  
      if (_scrollController.position.pixels >
          _scrollController.position.maxScrollExtent - 20) {
        print('滑动到了最底部');
        Future.delayed(Duration(seconds: 3), () {
          _getData();
        });
      }
    });
  }
  // 获取数据的方法	
  _getData() async {
    setState(() {
      _list.addAll([
        'xxxxx',
        'sdfdsgfg',
        '2323245',
        'dsadsafdg',
        'fsd23fewgh',
        'dsfgdfg',
        'fdsfdg33',
        'r43rfrgd',
        'e32wrfeg',
        'r3ttehj'
      ]);
      _page++;
    });
  }
  // 当我们拉到最下面的时候 显示的组件 就是一个loading的样式	
  Widget _getMoreWidget() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: const <Widget>[
            Text(
              '加载中...',
              style: TextStyle(fontSize: 16.0),
            ),
            CircularProgressIndicator(
              strokeWidth: 1.0,
            )
          ],
        ),
      ),
    );
  }
  // 上拉刷新的逻辑	
  Future<void> _onRefresh() async {
    print('执行刷新');
// this._getData();
    await Future.delayed(Duration(seconds: 3), () {
      print('refresh');
    });
  }

  @override
  Widget build(BuildContext context) {
    return _list.length > 0
        ? ListView.builder(
            itemCount: _list.length,
            controller: _scrollController,
            itemBuilder: (context, index) {
              if (index == _list.length - 1) {
                // 2. 这里就是 显示 当我们的页面渲染了 我们要显示什么 这里可以理解为 列表已经显示的底部了  
                return Column(
                  children: [
                    ListTile(
                      title: Text(
                        '${_list[index] + '2'}',
                        maxLines: 1,
                      ),
                    ),
                    Divider(),
                    _getMoreWidget()
                  ],
                );
              } else {
                //1. 最开始的时候我们肯定是 显示 一些数据  
                return Column(
                  children: [
                    ListTile(
                      title: Text(
                        '${_list[index]}',
                        maxLines: 1,
                      ),
                    ),
                    Divider()
                  ],
                );
              }
            })
        : _getMoreWidget();
  }
}
```

#### WillPopScope

- 监听手机返回案件

```markdown
1. 我们需要在 onWillPop 写返回 bool true 就是 可以返回到手机桌面 false 就是不可以
2. 所以我们在点击手机返回的时候 要弹框 通过确定或者取消按钮来 决定返回页面
```

```dart
class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('监听返回'),
      ),
      body: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);
  // 这里记住一定要写入 await 或者 async  
  Future<bool> _dialogExitApp(context) async {
    return await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Text('是否推出'),
            actions: [
              ElevatedButton(
                  onPressed: () {
                    return Navigator.of(context).pop(true);
                  },
                  child: Text('确定')),
              ElevatedButton(
                  onPressed: () {
                    return Navigator.of(context).pop(false);
                  },
                  child: Text('取消'))
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // 这里也是一样  
        return await _dialogExitApp(context);
      },
      child: Container(
        child: Text('监听返回'),
      ),
    );
  }
}
```

#### dialog

```markdown
1. 主要还是 要在点击的函数事件里调用 showDialog
2. 然后里面 showDialog函数里面接收 context 和 builder 函数
3. builder 函数 返回 对应的组件 你是弹框啊 还是 选择框等
4. 这里可以用 async 和 await的形式 接收返回值
```

```dart
class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  _alertDialog(context) async {
    // 这里就相当于一个新的弹层了
    bool flag = await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('提示信息'),
            content: Text('确定要删除么'),
            // 定义按钮
            actions: [
              ElevatedButton(
                  onPressed: () {
                    // 这里就是关闭了弹框了
                    Navigator.pop(context, false);
                  },
                  child: const Text('确定')),
              ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context, true);
                  },
                  child: const Text('取消'))
            ],
          );
        });
    return flag;
  }
  // 选择的弹框
  _selectDailog(context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
            title: Text('选择内容'),
            children: [
              SimpleDialogOption(
                child: Text('optionA'),
                onPressed: () {
                  print('optionA');
                  // 使用这种方式取消 然后依然 可以 用 我们 alert的方式 去接收值
                  Navigator.pop(context);
                },
              ),
              SimpleDialogOption(
                child: Text('optionB'),
                onPressed: () {
                  print('optionB');
                },
              )
            ],
          );
        });
  }

  // 底部弹框 这里就可以用一些不了比如 滑动之类的
  _modelBottomSheet(context) async {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Container(
            color: Colors.red,
            child: Column(children: [
              ListTile(
                title: Text('A'),
              ),
              ListTile(
                title: Text('A'),
              ),
              ListTile(
                title: Text('A'),
              ),
              ListTile(
                title: Text('A'),
              ),
              ListTile(
                title: Text('A'),
              )
            ]),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ElevatedButton(
              onPressed: () async {
                bool flag = await _alertDialog(context);
                print('点击了按钮,打印的变量是$flag');
              },
              child: const Text('alert弹出框')),
          ElevatedButton(
              onPressed: () {
                _selectDailog(context);
              },
              child: const Text('select弹出框')),
          ElevatedButton(
              onPressed: () {
                _modelBottomSheet(context);
              },
              child: const Text('actionSheet底部弹出框')),
          ElevatedButton(onPressed: () {}, child: const Text('toast第三方库')),
        ],
      ),
    );
  }
}

```

#### 自定dialog

```markdown
1. 自定义dialog 需要继承 flutter 中的 Dialog类
2. 需要返回一个 Material 组件
3. 调用的时候 还是在 showDialog函数中去调用 传入 context 在builder 里 返回 我们的自定义dialog
```

```dart
class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);
  showCustomDialog(context) {
    // 2. 这里返回我们自定义的 dialog  
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return MyDialog();
        });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ElevatedButton(
              onPressed: () {
                // 1.点击按钮的时候和我们前面一致 调用 showDialog函数  
                showCustomDialog(context);
              },
              child: const Text('自定义dialog')),
        ],
      ),
    );
  }
}

// 3. 自定义的dialog 需要继承 flutter 中的 Dialog 类 返回一个 Material 组件 里面就可以设置你自己的内容了
class MyDialog extends Dialog {
  const MyDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      // 透明的背景
      type: MaterialType.transparency,
      // 你的主体
      child: Flex(
        direction: Axis.horizontal,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            color: Colors.white,
            width: 300.00,
            height: 200.0,
          )
        ],
      ),
    );
  }
}
```



## 第三方库

### Dio

- 发请求的库 可以理解为Axios
- 需要在 pubspec.yaml 添加 下载下

```yaml
dependencies:
  flutter:
    sdk: flutter
  # The following adds the Cupertino Icons font to your application.
  # Use with the CupertinoIcons class for iOS style icons.
  cupertino_icons: ^1.0.2
  # 这里保存就好了
  dio: ^4.0.6

dev_dependencies:
  flutter_test:
    sdk: flutter
```

```dart
import 'package:flutter/material.dart';
// 引入了 dio·
import 'package:dio/dio.dart'

class DioDemo extends StatelessWidget {
  const DioDemo({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () {
        getIpAddress();
      },
      icon: Icon(Icons.accessibility_new_outlined),
      label: Text('点击发送请求'),
    );
  }

  void getIpAddress() async {
    final url = 'https://httpbin.org/ip';
    var dio = Dio();
    final response = await dio.get(url);
    // 所有的数据都在data 里  
    print(response.data['origin']);
  }
}

```

### Flutter_swiper

- 轮播图的库 可以兼容 安卓和ios
- 在yaml文件里添加
- 引入  import 'package:flutter_swiper/flutter_swiper.dart';

#### 报错

```markdown
1. 我们有的时候安装第三方包的时候会报错 null-safety 这个关键字 就是启动了空安全 
2. 解决方案是 运行命令的时候 flutter run --no-sound-null-safety
3. 或者在项目跟目录添加 .vscode/launch.json
```

```json
//launch.json
{
  // 使用 IntelliSense 了解相关属性。 
  // 悬停以查看现有属性的描述。
  // 欲了解更多信息，请访问: https://go.microsoft.com/fwlink/?linkid=830387
  "version": "0.2.0",
  "configurations": [
      {
          "name": "hollebug",
          "request": "launch",
          "type": "dart",
          "args": [
              "--no-sound-null-safety"
          ]
      },
      {
          "name": "hollebug (profile mode)",
          "request": "launch",
          "type": "dart",
          "flutterMode": "profile"
      },
  ]
}
```

- 轮播图

```dart
import 'package:flutter_swiper/flutter_swiper.dart';
class FlutterSwiperDemo extends StatelessWidget {
  FlutterSwiperDemo({Key? key}) : super(key: key);
  List<Widget> list = [
    Image.network(
      'https://img.zhisheji.com/bbs/forum/201406/24/160859eow43j4uxm63u64u.jpg',
      fit: BoxFit.fill,
    ),
    Image.network(
        fit: BoxFit.fill,
        'https://ts1.cn.mm.bing.net/th/id/R-C.4096bf3dd761be0de783f300d56a7a07?rik=J0YJ3pyb%2bSG%2fyg&riu=http%3a%2f%2fimages2.china.com%2fnews%2fzh_cn%2fsocial%2f1007%2f20140402%2f201404021445521376500.jpg&ehk=kYNayr6xcpZvab%2bQ%2bBOOsMytupEslNICrasYHUPSOmI%3d&risl=&pid=ImgRaw&r=0'),
    Image.network(
        fit: BoxFit.fill,
        'https://ts1.cn.mm.bing.net/th/id/R-C.076829dac02fc05dc5aff7d362f06993?rik=d88xxDA5EvqiPQ&riu=http%3a%2f%2fn.sinaimg.cn%2fsinakd20210126ac%2f755%2fw479h276%2f20210126%2fd3e5-kicwvzq7504936.jpg&ehk=orko8bzLacEutT%2fybG9L0LrGsdBB1pq7QUoemrFyy%2fg%3d&risl=&pid=ImgRaw&r=0&sres=1&sresct=1'),
  ];
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Text('我是轮播图'),
        Container(
          height: 200,
          child: Swiper(
            itemCount: list.length,
            itemBuilder: (ctx, index) {
              return list[index];
            },
            // 轮播图 小圆点
            pagination: SwiperPagination(),
            // 左右的小箭头
            control: SwiperControl(),
            // 缩放每张图片的效果
            // viewportFraction: 0.7,
            // 缩放附图的效果 达到3d的效果
            // scale: 0.7,
            // 指定每个轮播图的宽度
            // itemWidth: 300,
            // 卡片的抽除效果
            // layout: SwiperLayout.STACK,
            itemHeight: 200,
            itemWidth: double.infinity,
            // 卡片的滑入效果
            layout: SwiperLayout.TINDER,
          ),
        )
      ],
    );
  }
}
```

### shared_preferences

- 本地数据缓存库
- 在pubsepc.yaml中添加依赖 
- 引入 import 'package:shared_preferences/shared_preferences.dart';

```dart
class SharedPreferencesDemo extends StatelessWidget {
  const SharedPreferencesDemo({Key? key}) : super(key: key);
  plus() async {
    // 1. 首先要 创建一个SharedPreferences 的实例 是一个异步方法
    final prefs = await SharedPreferences.getInstance();
    // 2. 调用 getInt 方法先去取以下 如果没有 就赋值为0 如果取出来就设置+1
    // 这里 我们村数字 还可以存 setBool 布尔 setString字符串 setStringList和字符串数组
    int count = (prefs.getInt('counter') ?? 0) + 1;
    // 3. 最后在调用方法存入进去
    await prefs.setInt('counter', count);
    print(prefs.getInt('counter'));
  }

  degression() async {
    // 4. 取值的时候也要 创建实例
    final prefs = await SharedPreferences.getInstance();
    int num = (prefs.getInt('counter') ?? 0) - 1;
    await prefs.setInt('counter', num);
    print(prefs.getInt('counter'));
  }

  remover() async {
    // 5.清空
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('counter');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(
        children: [
          ElevatedButton(onPressed: plus, child: Text('增加')),
          ElevatedButton(onPressed: degression, child: Text('减少')),
          ElevatedButton(onPressed: remover, child: Text('删除'))
        ],
      ),
    );
  }
}
```

## 状态管理

- StatefulWidget 有状态组件
- DataTable 表格
- InheritedWidget 跨组件的状态分享
- 生命周期
- Provider

### StatefulWidget

- StatefulWidget 由两部分组件
- 第一步就是 StatefulWidget  继承与 StatelessWidget 是不可变
- 第二部就是 State  你的状态组件都将继承这个 

```dart
// 1. 要 继承 StatefulWidget
class MyState extends StatefulWidget {
  const MyState({Key? key}) : super(key: key);

  @override
  // 2. 要实现   createState 方法 返回一个 State类型的子类
  State<MyState> createState() => _MyStateState();
}
// 3. 要继承 State
class _MyStateState extends State<MyState> {
  String num = '我是默认值';
  plus() {
    // 调用setState 改变状态
    setState(() {
      num = '我改变了状态';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Text(num),
          ElevatedButton(onPressed: plus, child: Text('改变状态'))
        ],
      ),
    );
  }
}
```

### DataTable

- flutter 中的表格
- columns 表头列表 DataColumn 表头的单元格
- rows 数据列表 DataRow 一行数据 DataCell 数据单元格

```dart
// 静态数据
class MyBody extends StatelessWidget {
  const MyBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: UserList(),
      alignment: Alignment.center,
    );
  }
}

class UserList extends StatefulWidget {
  const UserList({Key? key}) : super(key: key);

  @override
  State<UserList> createState() => _UserListState();
}

class _UserListState extends State<UserList> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        // 设置表头
        child: DataTable(
         columns: const [
          DataColumn(label: Text('姓名')),
          DataColumn(label: Text('年龄')),
          DataColumn(label: Text('性别')),
          DataColumn(label: Text('简介')),
          DataColumn(label: Text('工作'))
        ], 
         // 设置行数据 下面是只有一行   
         rows: const [
          //    DataRow 是一行数据 DataCell 是一行里面的单元格
          DataRow(cells: [
            DataCell(Text('张三')),
            DataCell(Text('20')),
            DataCell(Text('男人')),
            DataCell(Text('一个男人')),
            DataCell(Text('专业写bug的'))
          ])
        ]));
  }
}
```

```dart
class User {
  String name;
  int age;
  bool select;
  User(this.name, this.age, {this.select = false});
}

class _UserListState extends State<UserList> {
  @override
  List<User> data = [
    User('晁盖', 19),
    User('宋江', 16),
    User('阮小二', 20, select: true),
    User('吴用', 22),
    // {'name': '晁盖', 'age': 19, 'sex': '男'}
  ];
  List _getUserRows() {
    List<DataRow> dataRows = [];
    for (var i = 0; i < data.length; i++) {
      dataRows.add(DataRow(
          // 选中的选项 会有样式
          selected: data[i].select,
          // 加了这个事件以后 选择框就会出来 然后可以设置选中了
          onSelectChanged: (seleced) {
            setState(() {
              data[i].select = seleced as bool;
            });
          },
          cells: [
            DataCell(Text('${data[i].name}')),
            DataCell(Text('${data[i].age}')),
            i % 2 == 0 ? DataCell(Text('男')) : DataCell(Text('女')),
            DataCell(Text('----')),
            DataCell(Text('没工作'))
          ]));
    }
    return dataRows;
  }

  bool _sortAscending = false;
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
            // 用表头的哪一项排序 这里 1 对应我们表头的年龄
            sortColumnIndex: 1,
            // 升序排列 还是降序排列
            sortAscending: _sortAscending,
            // 行之间高度
            dataRowHeight: 100,
            // 水平之间的margin
            horizontalMargin: 20,
            // 列和列之间的间距
            columnSpacing: 100,
            columns: [
              //表头的字段
              DataColumn(label: Text('姓名')),
              DataColumn(
                  label: Text('年龄'),
                  // 表示年龄可以排序
                  numeric: true,
                  // 年龄的表头上会出现排序的小箭头 点击就会触发如下事件
                  onSort: (int columnIndex, bool asscending) {
                    setState(() {
                      _sortAscending = asscending;
                      if (asscending) {
                        data.sort((a, b) => a.age.compareTo(b.age));
                      }
                    });
                  }),
              DataColumn(label: Text('性别')),
              DataColumn(label: Text('简介')),
              DataColumn(label: Text('工作'))
            ],
            rows: [
              ..._getUserRows()
            ]
            ));
  }
}
```

### InheritedWidget

- 提供了沿树向下 共享数据的功能
- 即子组件可以获取父组件 InheritedWidget 的数据
- 一个跨组件的传输方案 

```markdown
1. 首先要 声明一个 InheritedWidget  这里就是有你需要子组件取来的值
3. 然后用你声明的 InheritedWidget 包裹子组件
3. 子组件中就可以通过 你声明的这个 InheritedWidget 上的 静态方法of 获取到 你的值
```

```dart
//1.  声明 InheritedWidget 组件 
class ShareDataWidget extends InheritedWidget {
  // 子组件
  final Widget child;
  // num 就是我们 子组件需要获取的值
  final int num;
  //required num 必须传
  ShareDataWidget({Key? key, required this.child, required this.num})
      : super(key: key, child: child);

  // 静态方法
  static ShareDataWidget? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<ShareDataWidget>();
  }

  // 数据变更了 通知组件更新
  @override
  bool updateShouldNotify(ShareDataWidget oldWidget) {
    return true;
  }
}
```

```dart
// 2. 然后包裹跟组件
class MyState extends StatefulWidget {
  const MyState({Key? key}) : super(key: key);

  @override
  State<MyState> createState() => _MyStateState();
}

class _MyStateState extends State<MyState> {
  int num = 0;
  plus() {
    setState(() {
      ++num;
    });
  }

  @override
  Widget build(BuildContext context) {
    // 用我们声明   ShareDataWidget 组件包裹了跟组件 
    return ShareDataWidget(
        child: Container(
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              // 这个组件 我们需要用的 ShareDataWidget组件中的num
              Mycounter(),
              ElevatedButton(onPressed: plus, child: const Text('增加'))
            ],
          ),
        ),
        num: num);
  }
}
```

```dart
// 3. 在子组件中 可以通过 ShareDataWidget 静态方法of 获取值
class Mycounter extends StatefulWidget {
  Mycounter({Key? key}) : super(key: key);

  @override
  State<Mycounter> createState() => _MycounterState();
}

class _MycounterState extends State<Mycounter> {
  @override
  Widget build(BuildContext context) {
    return Container(
      // 给Text 传入 ShareDataWidget 的 num 数据 需要传递content
      child: Text(ShareDataWidget.of(context)!.num.toString()),
    );
  }
}
```

### 生命周期

- 这里 声明周期只针对 有状态组件来定义的
- initState()  组件对象插入到元素树中时 会被调用 只调用一次
- didChangeDependencies() 当前状态对象的依赖改变时 这里比如 孙组件 用到了父组件的值 但是父组件值变了 孙组件就会调用这个
- build() 组件渲染的时候
- setState()  组件对象内部状态变更时
- didUpdateWidget() 组件配置更新时
- deactivate() 组件对象在元素树种暂时移时 比如切换页面
- dispose()  组件对象在元素树种永远移出时 比如关闭app 

![image-20220726145352921](F:\新笔记\flutter\image-20220726145352921.png)

```dart
class MyState extends StatefulWidget {
  MyState({Key? key}) : super(key: key);

  @override
  State<MyState> createState() => _MystateState();
}

class _MystateState extends State<MyState> {
  late int _num;
  @override
  void initState() {
    // 固定写法
    super.initState();
    print('init state');
    _num = 1;
  }

  @override
  void didChangeDependencies() {
    // // 固定写法
    super.didChangeDependencies();
    print('didChangeDependencies');
  }

  @override
  void didUpdateWidget(covariant MyState oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
    print('didUpdateWidget');
  }

  @override
  void deactivate() {
    // TODO: implement deactivate
    super.deactivate();
    print('deactivate');
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    print('dispose');
  }

  plus() {
    setState(() {
      _num++;
    });
  }

  @override
  Widget build(BuildContext context) {
    print('build');
    return Container(
      child: Column(
        children: [
          Text('$_num'),
          ElevatedButton(onPressed: plus, child: Text('+'))
        ],
      ),
    );
  }
}
```

### Provider

- 一个第三方库 基于 InheritedWidget的封装
- 使用还是和 原来一样 需要包裹跟组件 
- 有数据生产者 和消费这  生产者 更改数据之后 然后 调用通知方法 通知消费者
- 需要创建一个数据模型 ChangeNotifier
- 需要把数据 注册到 观察者 ChangeNotifierProvider

```dart
1. 创建数据模型 继承 ChangeNotifier
class LikesModel extends ChangeNotifier {
  int _counter = 0;
  int get counter => _counter;
  // 改变数据的方法
  incrementCounter() {
    // 累加
    _counter++;
	
    // 这里一定要调用 notifyListeners 通知消费者改变数据 
    notifyListeners();
  }
}
```

```dart
2. 把数据模型 注册到跟组件中 这样 后代组件都可以使用
class MyBody extends StatelessWidget {
  const MyBody({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      // 把数据模型 注册到 ChangeNotifierProvider
      child: ChangeNotifierProvider(
        // 这里要写入你注册的数据模型
        create: (BuildContext context) => new LikesModel(),
        // MyHome 组件就可以使用了  
        child: MyHome(),
      ),
    );
  }
}
```

```dart
3. 后代组件 可以通过 context.watch<LikesModel>() 来调用你的数据
4. 也可以通过使用 Provider.of<LikesModel>(context) 来获取你的数据模型
class MyHome extends StatelessWidget {
  const MyHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          // 这里使用  context.watch<LikesModel>()._counter 来拿到数据 context不光有watch 还有很多别的api这里我们制作单纯的监控
          Text('${context.watch<LikesModel>().counter}'),
          TextButton(
              // Provider.of<LikesModel>(context).incrementCounter 方法来 改变数据 incrementCounter 上一定要写notifyListeners 通知函数
              onPressed: Provider.of<LikesModel>(context).incrementCounter,
              child: const Icon(Icons.thumb_down))
        ],
      ),
    );
  }
```

## 路由与导航

- 匿名路由
- 命名路由
- 动态路由
- 路由传参
- Drawer 导航
- BottomNavigationBar 导航
- Tab 导航

### Route

- 一个路由可以是一个屏幕或页面的抽象

### Navigator

- 管理路由的组件 通过路由入栈和出栈来实现页面之间跳转
- initalRoute 初始路由 默认页面
- onGenerateRoute 动态路由
- onUnknownRoute 位置路由 404
- routes 路由集合

### 匿名路由

- 没有指定名称 可以理解为直接跳组件 

```dart
class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
        child: ElevatedButton(
            onPressed: () {
              // 调用 Navigator.push 跳转到 商品详情页面 Product 就是一个页面
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Product()));
            },
            child: Text(
              '跳转到商品页面',
            )));
  }
}


class Product extends StatelessWidget {
  const Product({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Product'),
      ),
      body: Container(
        child: ElevatedButton(
            onPressed: () {
              // 调用 pop 返回
              Navigator.pop(context);
            },
            child: Text('返回首页')),
      ),
    );
  }
}
```

### 匿名路由传参

- 在跳转的时候 通过向构造函数里传递参数

```dart
class _HomePageState extends State<HomePage> {
  late int num = 0;
  @override
  Widget build(BuildContext context) {
    print(num);
    return Container(
      child: Column(
        children: [
          ElevatedButton(
              onPressed: () {
                // 跳转的时候 把参数 传到 Product的构造函数里了  
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Product(id: num)));
                setState(() {
                  ++num;
                });
              },
              child: const Text('商品详情'))
        ],
      ),
    );
  }
}
```

### 小结

- 可以通过构造函数的方式传参

```dart
onTap: () {
  Navigator.push(
    context,
    MaterialPageRoute(
      // 这里就通过 构造函数方式传递了参数   
      builder: (context) => DetailScreen(todo: todos[index]),
    ),
  );
}

// DetailScreen 在接收的时候 需要 定义参数

class DetailScreen extends StatelessWidget {
  // 这里就在构造函数里定义了参数  
  const DetailScreen({super.key, required this.todo});
  final Todo todo;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(todo.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(todo.description),
      ),
    );
  }
}
```

- 可以通过 RouteSettings 传递参数

```dart
onTap: () {
Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => const DetailScreen(),
    // 跳转的时候 通过设置 settings 去传递  
    settings: RouteSettings(
      arguments: todos[index],
    ),
  ),
);
},

// DetailScreen 接收 通过 ModalRoute.of(context)!.settings.arguments  去接收

class DetailScreen extends StatelessWidget {
  const DetailScreen({super.key});
  @override
  Widget build(BuildContext context) {
    // 这里是在build 里接收的参数  
    final todo = ModalRoute.of(context)!.settings.arguments as Todo;
    return Scaffold(
      appBar: AppBar(
        title: Text(todo.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(todo.description),
      ),
    );
  }
}
```



```dart
// 接收的时候 就在构造函数里声明对应的 变量即可
class Product extends StatelessWidget {
  int id;
  Product({Key? key, required this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('商品详情')),
      body: Container(
        child: Column(
          children: [
            Text('${id}'),
            ElevatedButton(
                onPressed: () => Navigator.pop(context), child: Text('返回'))
          ],
        ),
      ),
    );
  }
}
```

​	

### 命名路由

- 需要先声明路由 然后进行跳转
- routes 路由表
- initalRoute 初始路由 默认页面
- onUnknownRoute 未知路由 跳转404 可以理解为通配符
- 使用 Navigator.pushNamed(context,'路由名称')

```dart
MaterialApp(
    // 理解为注册表
	routes :{
        'first': () => FirstPage()
        'second':() => SecondPage()   
    },
    // 初始页面
    initialRoute:'first'
    // 当匹配不到名字的时候 跳转到404
    onUnknownRoute:(RouteSettings setting) => MaterialPageRoute( builder:(context) => UnknownPage())
)
```

```dart
// 初始页
class myApp extends StatelessWidget {
  const myApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // 路由表
    return MaterialApp(
      routes: {
        'home': (context) => const Home(),
        'product': ((context) => const Product())
      },
      // 默认显示
      initialRoute: 'home',
      // 跳转路由表没有的路径的时候跳转到别地
      onUnknownRoute: (settings) =>
          MaterialPageRoute(builder: (context) => UnknownPage()),
      title: 'nameroute',
      // theme: ThemeData(fontFamily: 'maobi'),
      // home: Home(),
      debugShowCheckedModeBanner: false,
    );
  }
}
```

```dart
// Home 页

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('首页'),
        leading: const Icon(Icons.menu),
        actions: [const Icon(Icons.settings)],
        elevation: 0.0,
        centerTitle: true,
      ),
      body: Center(
          child: Column(
        children: [
          ElevatedButton(
              onPressed: () {
                // 跳转到  'product' 页面
                Navigator.pushNamed(context, 'product');
              },
              child: const Text('跳转'))
        ],
      )),
    );
  }
}
```

```dart
// 商品页面

class Product extends StatelessWidget {
  const Product({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('商品页'),
        leading: const Icon(Icons.menu),
        actions: [const Icon(Icons.settings)],
        elevation: 0.0,
        centerTitle: true,
      ),
      body: Center(
          child: Column(
        children: [
          ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('返回')),
          ElevatedButton(
              onPressed: () {
                // 跳转到 位置页面
                Navigator.pushNamed(context, 'product1');
              },
              child: const Text('跳转'))
        ],
      )),
    );
  }
}
```

### 命名路由传参

- 通过Navigator.pushNaned  传递 arguments 参数 挂在参数
- 接受组件 通过 ModalRouteof(context).setting.arguments 接收
- ModalRouteof(context).setting.arguments 这里是 Object 类型 我们在用的时候 需要转换成Map 才能使用里面的参数

```dart
class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('首页'),
      ),
      body: Container(
        child: Column(
          children: [
            ElevatedButton(
                onPressed: () {
                  // 跳转的时候 携带参数跳转  
                  Navigator.pushNamed(context, 'product',
                      arguments: {'title': '夏凉被'});
                },
                child: const Text('商品页'))
          ],
        ),
      ),
    );
  }
}
```

```dart
// 命名路由表
class myApp extends StatelessWidget {
  const myApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // 路由表
    return MaterialApp(
      routes: {
        'home': (context) => const Home(),
        'product': ((context) => Prodcut())
      },
      // 默认显示
      initialRoute: 'home',
      // 跳转路由表没有的路径的时候跳转到别地
      onUnknownRoute: (settings) =>
          MaterialPageRoute(builder: (context) => UnknownPage()),
      title: 'nameroute',
      // theme: ThemeData(fontFamily: 'maobi'),
      // home: Home(),
      debugShowCheckedModeBanner: false,
    );
  }
}
```

```dart
// 使用参数
class Prodcut extends StatelessWidget {
  Prodcut({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final Object? arguments = ModalRoute.of(context)!.settings.arguments;
    return Scaffold(
      appBar: AppBar(
        title: Text('商品页'),
      ),
      body: Container(
        child: Column(
          children: [
            Text('我的名字是' + (arguments as Map)['title']),
            ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('返回'))
          ],
        ),
      ),
    );
  }
}
```

### 动态路由

- 使用  Navigator.pushNamed 第二个参数传递路径
- 然后在 onGenerateRoute 中做判断 
- 匹配路径去跳转

```DART
MaterialApp(
	// 通过 onGenerateRoute 生成动态路由
    onGenerateRoute:(settings) {
        if(settings.name === '/'){  return MaterialPageRoute(builder:(context) => HomeScreen()) }
        // 传递参数
        var uri = Uri.parse(settings.name);
        if(uri.pathSegments.length == 2 && uri.pathSegments.first == 'details'){
            var id = uri.pathSeg.emts[1]
                return MaterialPageRoute(builder:() => DetailScreen(id:id));
        }
        // 最后跳转到 未知路由
        return MaterialPageRoute(builder:(context) => UnknownScreen());
    }
)
```

```dart
// 条船页面的时候 需要带参数传递 就是我们的
class Home extends StatelessWidget {
  Home({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('首页'),
        leading: const Icon(Icons.menu),
        actions: [const Icon(Icons.settings)],
        elevation: 0.0,
        centerTitle: true,
      ),
      body: Center(
          child: Column(
        children: [
          ElevatedButton(
              onPressed: () {
                // 这里通过路径去调转 带了一个id 为1 的参数
                Navigator.pushNamed(context, '/product/1');
              },
              child: const Text('跳转商品详情页1'))
        ],
      )),
    );
  }
}
```

```dart
//  在 MaterialApp 中需要 添加 onGenerateRoute 动态路由函数 然后根据 跳转的路径去判断
class myApp extends StatelessWidget {
  const myApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
	  // 动态路由 和命名路由不能同时共用
      onGenerateRoute: (settings) {
        // settings.name 就是你刚刚跳转的时候带的路径
        if (settings.name == '/') {
          return MaterialPageRoute(builder: (context) => Home());
        }
        // 这里解析了 路径 存放在了一个数组里  
        var uri = Uri.parse(settings.name!);
        if (uri.pathSegments.length == 2 &&
            uri.pathSegments.first == 'product') {
          // [product,1]  
          // 然后传递到我们页面的构造函数里了  
          return MaterialPageRoute(builder: (context) => Product(id: id));
        }
        return MaterialPageRoute(builder: (context) => UnknownPage());
      },
      title: 'nameroute',
      // theme: ThemeData(fontFamily: 'maobi'),
      // home: Home(),
      debugShowCheckedModeBanner: false,
    );
  }
}
```

```dart
// 接收 我们需要在页面的构造函数接受 路由传递过来的参数
class Product extends StatelessWidget {
  final String id;
  // 这里接受传递过来的参数   
  const Product({Key? key, required this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('商品页'),
        leading: const Icon(Icons.menu),
        actions: [const Icon(Icons.settings)],
        elevation: 0.0,
        centerTitle: true,
      ),
      body: Center(
          child: Column(
        children: [
          Text('传过来的商品id是${id}'),
          ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('返回')),
        ],
      )),
    );
  }
}
```

### 替换路由

```markdown
1. 有的时候 我们从第一个跳到第二个页面 第二个跳到第三个页面
2. 当从第三个页面返回的时候 我们希望直接返回第一个页面
3. 那么用命名路由 我们就可以使用 Navigator.pushReplacementNamed(context, '/') 把上一个页面地换成 跟页面
```

```dart
import 'package:flutter/material.dart';
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Passing Data',
        // home: HomePage(),
        initialRoute: '/',
        routes: {
          '/': (context) => HomePage(),
          '/s': (context) => Scoend(),
          '/ThressPage': (context) => ThressPage()
        });
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('我是第一个页面'),
      ),
      body: Container(
        child: Column(
          children: [
            ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/s');
                },
                child: Text('去第二个页面'))
          ],
        ),
      ),
    );
  }
}

class Scoend extends StatelessWidget {
  const Scoend({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('我是第二个页面'),
      ),
      body: Container(
        child: Column(
          children: [
            ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/ThressPage');
                },
                child: Text('去第三 个页面'))
          ],
        ),
      ),
    );
  }
}

class ThressPage extends StatelessWidget {
  const ThressPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('我是第三个页面'),
        leading: Icon(Icons.search),
      ),
      body: Container(
        child: Column(
          children: [
            ElevatedButton(
                onPressed: () {
                  // 就是把当前页面 替换成你想要的页面  
                  Navigator.pushReplacementNamed(context, '/');
                  // 这个方法就是 把所有路由都置换为空 然后 写入你要跳转的页面  
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => HomePage()),
                      (route) => false);
                },
                child: Text('返回'))
          ],
        ),
      ),
    );
  }
}

```

### Drawer

- 抽屉菜单 可以从手机 左侧(drawer) 和右侧（endDrawer) 划入画出
- 在Scaffold 中 定义 
- 里面可以嵌套 UserAccountsDrawerHeader 来绘制抽屉菜单的头部
- AboutListTile 弹出 关于弹窗

```dart
class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  List<Widget> getList() {
    List<Widget> list = [];
    for (var i = 0; i < 3; i++) {
      list.add(ListTile(
        title: Text('选项$i'),
        trailing: const Icon(Icons.arrow_forward_ios),
        // 还有点击事件
        onTap: () => print('$i'),
      ));
      list.add(const Divider());
    }
    // 最上面插入了弹框头部组件
    list.insert(
        0,
        const UserAccountsDrawerHeader(
            // 设置头像
            currentAccountPicture: CircleAvatar(
              backgroundImage: AssetImage(
                  'images/01e0c155438ba00000019ae99edfaa.jpg@1280w_1l_2o_100sh.jpg'),
            ),
            // 修饰了背景图片
            decoration: BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage(
                        'images/01e0c155438ba00000019ae99edfaa.jpg@1280w_1l_2o_100sh.jpg'))),
            accountName: Text('初六'),
            accountEmail: Text('1052101962@qq.com')));
    // 末尾添加弹框
    list.add(const AboutListTile(
      applicationName: "你的应用名称",
      applicationVersion: '1.0.0',
      child: Text('关于'),
      icon: CircleAvatar(
        // 在列表上 文字左侧显示
        child: Text('前置图标'),
      ),
      applicationLegalese: '应用法律条列',
      aboutBoxChildren: [Text('条例一'), Text('条例二')],
    ));
    return list;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('drawer'),
      ),
      body: const Text('我是主要内容'),
      // endDrawer 也可以指定右侧
      // DRAWER 组件
      drawer: Drawer(
        child: ListView.builder(
          padding: const EdgeInsets.all(0),
          itemBuilder: (context, index) {
            return getList()[index];
          },
          itemCount: getList().length,
        ),
      ),
    );
  }
}
```

### BottomNavigationBar 导航

- items 属性 数组 包含导航的列表 每一项都是 BottomNavigationBarItem
- currentIndex 当前导航的索引
- type 导航类型 BottomNavigationBarRype  比如固定在底部啊 变背景色啊
- onTap() 点击的事件 会返回索引

```dart
class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // 配置索引 默认显示的索引
  int currentIndex = 0;
  // 配置底部导航栏 每一项都是一个 BottomNavigationBarItem
  List<BottomNavigationBarItem> bnList = [
    const BottomNavigationBarItem(
        icon: Icon(
          Icons.home,
        ),
        label: '首页',
        backgroundColor: Colors.green),
    const BottomNavigationBarItem(
        icon: Icon(
          Icons.access_alarm_rounded,
        ),
        label: '分类',
        backgroundColor: Colors.pink),
    const BottomNavigationBarItem(
        icon: Icon(
          Icons.my_library_add,
        ),
        label: '我的',
        backgroundColor: Colors.blue)
  ];
  //配置 导航栏对应的页面
  List<Widget> pageList = [
    Container(
      child: const Text('首页'),
    ),
    Container(
      child: const Text('分类'),
    ),
    Container(
      child: const Text('我的'),
    )
  ];
  // 点击的时候 动态切换索引 然后导航栏也会跟着改变
  _change(index) {
    setState(() {
      currentIndex = index;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('bottomNavigationBar')),
      // 根据索引显示对应的页面
      body: pageList[currentIndex],
      // 底部导航栏
      bottomNavigationBar: BottomNavigationBar(
        // 固定的导航栏  BottomNavigationBarType.shfing 每次点击的时候 变换背景颜色
        type: BottomNavigationBarType.shifting,
        // 导航列表
        items: bnList,
        // 默认索引
        currentIndex: currentIndex,
        onTap: (index) {
          // 改变索引 来切换页面
          _change(index);
        },
      ),
    );
  }
}
```

### Tab导航

- DefaultTabController 整个的Tab 容器
- 属性 length 声明导航数量
- 属性 child 指定子组件
- TabBar 导航菜单
- 属性 tabs 导航菜单的数组
- TabBarView 导航页面
- 属性 children 多个导航页面内容

```markdown
1. 首先 要用 DefaultTabController 包裹 有个child 组件 里面可以设置 Scaffold 里面
2. DefaultTabController 的 length属性 要设置 你tab的数量
3. Scaffold 的 body 属性 要设置 TabBarView 组件 里面的children 就是 你tabs里对应的页面
4. TabBar 可以设置在 整个页面的 底部 就在 scaffold 里 bottom设置 也可以 设置在appbar 中
5. TabBar 里的tabs 属性就是一个数组 里面是你所有的tab
```

```dart
 static List<Widget> tabs = List.generate(
      titleList.length,
      (index) => Tab(
            text: titleList[index],
            // child: Text(
            //   '${titleList[index]}',
            //   style: const TextStyle(color: Colors.black),
            // ),
          ));
  static List<Widget> tabPageList = List.generate(
      titleList.length,
      (index) => Container(
            child: Text('${titleList[index]}'),
          ));

List<Widget> pageList = [
    // 要用 DefaultTabController 包裹
    DefaultTabController(
        // 这里就是数量
        length: titleList.length,
        child: Scaffold(
          appBar: AppBar(
            // 也可以放在 title 里面 TabBar 里面的 tabs 就是你的一个一个tabs
            title: Row(
              children: [
                Expanded(
                    child: TabBar(
                  // 指示器的 宽度 和文字等宽
                  indicatorSize: TabBarIndicatorSize.label,
                  // 此外还有指示器的颜色 底部的padding 治时期的高度等
                  // 是否可以滚动
                  isScrollable: true,
                  tabs: tabs,
                  // 设置字体颜色
                  labelColor: Color.fromARGB(255, 199, 80, 0),
                  // 设置没有被选中的颜色
                  unselectedLabelColor: Colors.black,
                )),
              ],
            ),
            // toolbarHeight: 10.0,
            // 设置背景颜色
            backgroundColor: Color.fromARGB(0, 255, 255, 255),
            elevation: 0.0,
            // tabbar 选项卡 可以放在标头下面
            // bottom: TabBar(
            //   tabs: tabs,
            //   // 设置字体颜色
            //   labelColor: Color.fromARGB(255, 199, 80, 0),
            //   // 设置么有被选中的颜色
            //   unselectedLabelColor: Colors.black,
            // ),
          ),
          // 这里就是对应的页面  
          body: TabBarView(children: tabPageList),
        )),
    Container(
      child: const Text('分类'),
    ),
    Container(
      child: const Text('我的'),
    )
  ];
```

- TabBarController

```markdown
1. 首先你的页面类 是一个有状态的组件 并且 要 with SingleTickerProviderStateMixin
2. 需要 实例化一个 TabController(length: 2, vsync: this) length 就是你页面的数量 第二个参数固定写法
3. 实例化的 TabController 要挂在到 TabBar上 和 TabView 的controller 属性上
4. 其余的写法都和以前一致
5. TabController 实例上就提供了 很多 方法 比如当点击的时候 的监听事件等等 当前的索引
```

```dart
class _TabBarContorllerPageState extends State<TabBarContorllerPage>
// 要 with SingleTickerProviderStateMixin
    with
        SingleTickerProviderStateMixin {
  late TabController _tabController;
  @override
  // 在 initState 生命周期函数里 要 实例化 TabController
  void initState() {
    // TODO: implement initState
    super.initState();
    // 这里是固定写法 initialIndex:1 表示默认选中的tab 是谁
    _tabController = TabController(length: 2, vsync: this,initialIndex:1);
    // 添加点击的监听事件
    _tabController.addListener(() {
      print(_tabController.index);
      // print(_tabController.);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('tabbarcontorller'),
        bottom: TabBar(
          tabs: <Widget>[Tab(text: '热销'), Tab(text: '推荐')],
          // 这记得 要把实例化的 _tabController 赋值给 controller
          controller: _tabController,
        ),
      ),
      // ignore: prefer_const_literals_to_create_immutables
      body: TabBarView(
          controller: _tabController, children: [Text('热销'), Text('推荐')]),
    );
  }
}
```

## 表单

- Swithc
- Checkbox
- Radio
- TextField
- 日历
- Form

### Switch

- value 开关的值 一般与状态绑定
- onChanged 开关状态变更时调用
- activeColor 开关开启时 圆圈颜色
- activeTrackColor 开关关闭时的圆圈的颜色
- inactiveThumbColor 开关关闭时圆圈颜色
- inactiveTrackColor 开关关闭时轨道颜色
- CupertinoSwitch ios风格的开关

```dart
class _SwitchDemoState extends State<SwitchDemo> {
  bool _switchvalue = false;
  @override
  Widget build(BuildContext context) {
    return Container(
        child: ListView(
      children: [
        ListTile(
          leading: Switch(
              // 选中圆圈的颜色
              activeColor: Color.fromARGB(255, 0, 65, 25),
              //未选中圆圈的颜色
              inactiveThumbColor: Colors.red,
              // 选中轨道的颜色
              activeTrackColor: Colors.green,
              // 未选中轨道的颜色
              inactiveTrackColor: Colors.blueAccent,
              value: _switchvalue,
              onChanged: (bool value) {
                setState(() {
                  _switchvalue = value;
                });
              }),
          title: Text('当前开关状态${_switchvalue ? "开" : "关"}'),
        ),
        Divider(),
        ListTile(
          leading: CupertinoSwitch(
              // 选中圆圈的颜色
              activeColor: Color.fromARGB(255, 0, 65, 25),
              //未选中圆圈的颜色
              // inactiveThumbColor: Colors.red,
              // // 选中轨道的颜色
              // activeTrackColor: Colors.green,
              // // 未选中轨道的颜色
              // inactiveTrackColor: Colors.blueAccent,
              value: _switchvalue,
              onChanged: (bool value) {
                setState(() {
                  _switchvalue = value;
                });
              }),
          title: Text('当前开关状态${_switchvalue ? "开" : "关"}'),
        )
      ],
    ));
  }
}
```

### Checkbox

- value 复选框的值
- onChanged 复选框状态更改时调用
- activeColor 选中时 复选框背景的颜色
- checkColor 选中时 复选框中对号的颜色

```dart
class _CheckBoxPageState extends State<CheckBoxPage> {
  final List<Map> _listName = List.generate(
      30,
      (index) =>
          {'label': '选项$index', 'seleced': index % 2 == 0 ? true : false});

  List<Widget> _listItems() {
    List<Widget> ListItems = [];
    for (var i = 0; i < _listName.length; i++) {
      print(_listName[i]['label']);
      ListItems.add(ListTile(
        leading: Checkbox(
          // 选中的时间
          onChanged: (value) {
            print(value);
            setState(() {
              _listName[i]['seleced'] = value;
            });
          },
          // 是否选中
          value: _listName[i]['seleced'],
          // 选中的颜色
          activeColor: Colors.pink,
          // 对勾的颜色
          checkColor: Colors.black,
        ),
        title: Text('${_listName[i]['label']}'),
      ));
    }
    return ListItems;
  }
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [...listBoxTile()],
    );
  }
}
```



### CheckboxListTile

- title 标题 subtitle 子标题
- 选中框 在右侧

```dart
class _CheckBoxPageState extends State<CheckBoxPage> {
  final List<Map> _listName = List.generate(
      30,
      (index) =>
          {'label': '选项$index', 'seleced': index % 2 == 0 ? true : false});
  // 选择框在最右边
  List<Widget> listBoxTile() {
    List<Widget> listBoxTile = [];
    for (var i = 0; i < _listName.length; i++) {
      listBoxTile.add(CheckboxListTile(
          // 文本也被选中了
          selected: _listName[i]['seleced'],
          // 选中的颜色
          activeColor: Colors.pink,
          // 对勾的颜色
          checkColor: Colors.black,
          // 前面的图标
          secondary: const Icon(Icons.settings),
          // 绑定的值
          value: _listName[i]['seleced'],
          // 标题
          title: Text('${_listName[i]['label']}'),
          // 小标题
          subtitle: Text('我是小标题'),
          onChanged: (value) {
            setState(() {
              _listName[i]['seleced'] = value;
            });
          }));
    }
    return listBoxTile;
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [...listBoxTile()],
    );
  }
}
```

### Radio

- 基本上和 checkbox 差不多

```dart
class RadioList extends StatefulWidget {
  RadioList({Key? key}) : super(key: key);

  @override
  State<RadioList> createState() => _RadioListState();
}

class _RadioListState extends State<RadioList> {
  // 两个单选框的 同一个属性
  var groupValue = 1;

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      Text('男'),
      Radio(
          // 单选框的值
          value: 1,
          // 属于组
          groupValue: groupValue,
          onChanged: (value) {
            setState(() {
              // 改变单选框
              groupValue = value as int;
            });
          }),
      Text('女'),
      Radio(
          value: 2,
          groupValue: groupValue,
          onChanged: (value) {
            setState(() {
              groupValue = value as int;
            });
          }),
    ]);
  }
}

```

```DART
class _RadioListTileDemoState extends State<RadioListTileDemo> {
  int groupValue = 1;
  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        RadioListTile(
          value: 1,
          groupValue: groupValue,
          onChanged: (value) {
            setState(() {
              groupValue = value as int;
            });
          },
          subtitle: Text('有胡子'),
          // 在右边的图标
          secondary: Icon(Icons.person),
          // 文字是否选中
          selected: groupValue == 1,
          // 选中的 背景颜色
          selectedTileColor: Colors.green[100],
          title: Text('男'),
        ),
        RadioListTile(
          value: 2,
          groupValue: groupValue,
          onChanged: (value) {
            setState(() {
              groupValue = value as int;
            });
          },
          subtitle: Text('没胡子'),
          // 在右边的图标
          secondary: Icon(Icons.person),
          // 文字是否选中
          selected: groupValue == 2,
          // 选中的 背景颜色
          selectedTileColor: Colors.green[100],
          title: Text('女'),
        ),
      ],
    );
  }
}
```

### TextField

- autofocus  是否获取焦点
- keyboardType  键盘类型 字母键盘 和数字键盘
- obscureText  设置密码框 
- decoration 样式修饰
- onChanged 内容更改时自动调用 value
- labelText 标题
- hintText 提示文字 - placeholder
- maxLines 显示行数 文本域

```dart
class _TextFieldDemoState extends State<TextFieldDemo> {
  String username = '';
  String password = '';
  String description = '';
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(20.0),
      children: [
        TextField(
          // 自动获取焦点
          autofocus: true,
          // 获取焦点的时候 会弹出键盘 键盘是手机号的
          keyboardType: TextInputType.phone,
          // label 和 默认提示  和图标等
          decoration: const InputDecoration(
              // 边框颜色等
              enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.green)),
              // 获取焦点的时候 边框颜色
              focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.red)),
              labelText: '手机号',
              hintText: ' 请输入手机号',
              prefixIcon: Icon(Icons.mobile_screen_share)),
          // 最多可以输入 11 个
          maxLength: 11,
          // 输入的时候需要赋值
          onChanged: (value) {
            setState(() {
              username = value;
            });
          },
        ),
        TextField(
          // 改变为密码框
          obscureText: true,
          // 获取焦点的时候 会弹出键盘 键盘是手机号的
          keyboardType: TextInputType.text,
          // label 和 默认提示
          decoration:
              const InputDecoration(labelText: '密码', hintText: ' 请输入密码'),
          // 最多可以输入 11 个
          maxLength: 11,
          // 输入的时候需要赋值
          onChanged: (value) {
            setState(() {
              password = value;
            });
          },
        ),
        TextField(
          // 获取焦点的时候 会弹出键盘 键盘是手机号的
          keyboardType: TextInputType.text,
          // label 和 默认提示
          decoration:
              const InputDecoration(labelText: '简介', hintText: ' 请介绍以下自己'),
          // 最多可以输入 11 个
          maxLength: 11,
          // 输入多行就变成文本域了
          maxLines: 5,
          // 输入的时候需要赋值
          onChanged: (value) {
            setState(() {
              description = value;
            });
          },
        )
      ],
    );
  }
}
```

- 输入框默认值

```dart
class _TextFieldDemoState extends State<TextFieldDemo> {
  String username = '';
  String password = '';
  String description = '';
  // 通过控制器可以给输入框默认值  
  final TextEditingController controller = new TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // 这里就是设置我们的默认值  
    controller.value = TextEditingValue(text: '1380361561');
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(20.0),
      children: [
        TextField(
          // 给定控制器
          controller: controller,
          autofocus: true,
          keyboardType: TextInputType.phone,
          decoration: const InputDecoration(
              enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.green)),
              focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.red)),
              labelText: '手机号',
              hintText: ' 请输入手机号',
              prefixIcon: Icon(Icons.mobile_screen_share)),
          maxLength: 11,
          onChanged: (value) {
            setState(() {
              username = value;
            });
          },
        )
      ],
    );
  }

```



### CalendarDatePicker 日历选择器

- initialCalendarMode 属性DatePickerMode.day 属性 DatePickerMode.year

### showDatePicker 日期选择器

- initialDatePickerMode (year | day) initialEntryMode (calendar | input )

### showTimePicker 时间选择器

- 代码量太大 查看文档吧

### Form

- 整个表单的容器
- 创建表单 Form 并以GlobalKey 作为唯一性标识
- key(GlobalKey)
- child 子组件
- TextFormFiled 必须声明在 Form 中 带有验证器
- validator 验证器

```markdown
1. Form 属性
2. 创建表单唯一的key 验证的时候使用 final GlobalKey<FormState> _formKey = GlobalKey<FormState>()
3. 验证表单 _formKey.currentState.validate();
4. 提交表单 _formKey.currentState.save();
5. 重置表单 _formKey.currentState.reset();
```

```markdown
1. TextFormField 输入框 带验证器
2. validator 验证器
3. obscureText 密码框
4. onSave 设定表单字段的值 在表单的save方法之后执行
```

```dart
class _FormDemoState extends State<FormDemo> {
  // 位置的标识 在找表单的时候就比较好找
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String userName = '';
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          Form(
            child: Column(
              children: [
                TextFormField(
                  onSaved: (value) {
                    userName = value as String;
                  },
                  decoration: InputDecoration(hintText: '手机号'),
                  // 写验证规则
                  validator: (value) {
                    RegExp reg = new RegExp(r'^\d{11}$');
                    if (!reg.hasMatch(value as String)) {
                      return '手机号非法';
                    }
                    return null;
                  },
                ),
                Row(
                  children: [
                    Expanded(
                        child: ElevatedButton(
                            onPressed: () {
                              // 调取验证
                              if (_formKey.currentState!.validate()) {
                                // 验证通过之后 调用保存方法
                                print('提交成功');
                                // 这里会调用我们上面表单项的 onsave 方法
                                _formKey.currentState!.save();
                                // 值就已经保存上了
                                print(userName);
                              }
                            },
                            child: Text('提交')))
                  ],
                )
              ],
            ),
            key: _formKey,
          )
        ],
      ),
    );
  }
}
```

## 其他

- 动画
- 多语言
- 多主题
- 缓存页面

### 动画

- 补间动画
- 拟物动画
- Animation 是flutter 库中的一个核心类 包含动画的值和状态两个属性 定义了动画的一系列监听函数
-  监听值 addListener removeListener
- 监听状态 addStatusListener removeStatusListener

```markdown
1. AnimationStatus.dismissed 动画的初始状态
2. AnimationStatus.completed 动画的结束状态
3. AnimationStatus.forward 动画处在从开始到结束的运行状态
4. AnimationStatus.reverse 动画处在从结束到开始的运行状态
```

AnimationController 动画控制器

- 在指定时间内 将组件的属性的值 由初始值演变到终止值 从而形成动画效果
- AnimationController 参数
- duration 动画的执行时间
- reverseDuration 动画反向执行时间
- lowerBound = 0.0 动画最小值 运动的值区间
- upperBound = 1.0 动画的最大值  运动的值的区间
- value  动画初始值 默认是 lowerBound
- vsync TickerProvider 类型的对象 用来创建 Ticker 对象

```markdown
1. 创建一个AnimationController时 需要传递一个必填参数 vsync 参数
2. 作用是 防止屏幕外动画 消耗不必要的资源 主要是通知组件更新 比如当我们一个组件淡入淡出的时候 就是让ticker去通知的 当我们把这个组件的页面切换到出去了 那么 就需要不让他执行淡入淡出了 也要 ticker 通知
3. 通过将SingleTickerProbiderStateMixin 添加到类的定义中 可以将 stateful 对象作为vsync的值
```

```markdown
1. AnimationController 具有控制动画的方法
2. .forward() 可以正向执行动画
3. .reverse() 可以反向执行动画
4. .dispose() 用来释放动画资源 在不使用时需要调用该方法 否则会造成资源泄露
5. .stop 停止动画
```

```markdown
AnimationController 动画生成值的默认区间 是 0.0 到 1.0 如果希望使用不同的徐建 或不同的数据类型 需要是用 Tween 补简动画 
Tween 的 唯一职责就是定义从输入范围 到 输出范围的映射
例如 颜色区间 是 0 到 255
Tween 
Tween<double> begin 起始值 end 终止值
ColorTween (bengin:Colors.withe,end:Colors.black)
```

```markdown
1. CurvedAnimation  动画曲线匀速  曲线之类的
2. CurvedAnimation (parent:controller,curve:Curves.easeIn)
3. parent 动画控制器对象 curve 正向执行的动画曲线 reverseCurve 反向执行的动画曲线
4. Curves  动画曲线 https://api.flutter.dev/flutter/animation/Curves-class.html
```

```markdown
1. 动画步骤
2. 创建动画控制器 controller = AnimationController(duration,vsync);
3. 创建动画  动画曲线 CurvedAnimation 补间动画 Tween
4. 监听动画 addListener 监听动画生成值 addStatusListener 监听动画状态
5. 执行动画 controller.forward() 正向执行 controller.reverse()反向执行
```

#### 步骤

```markdown
1. 首先我们要创建动画 就需要我们的 with SingleTickerProviderStateMixin 混入类
2. 然后 创造一个动画控制器实例 AnimationController 和一个 动画效果的实例(动画曲线) 
3. 动画控制器上实例上 AnimationController 我们需要指定 动画执行的实现 和固定写法的 vsync:this 
4. 动画效果实例 我们需要指定 需要作用在哪个动画控制器上 和 动画曲线 比如是匀速直线的 还是 变速曲线的等等
5. 这里 AnimationController 实例的 补间值 是value 只有 0 -1 如果我超出了这个范围 就需要用到 补间的实例 Tween
6. 创建 补间实例 begin 和 end 指定 补间范围 和 需要作用的 动画控制器
7. 然后 把我们的补间范围 作用在 你需要 动画的大小上 比如 我字体的大小 
8. 最后开始 调用动画控制器上的 开始动画 和 反转动画  方法等
```

```dart
class _AnimationDemoState extends State<AnimationDemo>
    with SingleTickerProviderStateMixin {
  // 创建动画控制器
  late AnimationController controller;
  // 创建动画曲线
  late Animation animation;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = AnimationController(
        // 这里是固定写法
        vsync: this,
        // 动画执行的时间 里面有一些时间的单位 毫秒 天数 等
        duration: const Duration(milliseconds: 4000));
    // 指定 动画曲线 应用在 那个动画控制器上
    animation = CurvedAnimation(parent: controller, curve: Curves.bounceIn);
    // 设置 动画补间的范围 这里就是要告诉 你要从50 给我 到 500 然后设置在动画控制器上
    animation = Tween(begin: 50.0, end: 400.0).animate(controller);
    // 监听动画 执行情况 这里可以打印出 动画执行的值
    animation.addListener(() {
      // 这里的默认值 value 应该是 0-1 但是我们图标要用到很大 所以 就用了 Tween
      // print(animation.value);
      setState(() {});
    });

    // 执行动画
    // controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          ElevatedButton(
              onPressed: () {
                // 动画开始正向执行
                controller.forward();
              },
              child: Text('方法')),
          ElevatedButton(
              onPressed: () {
                // 动画开始反向执行
                controller.reverse();
              },
              child: Text('缩小')),
          ElevatedButton(
              onPressed: () {
                print('object');
                animation.addStatusListener((status) {
                  print(status);
                  // 如果动画 执行完毕了
                  if (status == AnimationStatus.completed) {
                    controller.reverse();
                  } else if (status == AnimationStatus.dismissed) {
                    controller.forward();
                  }

                  // controller.forward();
                });
                controller.forward();
              },
              child: Text('重复')),
          ElevatedButton(
              onPressed: () {
                // 动画开始反向执行
                controller.stop();
              },
              child: Text('停止')),
          Icon(
            Icons.favorite,
            color: Color.fromARGB(255, 255, 0, controller.value.toInt()),
            // 我们这里 图标的大小向应用动画 所以就给了size 属性
            size: animation.value,
          )
        ],
      ),
    );
  }
}
```

### 交织动画

- 由多个单一动画叠加而成的复杂动画
- 比如 组件变化可能涉及高度 宽度 颜色 透明度 位置 等
- 需要给每个动画设置时间间隔

### Transform 

- Transform.translate() 平移
- Transform.rotate() 旋转
- Transform.scale() 缩放

```markdown
1. 我们可以 多定义一些动画
2. 然后使用 Interval 函数 规定 在哪写时间 执行哪些动画
3. 动画在执行补间的时候 可以 设置 interval 的时间
```

```dart
class _AnimationDemoState extends State<AnimationDemo>
    with SingleTickerProviderStateMixin {
  // 定义控制器
  late AnimationController _controller;
  // 定义动画曲线
  late Animation animation;
  // 定义 文字大小的动画
  late Animation sizeAnimation;
  // 定义 颜色 变换的 动画
  late Animation colorAnimation;
  // 定义旋转的动画
  late Animation rotateonAnimation;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // 实例化控制器
    _controller =
        AnimationController(vsync: this, duration: Duration(seconds: 3));
    // 实例画动画效果
    animation = CurvedAnimation(
        parent: _controller,
        // 声明 前百分之五十的动画
        curve: Interval(0.0, 0.5))
      ..addListener(() {
        setState(() {});
      });
    // 让动画反复执行
    animation.addStatusListener((status) {
      // 如果动画 执行完毕了
      if (status == AnimationStatus.completed) {
        _controller.reverse();
      } else if (status == AnimationStatus.dismissed) {
        _controller.forward();
      }
    });

    // 设置其他动画
    sizeAnimation = Tween(begin: 0.0, end: 200.0).animate(_controller);
    colorAnimation = ColorTween(begin: Colors.yellow, end: Colors.red)
        .animate(CurvedAnimation(
            parent: _controller,
            // 定义在 0.5-0.8 区间执行 颜色变换
            curve: Interval(0.5, 0.8, curve: Curves.bounceIn)))
      ..addListener(() {
        setState(() {});
      });
    rotateonAnimation = Tween(begin: 0.0, end: 2 * pi).animate(CurvedAnimation(
        parent: _controller,
        // 定义 旋转 在 0.8 -1.0 动画结束之后执行 这里面还可以在嵌套动画效果
        curve: Interval(0.8, 1.0, curve: Curves.easeIn)));
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(children: [
        ElevatedButton(
            onPressed: () {
              // 动画开始正向执行
              _controller.forward();
            },
            child: Text('方法')),
        ElevatedButton(
            onPressed: () {
              // 动画开始反向执行
              _controller.reverse();
            },
            child: Text('缩小')),
        Opacity(
            // 透明度的变化 就直接用我们的 动画控制器自带的就可以
            opacity: _controller.value,
            // 然后是旋转
            child: Transform.rotate(
                // 这里 是弧度 用我们补间的值 就可以了
                angle: rotateonAnimation.value,
                child: Container(
                  // 然后是盒子的大小 颜色等  
                  width: sizeAnimation.value,
                  height: sizeAnimation.value,
                  color: colorAnimation.value,
                )))
      ]),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    // 最后释放动画资源
    _controller.dispose();
  }
}
```

### Hero动画

- 用来实现不同页面跳转的 跨页面的动画效果
- 在页面A中定义起始的Hero 组件 (source hero) 声明 tag
- 在页面B中定义目标组件 Hero(destination hero) 绑定相同的tag
- 页面跳转时 通过Navigator 传递 tag
- tag 路由切换的时 共享组件的标记
- child 声明子组件
-   一个自动生成图片的网址 https://picsum.photos/id/1/300/400

```dart
class HeroDemo extends StatefulWidget {
  HeroDemo({Key? key}) : super(key: key);

  @override
  State<HeroDemo> createState() => _HeroDemoState();
}

class _HeroDemoState extends State<HeroDemo> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20.0),
      // 这里用了宫格组件
      child: GridView.extent(
        maxCrossAxisExtent: 300,
        mainAxisSpacing: 20.0,
        children: List.generate(20, (index) {
          String imageUrl = 'https://picsum.photos/id/$index/300/400';
          // 每个宫格我们都返回一个 GestureDetector 这样就会有点击事件 当点击的时候跳转到一个新的组件
          return GestureDetector(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (BuildContext context) {
                return ImageDetail(imageUrl: imageUrl);
              }));
            },
            // 这里用hero 组件包裹 并且 tag 和我们的目标 组件是一个 tag 要相同 然后显示我们的图标组件
            child: Hero(
              child: Image.network(imageUrl),
              tag: imageUrl,
            ),
          );
        }),
      ),
    );
  }
}

class ImageDetail extends StatelessWidget {
  String imageUrl;
  ImageDetail({Key? key, required this.imageUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // 当点击的时候就会跳转到这个组件
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        // 相同也用这个组件包裹
        child: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          // 需要动画的组件 也用hero 报错 tag 要相同 一定要切记
          child: Hero(
            child: Image.network(
              imageUrl,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            tag: imageUrl,
          ),
        ),
      ),
    );
  }
}
```

### 缓存页面

```markdown
1. 有些时候 比如我们的tab 切换的时候 是希望页面保留在最开始的情况
2. 也就是 不希望在走一次 initState
3. 这个时候 就可以使用  AutomaticKeepAliveClientMixin 混合类
```

```dart
class Page1 extends StatefulWidget {
  Page1({Key? key}) : super(key: key);

  @override
  State<Page1> createState() => _Page1State();
}

class _Page1State extends State<Page1> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    // super.build(context);
    return ListView(
      children: List.generate(
          30,
          (index) => Padding(
                padding: EdgeInsets.only(top: 40),
                child: Text('$index'),
              )),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
```



## 多语言

- 组件的国际化 例如日期 弹窗等常用组件  已经继承好了
- 文本的国际化 需要自己写入

### 组件国际化

- 需要在pubspec.yaml 中引入 flutter_localizations
- 设置materialApp 组件

```dart
// 引入 import 'package:flutter_localizations/flutter_localizations.dart'
localizationsDelegates : [
    GlobalMaterialLocalizations.delegate,  Material 国际化
    GlobalCupertinoLocalizations.delegate, Cupertino 国际化
    GlobalWidgetsLocalizations.delegate    组件国际化
]
```

- supportedLocales 指定支持哪些语言

```dart
supportedLocales : [
    const Locale('en','US'), 美国英语
    const Locale('zh','CN')  中文简体
    // 其他语言
]
```

- 配置 pubspec.yaml 文件

```YAML
dependencies:
  flutter:
    sdk: flutter
  # 这里也需要配置  
  flutter_localizations:
    sdk: flutter  


  # The following adds the Cupertino Icons font to your application.
  # Use with the CupertinoIcons class for iOS style icons.
  cupertino_icons: ^1.0.2
  provider: ^6.0.3
  # dio: ^4.0.6
  # flutter_swiper: ^1.1.6
  # shared_preferences: ^2.0.15 

dev_dependencies:
  flutter_test:
    sdk: flutter
  # 配置这个包  
  integration_test:
    sdk: flutter   
```

- 配置 materialApp

```dart
// 这里要引入包
import 'package:flutter_localizations/flutter_localizations.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      // 配置哪些组件需要 多语言
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate
      ],
      // 配置语言 比如能切换中文之类的
      supportedLocales: [const Locale('en', 'US'), const Locale('zh', 'CN')],
      title: 'Passing Data',
      home: HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

// 最后验证的时候 当你手机系统切换语言的时候 flutter 的组件就变成你系统的当前语言了
```

### 文本多语言

- 针对自己文本 做翻译
- 创建本地化类 CustomLocalizations
- 船舰本地化类的代理 CutomLocalizationsDelegate extends LocalizationsDelegate<CustomLocalizations>
- isSupported 使用此方法判断 你的flutter 应用是否支持 比如 你只有 韩文的 翻译代码 但是系统切换成日文你没有 所以需要判断以下
- shouldReload 本地化重新构建时 是否调用load方法 加载本地化资源
- load 语言发生变更时 加载对应的本地化资源
- 使用本地化类 跟我们上面组件的多语言差不多 CustomLocalizations.delegate

```dart
// 创建多语言类 可以理解为 翻译的类
import 'package:flutter/material.dart';
import 'CustomLocalizationsDelegate.dart'
class CustomLocalizations {
    final Locale locale;
    CustomLocalizations(this.locale)
    static Map<Sting,Map<Sting,String>> _localizedValues = {
        "en":{
            "Home":'Home',
            "Hello":"Hello"
        },
        "zh":{
            "Home":"首页",
            "Hello":"你好"
        }
    }
    String translate(String key){
        return _localizedValues[locale.languageCode][key]
    }
    static CustomLocalizationsDelegate delegate = CustomLocalizationsDelegate()
}
```

```dart
CustomLocalizationsDelegate.dart
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'CustonLocalizations.dart';
class CustomLocalizationsDelegate extends LocalizationsDelegate<CustonLocalizations>{
    
    @override
    bool isSupported(Locale locale){
        return ["en","zh"].contains(locale.languageCode);
    }
    
    @override
    bool shouldReload(LocalizationsDelegate<CustomLocalizations> old){
        return false;
    }
    
    @override
    Future<CustonLocalizations> load(Locale locale) {
        return SynchronousFuture(CustomLocalizations(locale));
    }
}
```

```dart
// 完整代码
class CustomLocalizations {
  final Locale locale;
  const CustomLocalizations(this.locale);
  static Map<String, Map<String, String>> _localizedValues = {
    "en": {"Home": 'Home', "Hello": "Hello"},
    "zh": {"Home": "首页", "Hello": "你好"}
  };
  String? t(String key) {
    return _localizedValues[locale.languageCode]![key];
  }

  static CustomLocalizationsDelegate delegate = CustomLocalizationsDelegate();
}

// CustomLocalizationsDelegate 需要实现抽象类
class CustomLocalizationsDelegate extends LocalizationsDelegate<CustomLocalizations> {
  //   locale.languageCode 就是语言
  @override
  bool isSupported(Locale locale) {
    return ['en', 'zh'].contains(locale.languageCode);
  }

  @override
  Future<CustomLocalizations> load(Locale locale) {
    // 这里变成同步的方法  
    return SynchronousFuture(CustomLocalizations(locale));
  }

  @override
  bool shouldReload(covariant LocalizationsDelegate<CustomLocalizations> old) {
    return false;
  }
}
```

```dart
// 使用
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        // 需要在这里配置以下
        CustomLocalizations.delegate
      ],
      supportedLocales: [const Locale('en', 'US'), const Locale('zh', 'CN')],
      title: 'Passing Data',
      home: HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Localizations.of(context, CustomLocalizations).t('home')),
      ),
      body: Center(
        child: Text(Localizations.of(context, CustomLocalizations).t('title')),
      ),
    );
  }
}
```

### 加载语言包

- 在实际开发中 我们不会手动翻译更多的加载语言包
- 那么就需要检测当前是什么语言

```dart
localResolutionCallback:(locale,supportedLocales){
    print('deviceLocale:$locale');
    print('languageCode:${locale.languageCode}');
    print('countryCode':${locale.countryCode});
    for(var supportedLocale in supportedLocales){
        if(supportLocale.languageCode == locale.languageCode && supportedLocale.countryCode == locale.countryCode){
            return supportedLocale;
        }
    }
    return supportedLocales.first;
}

locale.languageCode 语言代码 比如 en zh
locale.countryCode  国家代码 比如 US CN
```

- 设置语言包

```dart
创建语言文件 比如 json 文件
在 pubspec.yaml 中 配置语言资源
```

- 异步加载语言包

```dart
在 CustomLocalizations中 调用 loadJSON 方法
在 CustomLocalizationsDelagate 中 调用 CustomLocalizations 的 loadJSON 方法
```

```dart
class CustomLocalizations {
    Map<String,String>_localizedValues;
    
    Future<bool> loadJSON() async {
        // rootBundle 可以理解为 根目录下
        // 这里可以理解为 加载 语言包文件 然后 进行 返回
        String jsonString = await rootBundle.loadString('lang/${locale.languageCode}.json');
        Map<String,dynamic> = jsonMap = json.decode(jsonString);
        _localizedValues = jsonMap.map((key,value){
            return MapEntry(key,value.toString());
        })
    }
    return true;
}
```

```dart
// 然后是调用
class CustomLocalizationsDelegate extends LocalizationsDelegate<CustomLocalizations> {
  @override
  Future<CustomLocalizations> load(Locale locale) {
    //在 load 方法里
    CustomLocalizations localizations =  CustomLocalizations(locale);
    await localizations.loadJSON();
    return localizations; 
  }
}
```

- 实现

```dart
// 首先需要知道 我们的app 目前使用的是什么语言 然后 看看 我们的应用支持不支持
// 需要在 MaterialApp 中配置 localeListResolutionCallback 接受两个参数 第一个 系统的当前语言列表 第一个就是系统目前使用的语言 然后是 自己应用都支持哪些语言

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        CustomLocalizations.delegate
      ],
      supportedLocales: [
        const Locale('zh', 'Hans_CN'),
        const Locale('en', 'US'),
      ],
      localeListResolutionCallback: (locales, supportedLocales) {
        // locales 就是 系统的语言列表 第一个就是 目前系统使用的语言
        // supportedLocales 就是 我们应用支持的语言列表
        print('手机系统当前语言是${locales!.first}');
        print('应用的支持的语言${supportedLocales}');
        for (var element in supportedLocales) {
          print('element.runtimeType ${element}');
          print('locales.first ${locales.first}');
          // 这里就说明了 我应用的语言支持你系统的语言 那么就把支持的语言返回
          if (element == locales.first) {
            print('我的应用支持系统语言${element}');
            return element;
          }
          // 如果不支持 就返回 我们应用的第一个语言

        }
        return supportedLocales.first;
      },
      title: 'Passing Data',
      home: HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
```

```dart
// 然后设置两个语言包的json 文件 这里一定 要名字要一致 
// 根目录下 里设置了lang 文件夹  下面 有 en_US.JSON  和 zh_Hans_CN.json 
// 注意这里的文件名字一定要和 我们的手机系统的语言列表一致 因为我们要通过手机系统的名字 去读取对应语言包文件

en_US.JSON
{
  "home":"home",
  "title":"hello"
}

zh_Hans_CN.json 
{
  "home":"首页",
  "title":"你好"
}

```

```yaml
# 这里我们设置完了静态资源之后 要在 pubspec.yaml 设置以下 在 asset 字段下

flutter:
  assets:
    - images/01e0c155438ba00000019ae99edfaa.jpg@1280w_1l_2o_100sh.jpg
    #这里 我们要设置以下 静态资源的路径
    - lang/en_US.json
    - lang/zh_Hans_CN.json 
  fonts: 
    - family: maobi
      fonts:
        - asset: asset/maobi.ttf
          weight: 400
          style: normal  
  uses-material-design: true
```

```dart
// 然后写 语言类 和我们的 上次文本语言类差不多
import 'dart:convert'; // 转换 json 的库
class CustomLocalizations {
  final Locale locale;
  CustomLocalizations(this.locale);
  late Map<String, String> _localizedvalues;
  // 我们需要写一个方法 去读取系统当前语言对应的 语言包文件	
  Future<bool> loadJSON() async {
    //rootBundle可以理解为 当前根目录 然后 读取 语言包文件
    String jsonString = await rootBundle.loadString('lang/${locale}.json');
    // 开始转换   
    Map<String, dynamic> jsonMap = json.decode(jsonString);
    _localizedvalues = jsonMap.map((key, value) {
      return MapEntry(key, value.toString());
    });
    print('_localizedvalues');
    print(_localizedvalues);
    return true;
  }

  String? t(String key) {
    return _localizedvalues[key];
  }

  static CustomLocalizationsDelegate delegate = CustomLocalizationsDelegate();
}

// 1. 系统会调用这个类 把我们当前手机使用的语言传入进去
class CustomLocalizationsDelegate
    extends LocalizationsDelegate<CustomLocalizations> {
  @override
  bool isSupported(Locale locale) {
    return ['en', 'zh'].contains(locale.languageCode);
  }
  // 这里在切换语言的时候 需要调用我们的 	CustomLocalizations 上的 loadJSON 方法 重新读取文件
  @override
  Future<CustomLocalizations> load(Locale locale) async {
    CustomLocalizations localizations = CustomLocalizations(locale
    // 同步读取                                                        
    await localizations.loadJSON();
    return localizations;
  }

  @override
  bool shouldReload(covariant LocalizationsDelegate<CustomLocalizations> old) {
    // TODO: implement shouldReload

    return false;
  }
}
```

```dart
// 最后使用的方法 和 我们 文本多语言使用的方法一致
class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Localizations.of(context, CustomLocalizations).t('home')),
      ),
      body: Center(
        child: Text(Localizations.of(context, CustomLocalizations).t('title')),
      ),
    );
  }
}
```

## 多主题

- 通过theme 来定义 从而实现整个App风格的统一

### ThemeData 全局

- Brightness (Brightness.light 亮色 | Brightness.dark 暗色)
- primaryColor | accentColor
- buttonTheme | cardTheme | iconTheme | textTheme

### Theme 局部

- Theme.of(context) 获取上下文中的主题信息

```dart
// 首先我们需要在 MaterialApp 中定义 theme 属性 在这里设置 比如导航的主题 文字的主题和样式 按钮的主题和样式 等
// 如果某个组件没有设置颜色 和样式 那么就用全局的 也就是我们的 theme 中设置的 如果自己定义了那么就会用自己的
// 我们也可以通过 Theme.of(context) 来获取全局主题中我们定义的一些主题

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ThemeData',
      home: HomePage(),
      // 这里的是全局样式 比如控制 导航啊 按钮 文字的颜色 样式等
      theme: ThemeData(
          // 头部导航 写了之后就变成你这个样式了
          appBarTheme: AppBarTheme(backgroundColor: Colors.red),
          primaryColor: Colors.red,
          accentColor: Colors.yellow,
          // 卡片的样式 声明 边框 阴影等
          cardTheme: CardTheme(color: Colors.blue),
          // 这里声明了 文字的主题和样式 到时候在写文本的时候就可以拿来直接用了
          textTheme: TextTheme(
              subtitle1: TextStyle(fontSize: 30, color: Colors.green)),
          // 针对 旧按钮有效果
          buttonTheme: const ButtonThemeData(
              textTheme: ButtonTextTheme.accent, splashColor: Colors.red)),
      debugShowCheckedModeBanner: false,
    );
  }
```

```dart
// 下面就是一些使用了 
class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Text(
            'theme Example',
            // 这里应用了我么主题设置的样式了 在MaterialApp 中
            style: Theme.of(context).textTheme.subtitle1,
          ),
          ElevatedButton(onPressed: () {}, child: Text('按钮')),
          RaisedButton(
            onPressed: () {},
            child: Text('有背景色的按钮'),
          ),
          // 这里也可以 通过 THeme 自定义 一些样式
          Theme(
              data: ThemeData(
                  iconTheme: IconThemeData(color: Colors.pink, size: 40)),
              child: Icon(Icons.person)),
          Card(....)
            )
        ],
      ),
    );
  }
}
```

### 适配终端主题

- 自动适配

```dart
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ThemeData',
      home: HomePage(),
      // 适配终端主题风格
      // 高亮主题
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      debugShowCheckedModeBanner: false,
    );
  }
}
```



- 声明不同的主题 比如系统对应的亮色 和系统对应的暗色

```dart
import 'package:flutter/material.dart';
class CustomTheme {
    static const double _titileFontSize = 20;
    // 高亮主题
    static final ThemeData lightTheme = ThemeData(
    	primaryColor:Colors.blue,
        primaryTextTheme:TextTheme(
        	subtitle1:TextStyle(
            	color:Clors.yellow,
                fontSize:_titileFontSize
            )
        )
    );
    
    // 暗色主题   
    static final ThemeData darkTheme = ThemeData(
        primaryColor:Colors.grey,
        primaryTextTheme:TextTheme(
        	subtitle1:TextStyle(
            	color:Clors.grey,
                fontSize:_titileFontSize
            )
        )
    )
}
```

- 自定义适配

```dart
// 先声明 主题文件 customThem.dart 这里就是定义一些 主题的样式比如高亮的时候 主题样式之类的

import 'package:flutter/material.dart';
class CustomTheme {
  static final ThemeData lightTheme = ThemeData(
    appBarTheme: AppBarTheme(backgroundColor: Colors.red),
  );
  static final ThemeData darkTheme = ThemeData(
    appBarTheme: AppBarTheme(backgroundColor: Colors.grey),
  );
}
```

```dart
// 然后在自动适配那 直接就可以使用了
import 'package:myproject/13_theme/customThem.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ThemeData',
      home: HomePage(),
      // 适配终端主题风 这里手机切换主题 也会跟着切换我们自己自定义的主题
      theme: CustomTheme.lightTheme,
      darkTheme: CustomTheme.darkTheme,
      debugShowCheckedModeBanner: false,
    );
  }
}
```

