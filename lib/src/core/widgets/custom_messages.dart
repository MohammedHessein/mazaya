import 'package:flutter/material.dart';
import 'package:mazaya/src/config/language/locale_keys.g.dart';
import 'package:mazaya/src/config/res/config_imports.dart';
import 'package:mazaya/src/core/extensions/base_state.dart';
import 'package:mazaya/src/core/extensions/text_style_extensions.dart';
import 'package:mazaya/src/core/navigation/navigator.dart';

class MessageUtils {
  static void showSnackBar({
    BuildContext? context,
    required BaseStatus baseStatus,
    required String message,
  }) {
    final snackBar = SnackBar(
      duration: const Duration(seconds: 1),
      content: Text(message, style: const TextStyle().setWhiteColor.s11.medium),
      action: SnackBarAction(
        label: LocaleKeys.cancel,
        textColor: AppColors.white,
        onPressed: () {
          ScaffoldMessenger.of(context ?? Go.context).clearSnackBars();
        },
      ),
      backgroundColor: baseStatus == BaseStatus.error
          ? AppColors.error
          : AppColors.success,
      behavior: SnackBarBehavior.floating,
      elevation: 4,
    );
    ScaffoldMessenger.of(context ?? Go.context).showSnackBar(snackBar);
  }
}
