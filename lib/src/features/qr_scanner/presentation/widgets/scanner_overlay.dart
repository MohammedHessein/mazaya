import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mazaya/src/config/res/config_imports.dart';

import 'scanner_corner.dart';

class ScannerOverlay extends StatelessWidget {
  const ScannerOverlay({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ColorFiltered(
          colorFilter: ColorFilter.mode(
            AppColors.black.withValues(alpha: 0.7),
            BlendMode.srcOut,
          ),
          child: Stack(
            children: [
              Container(
                decoration: const BoxDecoration(
                  color: AppColors.black,
                  backgroundBlendMode: BlendMode.dstOut,
                ),
              ),
              Center(
                child: Container(
                  width: 280.w,
                  height: 280.w,
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                ),
              ),
            ],
          ),
        ),
        Center(
          child: SizedBox(
            width: 280.w,
            height: 280.w,
            child: const Stack(
              children: [
                ScannerCorner(top: 0, left: 0, isTop: true, isLeft: true),
                ScannerCorner(top: 0, right: 0, isTop: true, isLeft: false),
                ScannerCorner(bottom: 0, left: 0, isTop: false, isLeft: true),
                ScannerCorner(bottom: 0, right: 0, isTop: false, isLeft: false),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
