import 'package:flutter/material.dart';

import '../view/view_imports.dart';

class CustomCircularActionButton extends StatelessWidget {
  final dynamic icon;
  final VoidCallback? onTap;
  final Color? iconColor;

  const CustomCircularActionButton({
    super.key,
    required this.icon,
    this.onTap,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Opacity(
        opacity: onTap == null ? 0.5 : 1.0,
        child: Container(
        padding: EdgeInsets.all(8.r),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(AppCircular.r14),
          border: Border.all(color: AppColors.gray200),
        ),
        child: IconWidget(
          icon: icon,
          color: iconColor ?? AppColors.secondary,
          height: 24.r,
          ),
        ),
      ),
    );
  }
}
