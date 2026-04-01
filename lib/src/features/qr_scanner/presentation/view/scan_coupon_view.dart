import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mazaya/src/config/res/config_imports.dart';
import 'package:mazaya/src/features/coupons/presentation/cubits/coupon_details_cubit.dart';
import '../widgets/scan_coupon_body.dart';

class ScanCouponView extends StatelessWidget {
  const ScanCouponView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => injector<CouponDetailsCubit>(),
      child: const ScanCouponBody(),
    );
  }
}
