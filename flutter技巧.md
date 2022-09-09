## 设备尺寸

- MediaQuery.of(context).size.width
- MediaQuery.of(context).size.height

## 主体设置

```dart
import 'package:flutter/material.dart';

import 'app_colors.dart';

final ThemeData theme = ThemeData(
  primaryColor: DQColor.primary, // 主题色
  scaffoldBackgroundColor: DQColor.page, // 脚手架下的页面背景色
  indicatorColor: DQColor.active, // 选项卡栏中所选选项卡指示器的颜色。
  // ElevatedButton 主题
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      // 文字颜色
      foregroundColor: MaterialStateProperty.resolveWith((states) {
        if (states.contains(MaterialState.disabled)) {
          return Colors.white;
        } else {
          return null;
        }
      }),
      // 背景色
      backgroundColor: MaterialStateProperty.resolveWith((states) {
        if (states.contains(MaterialState.disabled)) {
          return DQColor.danger.withOpacity(0.5);
        } else {
          return DQColor.danger;
        }
      }),
    ),
  ),
  accentColor: DQColor.primary, // 小部件的前景色（旋钮，文本，过度滚动边缘效果等）
  splashColor: Colors.transparent, // 取消水波纹效果
  highlightColor: Colors.transparent, // 取消水波纹效果
  hoverColor: Colors.white.withOpacity(0.5),
  // 常规字体的颜色 就是 页面上的  
  textTheme: TextTheme(
    bodyText2: TextStyle(
      color: DQColor.unactive, // 文字颜色
    ),
  ),
  // tabbar的样式
  tabBarTheme: TabBarTheme(
    unselectedLabelColor: DQColor.unactive, // 未选中的颜色
    indicatorSize: TabBarIndicatorSize.label, // 滑块的宽度
    // 选中的颜色  
    labelStyle: TextStyle(
      fontSize: 18,
    ),
    labelPadding: EdgeInsets.symmetric(horizontal: 12),
  ),
  appBarTheme: AppBarTheme(
    backgroundColor: DQColor.nav,
    elevation: 0, // 去掉appbar 阴影
  ),
  // 底部导航的样式 比如背景  选中的颜色 文字大小等  
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: DQColor.nav,
    selectedItemColor: DQColor.active,
    unselectedItemColor: DQColor.unactive,
    selectedLabelStyle: TextStyle(
      fontSize: 12,
    ),
  ),
);

```

## 布局

- ecpanded

```dart
// 圣杯布局
// 如果没有 Expanded 组件 那么 两个图片会挨在一起 右边会剩余好多的宽度

// 有了 Expanded 组件 那么 右边剩余的宽度 就会 被 中间 Expanded 的撑满 达到圣杯布局
Row(
    children:[
        Image.asset('xxxxx.jpg'),
        Expanded(),
        Image.asset('xxxxx.jpg'),
    ]
)

```

