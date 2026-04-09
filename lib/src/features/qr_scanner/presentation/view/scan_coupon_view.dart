import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mazaya/src/config/res/config_imports.dart';
import 'package:mazaya/src/features/qr_scanner/presentation/cubits/scan_cubit.dart';

import '../widgets/scan_coupon_body.dart';

class ScanCouponView extends StatelessWidget {
  final bool isActive;
  final int? couponId;
  final String? initialQrPayload;
  final double? price;

  const ScanCouponView({
    super.key,
    required this.isActive,
    this.couponId,
    this.initialQrPayload,
    this.price,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => injector<ScanCubit>(),
      child: Scaffold(
        backgroundColor: AppColors.black,
        body: ScanCouponBody(
          isActive: isActive,
          couponId: couponId,
          initialQrPayload: initialQrPayload,
          price: price,
        ),
      ),
    );
  }
}
