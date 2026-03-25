import 'package:flutter/material.dart';

import '../../../config/language/locale_keys.g.dart';
import '../../../config/res/assets.gen.dart';
import '../../../config/res/config_imports.dart';
import '../../extensions/context_extension.dart';
import '../../extensions/text_style_extensions.dart';
import '../../extensions/widgets/sized_box_helper.dart';
import '../../extensions/widgets/widget_extension.dart';
import '../../navigation/navigator.dart';
import '../buttons/loading_button.dart';
import '../pickers/default_bottom_sheet.dart';

Future<dynamic> visitorDialog(String desc) {
  return showDefaultBottomSheet(child: VisitorBody(desc: desc));
}

class VisitorBody extends StatefulWidget {
  final String desc;
  const VisitorBody({super.key, required this.desc});

  @override
  State<VisitorBody> createState() => VisitorBodyState();
}

class VisitorBodyState extends State<VisitorBody> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      spacing: AppMargin.mH10,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppAssets.svg.baseSvg.dropDownClose
                .svg(width: AppSize.sH30, height: AppSize.sH30)
                .onClick(onTap: () => Go.back()),
          ],
        ),
        SizedBox(
          width: context.width * .2,
          height: context.height * .12,
          child: Center(
            child: AppAssets.lottie.visit.lottie(
              width: context.width * .15,
              fit: BoxFit.contain,
            ),
          ),
        ),
        Text(
          LocaleKeys.oops,
          textAlign: TextAlign.center,
          style: const TextStyle().setMainTextColor.s14.medium,
        ),
        Text(
          widget.desc,
          textAlign: TextAlign.center,
          style: const TextStyle().setSecondryColor.s12.regular,
        ),
        AppSize.sH10.szH,
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          spacing: AppMargin.mH10,
          children: [
            Expanded(
              child: LoadingButton(
                title: LocaleKeys.login,
                onTap: () async =>
                    {}, //async => Go.offAll(const LoginScreen()),
              ),
            ),
            Expanded(
              child: LoadingButton(
                title: LocaleKeys.register,
                color: AppColors.white,
                textColor: AppColors.primary,
                borderSide: const BorderSide(color: AppColors.primary),
                onTap: () async => {},
              ),
            ),
          ],
        ),
      ],
    );
  }
}
