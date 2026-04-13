import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:permission_handler/permission_handler.dart';

class AppScannerController extends WidgetsBindingObserver {
  final VoidCallback onStateUpdate;
  final Function(String) onCodeDetected;

  AppScannerController({
    required this.onStateUpdate,
    required this.onCodeDetected,
  }) {
    WidgetsBinding.instance.addObserver(this);
    _controller = _buildController();
    _controller.addListener(_onControllerStateChanged);
  }

  late MobileScannerController _controller;
  MobileScannerController get controller => _controller;

  bool isScanned = false;
  String? scannedCode;
  bool hasError = false;
  bool isPermissionDenied = false;
  int scannerKey = 0;
  bool _isStarting = false;
  DateTime? _lastScanTime;

  MobileScannerController _buildController() {
    return MobileScannerController(
      detectionSpeed: DetectionSpeed.noDuplicates,
      formats: [BarcodeFormat.qrCode],
      autoStart: false,
    );
  }

  Future<void> start() async {
    // 1. Race condition guards
    if (_isStarting || _controller.value.isRunning) return;
    _isStarting = true;

    try {
      // 2. Check explicit permission status first (Faster + No unnecessary popups)
      var status = await Permission.camera.status;

      if (!status.isGranted) {
        status = await Permission.camera.request();
      }

      if (status.isPermanentlyDenied || status.isRestricted) {
        _updateScannerState(hasError: true, isPermissionDenied: true);
        return;
      }

      if (!status.isGranted) {
        _updateScannerState(hasError: true, isPermissionDenied: true);
        return;
      }

      // 3. Clear error if granted
      _updateScannerState(hasError: false, isPermissionDenied: false);

      // 4. Start the controller safely
      try {
        await _controller.start();
      } catch (e) {
        debugPrint('Error starting camera: $e');
        _updateStateFromController();
      }
    } finally {
      _isStarting = false;
    }
  }

  void _onControllerStateChanged() {
    _updateStateFromController();
  }

  void _updateStateFromController() {
    final state = _controller.value;
    final error = state.error;

    bool newHasError = error != null;
    bool newIsPermissionDenied = error?.errorCode == MobileScannerErrorCode.permissionDenied;

    _updateScannerState(
      hasError: newHasError,
      isPermissionDenied: newIsPermissionDenied,
    );
  }

  void _updateScannerState({
    bool? hasError,
    bool? isPermissionDenied,
    bool? isScanned,
    String? scannedCode,
  }) {
    bool changed = false;

    if (hasError != null && hasError != this.hasError) {
      this.hasError = hasError;
      changed = true;
    }
    if (isPermissionDenied != null && isPermissionDenied != this.isPermissionDenied) {
      this.isPermissionDenied = isPermissionDenied;
      changed = true;
    }
    if (isScanned != null && isScanned != this.isScanned) {
      this.isScanned = isScanned;
      changed = true;
    }
    if (scannedCode != null && scannedCode != this.scannedCode) {
      this.scannedCode = scannedCode;
      changed = true;
    }

    if (changed) {
      onStateUpdate();
    }
  }

  Future<void> stop() async {
    try {
      await _controller.stop();
    } catch (_) {}
  }

  Future<void> recreate() async {
    try {
      await _controller.stop();
    } catch (_) {}
    _controller.removeListener(_onControllerStateChanged);
    _controller.dispose();

    _controller = _buildController();
    _controller.addListener(_onControllerStateChanged);
    scannerKey++;
    _updateScannerState(
      hasError: false,
      isPermissionDenied: false,
      isScanned: false,
      scannedCode: null,
    );
    await start();
  }

  Future<void> handleDetect(BarcodeCapture capture) async {
    if (isScanned) return;

    // Pro debounce (prevents rare frame glitches)
    final now = DateTime.now();
    if (_lastScanTime != null && now.difference(_lastScanTime!) < const Duration(milliseconds: 500)) {
      return;
    }
    _lastScanTime = now;

    for (final barcode in capture.barcodes) {
      if (barcode.format == BarcodeFormat.qrCode && barcode.rawValue != null) {
        final code = barcode.rawValue!;
        _updateScannerState(isScanned: true, scannedCode: code);
        
        // Optimize battery/safety by stopping after detection
        try {
          await _controller.stop();
        } catch (_) {}
        
        onCodeDetected(code);
        break;
      }
    }
  }

  Future<void> resetInternalState() async {
    _updateScannerState(isScanned: false, scannedCode: null);
    await start();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (!_controller.value.isInitialized) return;

    switch (state) {
      case AppLifecycleState.resumed:
        if (!hasError && !_controller.value.isRunning) {
          start();
        }
        break;
      case AppLifecycleState.inactive:
      case AppLifecycleState.paused:
      case AppLifecycleState.detached:
        stop();
        break;
      default:
        break;
    }
  }

  void dispose() {
    try {
      WidgetsBinding.instance.removeObserver(this);
      _controller.removeListener(_onControllerStateChanged);
      _controller.dispose();
    } catch (_) {}
  }
}
