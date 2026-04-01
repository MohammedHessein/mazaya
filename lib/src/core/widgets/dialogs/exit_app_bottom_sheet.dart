import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mazaya/src/config/language/locale_keys.g.dart';
import 'package:mazaya/src/config/res/assets.gen.dart';
import 'package:mazaya/src/config/res/config_imports.dart';
import 'package:mazaya/src/core/extensions/context_extension.dart';
import 'package:mazaya/src/core/extensions/text_style_extensions.dart';
import 'package:mazaya/src/core/extensions/widgets/sized_box_helper.dart';
import 'package:mazaya/src/core/navigation/navigator.dart';
import 'package:mazaya/src/core/widgets/buttons/loading_button.dart';
import 'package:mazaya/src/core/widgets/pickers/default_bottom_sheet.dart';
import 'package:mazaya/src/core/widgets/universal_media/universal_media_widget.dart';

Future<bool?> showExitAppBottomSheet() async {
  final result = await showDefaultBottomSheet(
    child: const ExitAppBottomSheet(),
  );
  return result as bool?;
}

class ExitAppBottomSheet extends StatelessWidget {
  const ExitAppBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        UniversalMediaWidget(
          path: AppAssets.svg.baseSvg.logoutDialog.path,
          height: 120.h,
          fit: BoxFit.contain,
        ),
        AppSize.sH16.szH,
        Text(LocaleKeys.exitAppTitle, style: context.textStyle.s18.bold),
        AppSize.sH10.szH,
        Text(
          LocaleKeys.exitAppDesc,
          textAlign: TextAlign.center,
          style: context.textStyle.s14.setHintColor,
        ),
        AppSize.sH24.szH,
        Row(
          children: [
            Expanded(
              child: LoadingButton(
                title: LocaleKeys.no,
                color: AppColors.lightGray,
                textColor: AppColors.hintText,
                borderSide: const BorderSide(color: AppColors.lightGray),
                onTap: () async => Go.back(false),
              ),
            ),
            AppSize.sW10.szW,
            Expanded(
              child: LoadingButton(
                title: LocaleKeys.yes,
                color: AppColors.error,
                onTap: () async {
                  Go.back(true);
                  if (Platform.isAndroid) {
                    SystemNavigator.pop();
                  } else if (Platform.isIOS) {
                    exit(0);
                  }
                },
              ),
            ),
          ],
        ),
        AppSize.sH10.szH,
      ],
    );
  }
}
