import 'package:flutter/material.dart';
import 'package:mazaya/src/core/extensions/widgets/sized_box_helper.dart';

import 'package:mazaya/src/config/language/languages.dart';
import 'package:mazaya/src/config/language/locale_keys.g.dart';
import 'package:mazaya/src/config/res/config_imports.dart';
import 'package:mazaya/src/core/extensions/context_extension.dart';
import 'package:mazaya/src/core/extensions/text_style_extensions.dart';
import 'language_option.dart';

class LanguageBottomSheet extends StatelessWidget {
  final Function(Languages) onLanguageTap;

  const LanguageBottomSheet({
    super.key,
    required this.onLanguageTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.bgF7,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(AppCircular.r20),
        ),
      ),
      padding: EdgeInsets.fromLTRB(
        AppPadding.pW20,
        AppPadding.pH12,
        AppPadding.pW20,
        AppPadding.pH20,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: AppSize.sW50,
            height: AppSize.sH2,
            decoration: BoxDecoration(
              color: AppColors.lightGray,
              borderRadius: BorderRadius.circular(AppCircular.r50),
            ),
          ),
          16.szH,
          Text(
            LocaleKeys.changeLanguage,
            textAlign: TextAlign.center,
            style: context.textStyle.s16.semiBold.setColor(AppColors.black),
          ),
          16.szH,
          ...Languages.values.map(
            (lang) => Column(
              children: [
                LanguageOption(
                  language: lang,
                  isSelected: Languages.currentLanguage == lang,
                  onTap: () => onLanguageTap(lang),
                ),
                if (lang != Languages.values.last) 16.szH,
              ],
            ),
          ),
        ],
      ),
    );
  }
}
