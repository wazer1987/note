// 理解为手机的处理器
abstract class Processor {
  String? cores; // 内核 2核 4核
  arch(String name); // 制程  及纳米的
}

// 理解为手机的摄像头
abstract class Camera {
  String? resolution; // 摄像头的分辨率
  brand(String name); // 摄像头的品牌
}

// 那么我们如果要造手机 就必须要有摄像头 和 处理器 就必须要实现上面的两个抽线类
// 使用 关键词 implements
class Phone implements Processor, Camera {
  @override
  String? cores;

  @override
  String? resolution;

  @override
  arch(String name) {
    // TODO: implement arch
    // throw UnimplementedError();
  }

  @override
  brand(String name) {
    // TODO: implement brand
    // throw UnimplementedError();
  }
}

void main(List<String> args) {}
