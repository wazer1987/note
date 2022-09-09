GetX

- Snackbar
- Dialog
- BottomSheet
- Navigation
- Obx响应式管理
- GetController
- 语言国际化配置
- GetX Service
- GetX Bingding 绑定

## SnackBar

- 如果想在应用程序中触发某些特定事件后 需要弹出一则快捷消息 就可以使用SnackBar

- 直接 使用Get.snackbar() 传入对应的属性就可以 弹出

```dart
class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

showTotel() {
  // 。。。 此外还能配置背景颜色 圆角 圆角边框 动画效果 嵌入表单等 等等
  Get.snackbar(
      'snakebar标题', // 标题
      '我是snackbar的内容！', // 内容
      colorText: Colors.pink, // 控制文本颜色
      duration: const Duration(seconds: 2), // 停留几秒
      snackPosition: SnackPosition.BOTTOM, // 提示位置
      titleText: const Text('标题可以是组件'), //标题可以是组件
      messageText: const Text('内容也可以是组件'),
      icon: const Icon(Icons.abc_outlined), // 在左侧添加图标
      showProgressIndicator: true, // 弹框顶部有进度条
      shouldIconPulse: true, // 左侧的图标是否闪烁
      maxWidth: 300,
      margin: const EdgeInsets.all(10), // 提示距离手机的位置
      padding: const EdgeInsets.all(10),
      // 可以添加按钮
      mainButton: TextButton(onPressed: () {}, child: const Text('确认')),
      // 点击snackbar的时候做的事情
      onTap: (a) {
        print(a);
      },
      isDismissible: true, // 是否可以拖动snackbar

  );
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          ElevatedButton(
              onPressed: () {
                showTotel();
              },
              child: const Text('SnackBar'))
        ],
      ),
    );
  }
}
```

## Dialog

- 对AlertDialog 进行了封装 需要用户二次确认的一个操作弹框
- 调用方式 Get.degaultDialog() 传入对应的属性

```dart
class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

showTotel() {
  //
  Get.defaultDialog(
      title: 'Dialog弹层',
      titleStyle: const TextStyle(color: Colors.pink), // 标题文字样式
      middleText: '内容文字',
      middleTextStyle: const TextStyle(color: Colors.pink), // 内容样式
      // 内容可以插入组件
      content: Row(
        children: [ElevatedButton(onPressed: () {}, child: const Text('按钮'))],
      ),
      // footer的按钮文字 这
      textConfirm: '确认',
      // 确认按钮的点击事件
      onConfirm: () {},
      // 这里也可以设置组件 按钮 可以覆盖上面 此外还有一些取消的按钮
      confirm:
          ElevatedButton(onPressed: () {}, child: const Text('自己的fotter按钮')),
      // 更多的按钮列表
      actions: [
        ElevatedButton(
            onPressed: () {
              // 调用此方法可关闭弹层
              Get.back();
            },
            child: const Text('自己的fotter按钮1')),
      ],
      // 点击遮罩是否关闭弹层
      barrierDismissible: false,
      // 监听弹层关闭的事件
      onWillPop: () async {
        return true;
      });
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          ElevatedButton(
              onPressed: () {
                showTotel();
              },
              child: const Text('Dialog弹层'))
        ],
      ),
    );
  }
}
```

## BootomSheet

- 底部弹出的一个组件 用于单选 验证码二次校验弹框等 通过路由push的方法实现底部弹窗的一个效果
- 效果就是弹出一个满屏的新页面
- 通过Get.bottomsheet()  传入属性即可

```dart
class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('GETX')),
      body: Home(),
    );
  }
}

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

showTotel() {
  // 此外还有 阴影样式  点击遮罩是否可以关闭弹层 弹层的动画时间
  Get.bottomSheet(
    Container(
      child: Wrap(
        children: [
          ListTile(
            leading: const Icon(Icons.wb_sunny_outlined),
            title: const Text('白天模式'),
            onTap: () {
              Get.changeTheme(ThemeData.light());
            },
          ),
          ListTile(
            leading: const Icon(Icons.wb_sunny_outlined),
            title: const Text('黑夜模式'),
            onTap: () {
              Get.changeTheme(ThemeData.dark());
            },
          )
        ],
      ),
    ),
    backgroundColor: Colors.green, // 底部弹层的背景颜色
    barrierColor: Colors.red, // 遮罩层的背景颜色
    enableDrag: true, // 是否可以上下拖动弹层
    // 是否可以 全屏
    // isScrollControlled:true
  );
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          ElevatedButton(
              onPressed: () {
                showTotel();
              },
              child: const Text('bottomsheet'))
        ],
      ),
    );
  }
}
```

