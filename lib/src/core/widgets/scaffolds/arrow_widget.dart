import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:mazaya/src/config/res/assets.gen.dart';
import 'package:mazaya/src/config/res/config_imports.dart';
import 'package:mazaya/src/core/extensions/context_extension.dart';
import 'package:mazaya/src/core/extensions/text_style_extensions.dart';
import 'package:mazaya/src/core/extensions/widgets/widget_extension.dart';
import 'package:mazaya/src/core/navigation/navigator.dart';

enum SelectArrowStyleEnum { showMore, arrowBack, arrowRight }

class ArrowWidget extends StatelessWidget {
  final double? width, height;
  final void Function()? onTap;
  final MainAxisAlignment? mainAxisAlignment;
  final Color? color;

  const ArrowWidget({
    super.key,
    this.height,
    this.width,
    this.onTap,
    this.mainAxisAlignment,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: mainAxisAlignment ?? MainAxisAlignment.start,

      children: [
        Transform(
          alignment: Alignment.center,
          transform: context.isRight
              ? Matrix4.rotationY(math.pi)
              : Matrix4.rotationX(math.pi),
          child: AppAssets.svg.baseSvg.arrowBack
              .svg(
                width: width ?? AppSize.sH35,
                height: height ?? AppSize.sH35,
                colorFilter: color != null
                    ? ColorFilter.mode(color!, BlendMode.srcIn)
                    : null,
              )
              .onClick(onTap: onTap ?? () => Go.back()),
        ),
      ],
    );
  }
}

class TitleWithArrowWidget extends StatelessWidget {
  final SelectArrowStyleEnum selectArrowStyleEnum;
  final void Function()? onTap;
  final String tiltle;
  final TextStyle? style;
  final MainAxisAlignment mainAxisAlignment;
  final double? width, height, spacing;

  const TitleWithArrowWidget({
    super.key,
    required this.tiltle,
    this.selectArrowStyleEnum = SelectArrowStyleEnum.arrowBack,
    this.style,
    this.height,
    this.spacing,
    this.width,
    this.onTap,
    this.mainAxisAlignment = MainAxisAlignment.start,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: mainAxisAlignment,
      crossAxisAlignment: CrossAxisAlignment.center,
      spacing: spacing ?? AppMargin.mH6,
      children: [
        Text(
          tiltle,
          style: style ?? const TextStyle().setPrimaryColor.s12.regular,
        ),
        ArrowWidget(width: width, height: height),
      ],
    ).onClick(onTap: onTap);
  }
}
