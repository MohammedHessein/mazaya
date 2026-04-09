import 'package:app_settings/app_settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../config/language/locale_keys.g.dart';
import '../../../../config/res/config_imports.dart';
import '../../../../core/extensions/context_extension.dart';
import '../../../../core/extensions/text_style_extensions.dart';
import '../../../../core/extensions/widgets/sized_box_helper.dart';
import '../../../../core/widgets/buttons/loading_button.dart';

class ScannerErrorView extends StatelessWidget {
  final bool isPermissionDenied;
  final Future<void> Function() onRetry;

  const ScannerErrorView({
    super.key,
    required this.isPermissionDenied,
    required this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: Container(
        color: AppColors.black,
        child: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 30.w),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.camera_alt_outlined,
                  color: AppColors.white,
                  size: 64,
                ),
                24.szH,
                Text(
                  isPermissionDenied
                      ? LocaleKeys.cameraPermissionDenied
                      : LocaleKeys.cameraError,
                  style: context.textStyle.s16.medium.setWhiteColor,
                  textAlign: TextAlign.center,
                ),
                32.szH,
                if (isPermissionDenied) ...[
                  LoadingButton(
                    title: LocaleKeys.settingsTitle,
                    onTap: () => AppSettings.openAppSettings(),
                  ),
                  16.szH,
                ],
                LoadingButton(
                  title: LocaleKeys.retry,
                  onTap: onRetry,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