## Navigation

- 进行路由跳转 
- 直接使用Get.to 即可跳转路由 

```dart
class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

showTotel() async {
  // 直接引入跳转的页面
  // Get.to(PageDetail());

  // 可以设定一些动画效果
  // Get.to(PageDetail(),
  //     // 是否全屏跳转
  //     fullscreenDialog: true,
  //     // 页面从哪个方向弹出
  //     transition: Transition.upToDown,
  //     // 弹出时间
  //     duration: Duration(seconds: 2),
  //     // 动画曲线
  //     curve: Curves.bounceInOut);
  // 传参 跳转页面可以用 Get.arguments 来接收
  // Get.to(PageDetail(), arguments: '我是传过来的参数');

  // 当跳转页面 使用使用Get.back(result:'参数')的时候 可以用着中方式接受参数
  String str = await Get.to(PageDetail(), arguments: '我是传过来的参数');
  print(str);
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          ElevatedButton(
              onPressed: () {
                showTotel();
              },
              child: const Text('跳转页面'))
        ],
      ),
    );
  }
}
```

```dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
// 跳转的页面
class PageDetail extends StatelessWidget {
  const PageDetail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('我是page页面'),
      ),
      body: Column(
        children: [
          const Text('我是page页面'),
          // 接收参数  
          Text(Get.arguments ?? '默认参数'),
          ElevatedButton(
              onPressed: () {
                // 给上一个页面返回参数  
                Get.back(result: '跳转页面返回的');
              },
              child: Text('返回上一个页面'))
        ],
      ),
    );
  }
}

```

### GetX 命名路由跳转

- 还是要配置命名路由

```dart
// 路由对应的页面
import './page.dart';
import 'page1.dart';

return GetMaterialApp(
      title: 'Snack Bar',
      home: HomePage(),
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      defaultTransition: Transition.zoom,
      getPages: [
        GetPage(name: '/pagedeatail', page: () => PageDetail()),
        GetPage(name: '/page1', page: () => PageDetail1()),
      ],
    );
```

- 跳转 使用 toNamed

```dart
class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

showTotel() async {
  // 跳转页面 使用 Get.arguments 接收参数即可
  Get.toNamed('/page1', arguments: '我是传参');
  // Get.toNamed('/pagedeatail');
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          ElevatedButton(
              onPressed: () {
                showTotel();
              },
              child: const Text('跳转页面'))
        ],
      ),
    );
  }
}
```

## Obx 响应式状态管理

- 定义响应式的几种方式

```DART
1. 使用Rx{Type}
final name = RxString('');
final isLogged = RxBool(false);
final count = RxInt(0);
final balance = RxDouble(0.0);
final items = RxList<String>([]);
final myMap = RxMap<String, int>({});

2. 使用 Rx 然后规定泛型的方式
final name = Rx<String>('');
final isLogged Rx<Bool>(false);
final count = Rx<Int>(0);
final balance = Rx<Double>(0.0);
final number = Rx<Num>(0);
final items = Rx<List<String>>([]);
final myMap = Rx<Map<String,int>>({});
自定义类 可以是任何类型
final user = Rx<User>();

3. 使用.obs 作为value 的属性;
final name = ''.obs;
final isLogged = false.obs;
final count = 0.obs;
final balance = 0.0.obs;
final number = 0.obs;
final items = <String>[].obs;
final myMap = <String, int>{}.obs
final user = User().obs
```

### 使用

```markdown
1. 需要使用 以上方式定义响应式的数据
2. 在使用的地方 需要是用 Obx(() => xxx组件) 包裹
```

```dart
class Home extends StatelessWidget {
  Home({Key? key}) : super(key: key);
  // 声明响应式数据   
  final count = 0.obs;
  // var count = RxString('你好');
  // var flag = RxBool(true);
  void increment() {
    count.value++;
    // count.value = '改变';
    // flag.value = false;
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // 使用Obx 组件 包裹 你要变换的组件 注意 被包裹的组件里 要写obs的相关变量 
          Obx(() => Text('${count}')),
          ElevatedButton(
              onPressed: () {
                increment();
              },
              child: const Text('计数'))
        ],
      ),
    );
  }
}
```

- 自定义类

```dart
//给类的每个属性 定义响应式obs 
class Teacher {
  var name = '李磊'.obs;
  var age = 20.obs;
};

class Home extends StatelessWidget {
  Home({Key? key}) : super(key: key);
  var t = Teacher();
  void increment() {
    // 使用的时候 直接 属性 .value 改值  
    t.name.value = '我是韩梅梅';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // 这里还是要用 obx去包裹组件  
          Obx(() => Text('${t.name}')),
          ElevatedButton(
              onPressed: () {
                increment();
              },
              child: const Text('改变名称'))
        ],
      ),
    );
  }
}
```

