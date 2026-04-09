import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../config/res/config_imports.dart';
import '../../../../core/extensions/context_extension.dart';
import '../../../../core/extensions/text_style_extensions.dart';

class NearbyChipWidget extends StatelessWidget {
  final String label;
  final String value;
  final bool isSelected;
  final VoidCallback? onTap;

  const NearbyChipWidget({
    super.key,
    required this.label,
    required this.value,
    required this.isSelected,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10.r),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary : AppColors.gray100,
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: Text(
          label,
          style: context.textStyle.s14.medium.copyWith(
            color: isSelected ? AppColors.white : AppColors.secondary,
          ),
        ),
      ),
    );
  }
}
