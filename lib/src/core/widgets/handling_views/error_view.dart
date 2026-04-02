import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:mazaya/src/config/res/assets.gen.dart';
import 'package:mazaya/src/config/res/config_imports.dart';
import 'package:mazaya/src/core/extensions/context_extension.dart';
import 'package:mazaya/src/core/extensions/text_style_extensions.dart';

class ErrorView extends StatelessWidget {
  final String error;
  final double? width, height;
  const ErrorView({super.key, required this.error, this.width, this.height});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final maxHeight = constraints.maxHeight;
        final isFinite = maxHeight.isFinite;
        final isSmall = isFinite && maxHeight < 250;

        return Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            spacing: isSmall ? AppMargin.mH6 : AppMargin.mH10,
            children: [
              AppAssets.lottie.error1.lottie(
                height: height ?? (isSmall ? (maxHeight * .5) : 150.h),
                fit: BoxFit.contain,
              ),
              Flexible(
                child: Text(
                  error,
                  style: context.textStyle.setSecondryColor.s13.bold,
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
