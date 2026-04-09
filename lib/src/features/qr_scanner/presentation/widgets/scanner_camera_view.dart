import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import '../logic/app_scanner_controller.dart';
import 'scanner_overlay.dart';

class ScannerCameraView extends StatelessWidget {
  final AppScannerController controller;

  const ScannerCameraView({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        MobileScanner(
          key: ValueKey(controller.scannerKey),
          controller: controller.controller,
          onDetect: controller.handleDetect,
          fit: BoxFit.cover,
        ),
        const ScannerOverlay(),
      ],
    );
  }
}
