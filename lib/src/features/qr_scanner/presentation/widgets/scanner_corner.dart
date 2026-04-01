import 'package:flutter/material.dart';
import 'package:mazaya/src/config/res/config_imports.dart';

class ScannerCorner extends StatelessWidget {
  final double? top;
  final double? left;
  final double? right;
  final double? bottom;
  final bool isTop;
  final bool isLeft;

  const ScannerCorner({
    super.key,
    this.top,
    this.left,
    this.right,
    this.bottom,
    required this.isTop,
    required this.isLeft,
  });

  @override
  Widget build(BuildContext context) {
    const double length = 40;
    const double thickness = 4;
    return Positioned(
      top: top,
      left: left,
      right: right,
      bottom: bottom,
      child: Container(
        width: length,
        height: length,
        decoration: BoxDecoration(
          border: Border(
            top: isTop
                ? const BorderSide(color: AppColors.primary, width: thickness)
                : BorderSide.none,
            bottom: !isTop
                ? const BorderSide(color: AppColors.primary, width: thickness)
                : BorderSide.none,
            left: isLeft
                ? const BorderSide(color: AppColors.primary, width: thickness)
                : BorderSide.none,
            right: !isLeft
                ? const BorderSide(color: AppColors.primary, width: thickness)
                : BorderSide.none,
          ),
        ),
      ),
    );
  }
}
