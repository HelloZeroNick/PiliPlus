import 'package:PiliPlus/utils/utils.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';

abstract final class ShareUtils {
  static Future<void> shareText(String text) async {
    // HarmonyOS: use clipboard as fallback
    Utils.copyText(text);
    SmartDialog.showToast('已复制到剪贴板');
  }
}