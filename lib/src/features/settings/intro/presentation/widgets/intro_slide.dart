import 'package:flutter/material.dart';
import 'package:mazaya/src/core/extensions/widgets/sized_box_helper.dart';

import '../../../../../config/language/locale_keys.g.dart';
import '../../../../../config/res/config_imports.dart';
import '../../../../../core/extensions/context_extension.dart';
import '../../../../../core/extensions/text_style_extensions.dart';
import '../../../../../core/widgets/buttons/default_button.dart';
import 'intro_progress_indicator.dart';
import 'intro_title.dart';

class IntroSlide extends StatelessWidget {
  final int pageIndex;
  final int currentIndex;
  final VoidCallback onNext;
  final VoidCallback onSkip;
  final String imagePath;

  const IntroSlide({
    super.key,
    required this.pageIndex,
    required this.currentIndex,
    required this.onNext,
    required this.onSkip,
    required this.imagePath,
  });

  String get _title {
    return switch (pageIndex) {
      0 => LocaleKeys.onboardingTitle2,
      1 => LocaleKeys.onboardingTitle1,
      _ => LocaleKeys.onboardingTitle3,
    };
  }

  String get _subtitle {
    return switch (pageIndex) {
      0 => LocaleKeys.onboardingDesc2,
      1 => LocaleKeys.onboardingDesc1,
      _ => LocaleKeys.onboardingDesc3,
    };
  }

  bool get _isLast => pageIndex == 2;

  @override
  Widget build(BuildContext context) {
    final titleBase = context.textStyle.s22.bold.setSecondryColor;
    final titleBlue = titleBase.setPrimaryColor.bold;
    final subtitleStyle = context.textStyle.s16.regular.setColor(
      AppColors.gray500,
    );

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppPadding.pW16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          10.szH,
          SizedBox(
            height: context.height * 0.36,
            width: double.infinity,
            child: Center(
              child: Image.asset(
                imagePath,
                width: double.infinity,
                height: context.height * 0.36,
                fit: BoxFit.contain,
              ),
            ),
          ),
          30.szH,
          IntroProgressIndicator(activeIndex: currentIndex, count: 3),
          30.szH,
          IntroTitle(
            pageIndex: pageIndex,
            title: _title,
            normalStyle: titleBase,
            blueStyle: titleBlue,
          ),
          20.szH,
          Text(_subtitle, textAlign: TextAlign.center, style: subtitleStyle),
          const Spacer(),
          DefaultButton(
            width: double.infinity,
            height: AppSize.sH50,
            borderRadius: BorderRadius.circular(AppCircular.r50),
            title: _isLast ? LocaleKeys.introStartnow : LocaleKeys.introNext,
            color: AppColors.primary,
            fontSize: FontSizeManager.s16,
            onTap: onNext,
          ),
          if (!_isLast) ...[
            16.szH,
            GestureDetector(
              onTap: onSkip,
              child: Text(
                LocaleKeys.introSkip,
                style: context.textStyle.s14.regular.setColor(
                  AppColors.gray500,
                ),
              ),
            ),
            const Spacer(),
          ] else ...[
            const Spacer(),
          ],
        ],
      ),
    );
  }
}
