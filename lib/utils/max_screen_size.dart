/// 鸿蒙兼容存根：鸿蒙平台不使用分屏/窗口模式检测
abstract final class MaxScreenSize {
  static bool isWindowMode({required num width, required num height}) {
    return false;
  }
}