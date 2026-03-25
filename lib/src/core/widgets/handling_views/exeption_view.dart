import 'package:flutter/material.dart';

 import '../../../config/language/locale_keys.g.dart';
import '../../../config/res/assets.gen.dart';
import '../../../config/res/config_imports.dart';
import '../../extensions/context_extension.dart';
import '../../extensions/text_style_extensions.dart';

class ExceptionView extends StatelessWidget {
  const ExceptionView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          spacing: AppMargin.mH10,
          children: [
            AppAssets.lottie.error1.lottie(
              width: context.width * .7,
              height: context.height * .3,
            ),
            Text(
              LocaleKeys.exceptionError,
              style: const TextStyle().setPrimaryColor.s13.medium,
            ),
          ],
        ),
      ),
    );
  }
}