```dart
// 第二种方式 是给整个类 定义响应式数据 转换的时候 使用实例的update 方法 去更新数据
class Teacher {
  var name = '李磊';
  var age = 20;
}

class Home extends StatelessWidget {
  Home({Key? key}) : super(key: key);
  var t = Teacher().obs;
  void increment() {
    t.update((value) {
      // 这里因为是 给整个类绑定的obs 所以要 先value 在属性  
      t.value.name = '韩梅梅';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Obx(() => Text('${t.value.name}')),
          ElevatedButton(
              onPressed: () {
                increment();
              },
              child: const Text('改变名称'))
        ],
      ),
    );
  }
}
```

## GetxController

```markdown
在实际开发种 不可能把 UI代码 业务逻辑都放在一起处理 于是 Getx 提供了 GetxController 主要作用是把UI代码 和业务逻辑分离开来
```

- 第一种实现方式

```dart
1. 抽离数据层;
class Teacher {
  var name = '李磊'.obs;
  var age = 20.obs;
}
2. 实例化控制层 并实例化数据 你的控制层需要继承 GetxController
class MyController extends GetxController {
  // 实例化数据  
  var teacher = Teacher();
  // 在控制层里写改变数据的方法	
  void transFormName() {
    teacher.name.value = '韩梅梅';
  }
}

3. 调用控制层 并使用obx 包裹组件
    
class Home extends StatelessWidget {
  Home({Key? key}) : super(key: key);
  // 调用控制层
  MyController myController = Get.put(MyController());
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // 使用 Obx 包裹  
          Obx(() {
            return Text("我的名字是${myController.teacher.name}");
          }),
          ElevatedButton(
              onPressed: () {
                // 调用控制层里 改变数据层的方法  
                myController.transFormName();
              },
              child: const Text('改变名称'))
        ],
      ),
    );
  }
}    
```

- 第二种

```markdown
不适用obx 包裹组件 使用 GetX<MyController>() 这种方式包裹组件
```

```dart
// 数据层
class Teacher {
  var name = '李磊'.obs;
  var age = 20.obs;
}
// 控制层
class MyController extends GetxController {
  var teacher = Teacher();

  void transFormName() {
    teacher.name.value = '韩梅梅1';
  }
}
// UI
class Home extends StatelessWidget {
  Home({Key? key}) : super(key: key);

  MyController myController = Get.put(MyController());
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // 使用 Getx   去包裹组件
          GetX<MyController>(
              init: MyController(),
              builder: (controller) {
                // 在 builder 里就可以拿到了  
                return Text("我的名字是${controller.teacher.name}");
              }),
          ElevatedButton(
              onPressed: () {
                myController.transFormName();
              },
              child: const Text('改变名称'))
        ],
      ),
    );
  }
}
```

- 第三种

```markdown
使用 GetBuilder 包裹组件  在改变的函数里 需要调用update函数
```

```DART
class Teacher {
  var name = '李磊'.obs;
  var age = 20.obs;
}

class MyController extends GetxController {
  var teacher = Teacher();

  void transFormName() {
    teacher.name.value = '韩梅梅1';
    // 这里如果是用 GetBuilder 包裹组件 改变值的时候 就要使用   update 函数做更新
    update();
  }
}

class Home extends StatelessWidget {
  Home({Key? key}) : super(key: key);

  MyController myController = Get.put(MyController());
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GetBuilder<MyController>(
              init: myController,
              builder: (controller) {
                return Text("我的名字是${controller.teacher.name}");
              }),
          ElevatedButton(
              onPressed: () {
                myController.transFormName();
              },
              child: const Text('改变名称'))
        ],
      ),
    );
  }
}
```

```markdown
这里需要注意的是 如果 你是给整个类 添加的obs 的话
那么更新的时候 就需要调用 update函数
如下这种
 var t = Teacher().obs;
  void increment() {
    t.update((value) {
      // 这里因为是 给整个类绑定的obs 所以要 先value 在属性  
      t.value.name = '韩梅梅';
    });
  }
```

## GetxController 监听事件

```dart
class MyController extends GetxController {
  // var teacher = Teacher();
  var count = 0.obs;
  void transFormName() {
    count.value++;
  }

  // 需要重写 onInit方法
  @override
  void onInit() {
    // 当count 的值改变的时候 调用一些方法
    // ever(count, (callback) => print('变化了'));

    // 监听多个值
    // everAll([count], (callback) => print('监听多个值得变化了'));

    // 监听只执行一次
    // once(count, (callback) => print('值变化了 我只执行一次'));

    // 可以理解为防抖 结束后1秒调用
    // debounce(count, (callback) => print('最后一次执行'));
    // 可以理解为节流
    interval(count, (callback) => print('忽略3秒内的所有变动'));
    // 调用父类方法
    super.onInit();
  }
}
```

