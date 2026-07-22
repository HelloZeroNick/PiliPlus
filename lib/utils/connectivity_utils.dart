import 'package:PiliPlus/utils/platform_utils.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

abstract final class ConnectivityUtils {
  static Future<bool> get isWiFi async {
    try {
      if (!PlatformUtils.isMobile) return false;
      final result = await Connectivity().checkConnectivity();
      // HarmonyOS old SDK: checkConnectivity may return single value
      return result == ConnectivityResult.wifi;
    } catch (_) {
      return true;
    }
  }
}