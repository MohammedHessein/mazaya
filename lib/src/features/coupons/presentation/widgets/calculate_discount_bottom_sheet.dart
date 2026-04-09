import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mazaya/src/core/navigation/navigator.dart';
import 'package:mazaya/src/features/coupons/entity/coupon_entity.dart';
import 'package:mazaya/src/features/qr_scanner/presentation/widgets/discount_calculator_form.dart';

class CalculateDiscountBottomSheet extends StatelessWidget {
  final CouponEntity coupon;

  const CalculateDiscountBottomSheet({super.key, required this.coupon});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.h),
      child: DiscountCalculatorForm(
        coupon: coupon,
        onContinue: (price, discount) {
          Go.back(price);
        },
      ),
    );
  }
}
