import 'package:flutter/material.dart';

import '../view/view_imports.dart';

class CustomCircularActionButton extends StatelessWidget {
  final dynamic icon;
  final VoidCallback onTap;
  final Color? iconColor;

  const CustomCircularActionButton({
    super.key,
    required this.icon,
    required this.onTap,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(8.r),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(AppCircular.r8),
          border: Border.all(color: AppColors.gray200),
        ),
        child: IconWidget(
          icon: icon,
          color: iconColor ?? AppColors.secondary,
          height: 24.r,
        ),
      ),
    );
  }
}
