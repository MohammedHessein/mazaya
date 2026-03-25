import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/services.dart';
import 'package:share_plus/share_plus.dart';
import '../../config/language/languages.dart';
import '../../config/res/config_imports.dart';
import '../widgets/custom_loading.dart';

class Helpers {
  static Future<String> getFcmToken() async {
    final String token = await FirebaseMessaging.instance.getToken() ?? '';
    return token;
  }

  static void changeStatusbarColor({
    required Color statusBarColor,
    Brightness? statusBarIconBrightness,
  }) {
    return SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: statusBarColor,
        statusBarIconBrightness: statusBarIconBrightness ?? Brightness.dark,
        systemNavigationBarColor: AppColors.main,
      ),
    );
  }

  static void shareApp(String url) {
    CustomLoading.showFullScreenLoading();
    final ShareParams params = ShareParams(uri: Uri.parse(url));
    SharePlus.instance.share(params).whenComplete(() {
      CustomLoading.hideFullScreenLoading();
    });
  }

  static String getDeviceType() {
    if (Platform.isIOS) {
      return 'ios';
    } else {
      return 'android';
    }
  }

  static String showByLang({required String ar, required String en}) {
    if (Languages.currentLanguage.languageCode == 'ar') {
      return ar;
    } else {
      return en;
    }
  }
}