## GetxController 生命周期

```dart
class MyController extends GetxController {
  // var teacher = Teacher();
  var count = 0.obs;
  void transFormName() async {
    await Future.delayed(Duration(seconds: 3));
    count.value++;
    update();
  }

  cleanTask() {
    print('清除缓存');
  }

  // 需要重写 onInit方法
  @override
  void onInit() {
    print('初始化');
    // 调用父类方法
    super.onInit();
  }

  @override
  void onReady() {
    print('加载完成');
    super.onReady();
  }

  @override
  void onClose() {
    print('控制器被释放');
    super.onClose();
  }
}
 
 MyController myController = Get.put(MyController());

 GetBuilder<MyController>(
  // 初始化的时候 就自动+1
  initState: (data) => myController.transFormName(),
  // 销毁的时候 会执行这里的回调
  dispose: (data) => myController.cleanTask(),
  builder: (controller) {
    return Text("计数器${myController.count}");
  }),
```

## UniqueID

```markdown
多个地方引用了同一个属性 但是在更新的时候 只想更新某一个地方 就需要用到 UniqueID 来进行区分
1. 给其中一个 GetBuilder id 属性
2. 调用 update 方法的时候 传入id
```

```dart
class MyController extends GetxController {
  // var teacher = Teacher();
  var count = 0.obs;
  void transFormName() async {
    await Future.delayed(Duration(seconds: 3));
    count.value++;
    // 更新的时候 传入id
    update(['one']);
  }
}

MyController myController = Get.put(MyController());

// 下面是两个被 GetBuilder 包裹的组件 在更新的时候 只有id 为 one 的会改变

GetBuilder<MyController>(
  // 不会更新 因为没有id  
  initState: (data) => myController.transFormName(),
  dispose: (data) => myController.cleanTask(),
  builder: (controller) {
    return Text("计数器${myController.count}");
  }),
GetBuilder<MyController>(
  // 会更新 因为有id 为 one  
  id: 'one',
  initState: (data) => myController.transFormName(),
  dispose: (data) => myController.cleanTask(),
  builder: (controller) {
    return Text("计数器${myController.count}");
  }),
```

## 国际化配置

```markdown
需要在 GetMaterialApp 下 配置如下选项
1. translations 配置的语言类 语言类 需要继承 Translations
2. local 设置几种语言
3. fllbackLocale 语言配置失败的情况下 默认显示的语言 比如切换的语言里你的语言包没有
```

```dart
1. 定义语言包
class Message extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'zh_CN': {"hello": '你好,世界'},
        "en_US": {"hello": 'hello,word'}
      };
}

2. 定义控制层切换方法
class MessageController extends GetxController {
  void changeLanguage(String languageCode, String countryCode) {
    var local = Locale(languageCode, countryCode);
    Get.updateLocale(local);
  }
} 

3. 定义配置
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Snack Bar',
      home: HomePage(),
      translations: Message(),
      locale: Locale('zh', 'CN'),
      fallbackLocale: Locale('zh', "CN"),
    );
  }
}    

4. 定义使用  多语言的文字 需要加上.tr
class Home extends StatelessWidget {
  Home({Key? key}) : super(key: key);
  MessageController messageController = MessageController();
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(
        children: [
          Text('hello'.tr),
          ElevatedButton(
              onPressed: () {
                messageController.changeLanguage('en', 'US');
              },
              child: const Text('切换英文')),
          ElevatedButton(
              onPressed: () {
                messageController.changeLanguage('zh', 'CN');
              },
              child: const Text('切换中文'))
        ],
      ),
    );
  }
}    
```

## 持久存储

```markdown
配合getx  和 package:shared_preferences 我们可以做到持久存储 当应用重启的时候也可以拿到值
```

```dart
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
// 初始化持久的类 继承与 GetxService
class Service extends GetxService {
  Future<void> getCounter() async {
    // 这里就是和平时一样 初始化持久存储对象  
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int count = (prefs.getInt('counter') ?? 0) + 1;
    print('count的值为$count');
    await prefs.setInt('counter', count);
  }
}
```

