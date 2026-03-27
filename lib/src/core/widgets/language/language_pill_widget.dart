import 'package:flutter/material.dart';
import 'package:mazaya/src/core/extensions/widgets/sized_box_helper.dart';

import 'package:mazaya/src/config/language/languages.dart';
import 'package:mazaya/src/config/res/config_imports.dart';
import 'package:mazaya/src/core/extensions/context_extension.dart';
import 'package:mazaya/src/core/extensions/text_style_extensions.dart';

class LanguagePill extends StatelessWidget {
  final VoidCallback onTap;

  const LanguagePill({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final Languages lang = Languages.currentLanguage;
    final String label = lang == Languages.arabic
        ? ConstantManager.arabic
        : ConstantManager.english;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppCircular.r50),
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: AppPadding.pW8,
          vertical: AppPadding.pH4,
        ),
        decoration: BoxDecoration(
          color: AppColors.lightGray,
          borderRadius: BorderRadius.circular(AppCircular.r50),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          textDirection: TextDirection.ltr,
          children: [
            SizedBox(
              width: AppSize.sW18,
              height: AppSize.sH18,
              child: Icon(
                Icons.language,
                size: AppSize.sH18,
                color: AppColors.black,
              ),
            ),
            8.szW,
            Text(
              label,
              style: context.textStyle.s14.medium.setColor(AppColors.black),
            ),
          ],
        ),
      ),
    );
  }
}
