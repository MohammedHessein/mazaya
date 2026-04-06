import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:mazaya/src/config/res/config_imports.dart';
import 'package:mazaya/src/core/network/log_interceptor.dart';

class CustomAvatar extends StatelessWidget {
  final String icon;
  final Color? color;
  final Color? iconColor;
  final double? height;
  final double? width;
  final double? radius;
  final EdgeInsetsGeometry? padding;
  const CustomAvatar({
    super.key,
    required this.icon,
    this.color,
    this.iconColor,
    this.height,
    this.width,
    this.radius,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: color ?? AppColors.scaffoldBackground,
        borderRadius: BorderRadius.circular(radius ?? AppCircular.r8),
      ),
      child: Padding(
        padding: padding ?? EdgeInsets.all(AppPadding.pH8),
        child: SvgPicture.asset(
          icon,
          height: height,
          width: width,
          errorBuilder: (context, error, stackTrace) {
            logDebug(
              '❌ SVG avatar error: $error\nPath: $icon',
              level: Level.error,
            );
            return Icon(
              Icons.person_outline,
              size: height,
              color: iconColor ?? AppColors.primary,
            );
          },
        ),
      ),
    );
  }
}