```dart
// 需要在初始化程序里 启动一下 这个 持久化存储的服务

import '15_getX/serviceController.dart';
import '15_getX/11_Service.dart';
import 'package:get/get.dart';

void main(List<String> args) async {
  // 异步方法执行  
  await initServices();
  runApp(const MyApp());
}

Future<void> initServices() async {
  print('初始化本地存储服务');
  // 调用持久化存储的类  
  await Get.putAsync(() async => await Service());
  print('服务启动完毕');
}
```

```DART
import '15_getX/serviceController.dart';
import '15_getX/11_Service.dart';
import 'package:get/get.dart';

void main(List<String> args) async {
  await initServices();
  runApp(const MyApp());
}

Future<void> initServices() async {
  print('初始化本地存储服务');
  await Get.putAsync(() async => await Service());
  print('服务启动完毕');
}
```

```dart
// 使用的时候 就可以看到效果了

class Home extends StatelessWidget {
  Home({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(
        children: [
          ElevatedButton(
              onPressed: () async {
                // 通过这种方式 可以调用 持久化存储类上的方法 取到的值 不论你是重启应用 都是在内存中的  
                Get.find<Service>().getCounter();
              },
              child: const Text('增加')),
        ],
      ),
    );
  }
}
```

## Getx Binding

```markdown
可以一次性初始化我们所有的控制器 这样就不需要在每个页面都实列化了
```

```dart
1. 首先 写一个初始化 入口类 引入我们需要的 初始化的控制器;
class AllControllerBinding implements Bindings {
    // 覆写 dependencies 方法
    @override
    void dependencies () {
        // 调用 lazyPut方法 放入我们要初始化的控制器类
        Get.lazyPut<BindingMyController>(() => BindingMycontroller());
        Get.lazyPut<BindingHomeController>(() => BindingHomecontroller())
    }
};

// BindingMycontroller控制器
class BindingMycontroller extends GetxController {
    var count = 0.obs;
    void increment() {
        count++
    }
};

// BindingHomecontroller控制器
class BindingHomecontroller extends GetxController {
    var count = 0.obs;
    void increment() {
        count++
    }
};

2. 在 入口 GetMaterialApp 的 initalBingding 调用 AllControllerBinding 即可;

GetMaterialApp(
    title:'getx',
    initialBinding: AllControllerBinding(),
    home:HomePage()
);

3. 使用的时候如下 找到对应的 Bing上的数量即可 这里也要引入 BindingMycontroller 代码文件;

Obx(() => Text('${Get.find<BindingMycontroller>().conut}'))
```

- 完整代码

```dart
// allbingdingcontroller.dart 文件
import 'package:get/get.dart';
// 引入控制器文件
import 'MyController.dart';

class AllBindingController implements Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut<MyController>(() => MyController());
  }
}


// MyController.dart 控制器文件
import 'package:get/get.dart';

class MyController extends GetxController {
  var count = 0.obs;

  void increment() {
    count++;
  }
}

// 页面文件 
import 'package:flutter/material.dart';
import 'package:get/get.dart';
// 引入binding 文件
import 'allbingdingcontroller.dart';
// 引入控制器文件
import 'MyController.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        title: 'Snack Bar',
        home: HomePage(),
        // 初始化binding
        initialBinding: AllBindingController());
  }
}
// 使用如下
class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(
        children: [
          Obx(() => Text('${Get.find<MyController>().count}')),
          ElevatedButton(
              onPressed: () {
                Get.find<MyController>().increment();
              },
              child: Text('增加'))
        ],
      ),
    );
  }
}
```

### 路由配置binding

```markdown
1. 我们还可以采用 页面路由的形式 去配置 binding
```

```dart
// 首先还是要写binding 类
class BindingMyController implements Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut<MyController>(() => MyController());
  }
}

// 控制器类文件 一致 
class Mycontroller extends GetxController {
    var count = 0.obs;
    void increment() {
        count++
    }
};


// 然后在路由配置中使用 

return GetMaterialApp(
      title: 'Snack Bar',
      home: HomePage(),
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      defaultTransition: Transition.zoom,
      getPages: [
        GetPage(name: '/pagedeatail', page: () => PageDetail(), binding: BindingMyController()),
      ],
    );


```

```dart
// 使用 BindingBuilder 初始化

步骤和上面一样 这种方法可以直接  把控制蹭 写入binding
    

class Mycontroller extends GetxController {
    var count = 0.obs;
    void increment() {
        count++
    }
};    
    
return GetMaterialApp(
      title: 'Snack Bar',
      home: HomePage(),
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      defaultTransition: Transition.zoom,
      getPages: [
        GetPage(name: '/pagedeatail', page: () => PageDetail(), 
                binding: BindingBuilder(() => {
                    Get.lazyPut<MyController>(() => MyController())
                })
               ),
      ],
    );    
```

