import 'package:flutter/material.dart';
import 'package:mazaya/src/features/home/presentation/view/home_screen.dart';
import 'package:mazaya/src/features/coupons/presentation/view/coupons_view.dart';
import 'package:mazaya/src/features/more/presentation/view/more_tab_view.dart';
import 'package:mazaya/src/features/qr_scanner/presentation/view/scan_coupon_view.dart';

class MainBody extends StatelessWidget {
  final int index;
  const MainBody(this.index, {super.key});

  @override
  Widget build(BuildContext context) {
    switch (index) {
      case 0:
        return const HomeScreen();
      case 1:
        return const CouponsView();
      case 2:
        return const ScanCouponView();
      case 3:
        return const MoreTabView();

      default:
        return const SizedBox.shrink();
    }
  }
}
