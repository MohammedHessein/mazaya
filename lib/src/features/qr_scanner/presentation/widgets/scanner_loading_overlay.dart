import 'package:flutter/material.dart';
import '../../../../config/res/config_imports.dart';

class ScannerLoadingOverlay extends StatelessWidget {
  const ScannerLoadingOverlay({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: Container(
        color: AppColors.black.withValues(alpha: 0.5),
        child: const Center(
          child: CircularProgressIndicator(color: AppColors.white),
        ),
      ),
    );
  }
}
