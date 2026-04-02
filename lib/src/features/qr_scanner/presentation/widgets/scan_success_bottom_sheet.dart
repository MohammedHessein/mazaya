import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mazaya/src/config/res/config_imports.dart';
import 'package:mazaya/src/features/qr_scanner/entity/scan_result.dart';

import 'scan_success_content.dart';

class ScanSuccessBottomSheet extends StatelessWidget {
  final ScanResult scanResult;

  const ScanSuccessBottomSheet({super.key, required this.scanResult});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
      ),
      child: ScanSuccessContent(scanResult: scanResult),
    );
  }
}
