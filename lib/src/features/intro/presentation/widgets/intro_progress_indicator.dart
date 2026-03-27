import 'package:flutter/material.dart';

import 'package:mazaya/src/config/res/config_imports.dart';

class IntroProgressIndicator extends StatelessWidget {
  final int activeIndex;
  final int count;

  const IntroProgressIndicator({
    super.key,
    required this.activeIndex,
    required this.count,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        for (int i = 0; i < count; i++) ...[
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            width: i == activeIndex ? AppSize.sW25 : AppSize.sW6,
            height: AppSize.sH6,
            decoration: BoxDecoration(
              color: i == activeIndex
                  ? AppColors.orange
                  : AppColors.greyB3.withValues(alpha: 0.5),
              borderRadius: BorderRadius.circular(AppCircular.r50),
            ),
          ),
          if (i != count - 1) SizedBox(width: AppSize.sW8),
        ],
      ],
    );
  }
}
