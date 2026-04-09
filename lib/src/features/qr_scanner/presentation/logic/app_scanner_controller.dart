import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class AppScannerController extends WidgetsBindingObserver {
  final VoidCallback onStateUpdate;
  final Function(String) onCodeDetected;

  AppScannerController({
    required this.onStateUpdate,
    required this.onCodeDetected,
  }) {
    WidgetsBinding.instance.addObserver(this);
    _controller = _buildController();
  }

  late MobileScannerController _controller;
  MobileScannerController get controller => _controller;

  bool isScanned = false;
  String? scannedCode;
  bool hasError = false;
  bool isPermissionDenied = false;
  int scannerKey = 0;

  MobileScannerController _buildController() {
    return MobileScannerController(
      detectionSpeed: DetectionSpeed.noDuplicates,
      formats: [BarcodeFormat.qrCode],
      autoStart: false,
    );
  }

  Future<void> start() async {
    try {
      await _controller.start();
    } catch (e) {
      debugPrint('Error starting camera: $e');
      hasError = true;
      isPermissionDenied = e.toString().contains('permissionDenied') ||
          e.toString().toLowerCase().contains('permission');
      onStateUpdate();
    }
  }

  void stop() {
    _controller.stop();
  }

  Future<void> recreate() async {
    try {
      await _controller.stop();
    } catch (_) {}
    _controller.dispose();

    _controller = _buildController();
    scannerKey++;
    hasError = false;
    isPermissionDenied = false;
    isScanned = false;
    scannedCode = null;
    onStateUpdate();
    await start();
  }

  void handleDetect(BarcodeCapture capture) {
    if (isScanned) return;
    for (final barcode in capture.barcodes) {
      if (barcode.format == BarcodeFormat.qrCode && barcode.rawValue != null) {
        isScanned = true;
        scannedCode = barcode.rawValue;
        onCodeDetected(barcode.rawValue!);
        onStateUpdate();
        break;
      }
    }
  }

  void resetInternalState() {
    isScanned = false;
    scannedCode = null;
    onStateUpdate();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
        if (!hasError && _controller.value.isRunning == false) {
          start();
        }
        break;
      case AppLifecycleState.inactive:
      case AppLifecycleState.paused:
      case AppLifecycleState.detached:
        stop();
        break;
      case AppLifecycleState.hidden:
        break;
    }
  }

  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _controller.dispose();
  }
}
