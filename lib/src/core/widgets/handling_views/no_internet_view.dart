import 'package:app_settings/app_settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mazaya/src/config/language/locale_keys.g.dart';
import 'package:mazaya/src/config/res/assets.gen.dart';
import 'package:mazaya/src/config/res/config_imports.dart';
import 'package:mazaya/src/core/extensions/context_extension.dart';
import 'package:mazaya/src/core/extensions/text_style_extensions.dart';
import 'package:mazaya/src/core/widgets/buttons/default_button.dart';

class NoInternetView extends StatelessWidget {
  final VoidCallback? onRetry;
  const NoInternetView({super.key, this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Spacer(flex: 3),
              AppAssets.lottie.noInternet.lottie(
                height: 250.h,
                fit: BoxFit.contain,
              ),
              SizedBox(height: 32.h),
              Text(
                LocaleKeys.errorExceptionNoconnection,
                style: context.textStyle.s20.bold.setPrimaryColor,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: AppMargin.mH12),
              Text(
                LocaleKeys.errorExeptionNointernetDesc,
                style: context.textStyle.s14.medium.setHintColor,
                textAlign: TextAlign.center,
              ),
              const Spacer(flex: 3),
              DefaultButton(
                title: LocaleKeys.retry,
                onTap:
                    onRetry ??
                    () {
                      AppSettings.openAppSettings(type: AppSettingsType.wifi);
                    },
              ),
              SizedBox(height: AppMargin.mH12),
              SizedBox(height: AppMargin.mH40),
            ],
          ),
        ),
      ),
    );
  }
}
