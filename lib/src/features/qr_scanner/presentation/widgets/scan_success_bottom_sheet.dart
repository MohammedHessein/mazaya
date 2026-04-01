import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mazaya/src/config/res/config_imports.dart';
import 'package:mazaya/src/features/coupons/entity/coupon_entity.dart';
import 'scan_success_content.dart';

class ScanSuccessBottomSheet extends StatelessWidget {
  final CouponEntity coupon;

  const ScanSuccessBottomSheet({super.key, required this.coupon});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 30.h),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
      ),
      child: ScanSuccessContent(coupon: coupon),
    );
  }
}
