import 'package:flutter/material.dart';
import 'package:mazaya/src/features/auth/login/imports/login_imports.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mazaya/src/config/language/locale_keys.g.dart';
import 'package:mazaya/src/config/res/config_imports.dart';
import 'package:mazaya/src/core/extensions/context_extension.dart';
import 'package:mazaya/src/core/extensions/text_style_extensions.dart';
import 'package:mazaya/src/core/navigation/navigator.dart';
import 'package:mazaya/src/core/shared/cubits/user_cubit/user_cubit.dart';
import 'package:mazaya/src/core/widgets/buttons/default_button.dart';
import 'show_modal_bottom_sheet.dart';

const String _routeName = "UnAuthenticatedBottomSheet";

class UnAuthenticatedBottomSheet extends StatelessWidget {
  const UnAuthenticatedBottomSheet._();

  static bool isOpend = false;
  static bool _isBlocked = false;
  static bool _isGuest = false;

  static Future<void> show({required bool isBlocked, bool isGuest = false}) async {
    final context = Go.context;
    if (isOpend) return;

    _isBlocked = isBlocked;
    _isGuest = isGuest;
    isOpend = true;

    await showAppModalBottomSheet(
      context: context,
      isDismissible: false,
      enableDrag: false,
      hasTopInductor: false,
      routeSettings: const RouteSettings(name: _routeName),
      child: const UnAuthenticatedBottomSheet._(),
    ).whenComplete(() {
      isOpend = false;
      _isBlocked = false;
      _isGuest = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(Icons.login_rounded, size: 100.sp, color: AppColors.primary),
        const SizedBox(height: 16),
        Text(
          _isBlocked
              ? LocaleKeys.blocked
              : _isGuest
                  ? LocaleKeys.pleaseLoginToAccessThisFeature
                  : LocaleKeys.appYourSessionIsExpired,
          textAlign: TextAlign.center,
          style: context.textStyle.s14.medium.setMainTextColor,
        ),
        const SizedBox(height: 32),
        DefaultButton(
          title: LocaleKeys.login,
          onTap: () {
            injector<UserCubit>().logout();
            Go.offAll(const LoginScreen());
          },
        ),
        const SizedBox(height: 12),
      ],
    );
  }
}
