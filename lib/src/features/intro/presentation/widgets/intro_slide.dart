import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:mazaya/src/core/extensions/widgets/sized_box_helper.dart';

import 'package:mazaya/src/config/language/locale_keys.g.dart';
import 'package:mazaya/src/config/res/config_imports.dart';
import 'package:mazaya/src/core/extensions/context_extension.dart';
import 'package:mazaya/src/core/extensions/text_style_extensions.dart';
import 'package:mazaya/src/core/widgets/buttons/default_button.dart';
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
              )
                  .animate(key: ValueKey('img_$pageIndex'))
                  .fadeIn(duration: 800.ms)
                  .scale(begin: const Offset(0.8, 0.8), end: const Offset(1, 1))
                  .shimmer(delay: 1200.ms, duration: 1800.ms)
                  .shake(hz: 0.5, offset: const Offset(0, 5)), // Gentle float
            ),
          ),
          30.szH,
          IntroProgressIndicator(activeIndex: currentIndex, count: 3)
              .animate()
              .fadeIn(delay: 200.ms)
              .scale(),
          30.szH,
          IntroTitle(
            pageIndex: pageIndex,
            title: _title,
            normalStyle: titleBase,
            blueStyle: titleBlue,
          )
              .animate(key: ValueKey('title_$pageIndex'))
              .fadeIn(delay: 300.ms, duration: 600.ms)
              .slideY(begin: 0.2, end: 0, curve: Curves.easeOutQuad),
          20.szH,
          Text(_subtitle, textAlign: TextAlign.center, style: subtitleStyle)
              .animate(key: ValueKey('subtitle_$pageIndex'))
              .fadeIn(delay: 500.ms, duration: 600.ms)
              .slideY(begin: 0.2, end: 0, curve: Curves.easeOutQuad),
          const Spacer(),
          DefaultButton(
            width: double.infinity,
            height: AppSize.sH50,
            borderRadius: BorderRadius.circular(AppCircular.r50),
            title: _isLast ? LocaleKeys.introStartnow : LocaleKeys.introNext,
            color: AppColors.primary,
            fontSize: FontSizeManager.s16,
            onTap: onNext,
          )
              .animate(key: ValueKey('btn_$pageIndex'))
              .fadeIn(delay: 700.ms, duration: 500.ms)
              .moveY(begin: 30, end: 0, curve: Curves.easeOutBack),
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
            )
                .animate(key: ValueKey('skip_$pageIndex'))
                .fadeIn(delay: 900.ms),
            const Spacer(),
          ] else ...[
            const Spacer(),
          ],
        ],
      ),
    );
  }
}
