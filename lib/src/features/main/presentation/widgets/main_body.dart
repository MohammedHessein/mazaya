import 'package:flutter/material.dart';
import 'package:mazaya/src/features/home/presentation/view/home_screen.dart';
import 'package:mazaya/src/features/coupons/presentation/view/coupons_view.dart';
import 'package:mazaya/src/features/qr_scanner/presentation/view/scan_coupon_view.dart';

class MainBody extends StatelessWidget {
  final int index;
  final int currentIndex;
  const MainBody(this.index, {super.key, required this.currentIndex});

  @override
  Widget build(BuildContext context) {
    switch (index) {
      case 0:
        return const HomeScreen();
      case 1:
        return const CouponsView();
      case 2:
        return ScanCouponView(isActive: currentIndex == index);
      case 3:
        // More tab is handled directly in MainScreen for complex layout
        return const SizedBox.shrink();

      default:
        return const SizedBox.shrink();
    }
  }
}
