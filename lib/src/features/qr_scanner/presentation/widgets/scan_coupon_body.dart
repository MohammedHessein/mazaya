import 'package:app_settings/app_settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mazaya/src/config/language/locale_keys.g.dart';
import 'package:mazaya/src/config/res/assets.gen.dart';
import 'package:mazaya/src/config/res/config_imports.dart';
import 'package:mazaya/src/core/base_crud/code/presentation/cubit/base_cubit/async_cubit.dart';
import 'package:mazaya/src/core/extensions/base_state.dart';
import 'package:mazaya/src/core/extensions/context_extension.dart';
import 'package:mazaya/src/core/extensions/text_style_extensions.dart';
import 'package:mazaya/src/core/extensions/widgets/sized_box_helper.dart';
import 'package:mazaya/src/core/widgets/buttons/loading_button.dart';
import 'package:mazaya/src/core/widgets/custom_messages.dart';
import 'package:mazaya/src/core/widgets/pickers/default_bottom_sheet.dart';
import 'package:mazaya/src/features/qr_scanner/entity/scan_result.dart';
import 'package:mazaya/src/features/qr_scanner/presentation/cubits/scan_cubit.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

import 'scan_success_bottom_sheet.dart';
import 'scanner_overlay.dart';

class ScanCouponBody extends StatefulWidget {
  final bool isActive;
  final int? couponId;
  final String? initialQrPayload;
  const ScanCouponBody({
    super.key,
    required this.isActive,
    this.couponId,
    this.initialQrPayload,
  });

  @override
  State<ScanCouponBody> createState() => _ScanCouponBodyState();
}

class _ScanCouponBodyState extends State<ScanCouponBody>
    with WidgetsBindingObserver {
  MobileScannerController? _controller; // ✅ nullable بدل late
  bool isScanned = false;
  String? scannedCode;
  bool _hasError = false;
  bool _isPermissionDenied = false;
  int _scannerKey =
      0; // ✅ بنزود الـ key ده عشان نـ force rebuild للـ MobileScanner

  MobileScannerController _buildController() {
    return MobileScannerController(
      detectionSpeed: DetectionSpeed.noDuplicates,
      formats: [BarcodeFormat.qrCode],
      autoStart: false, // ✅ false دايماً، إحنا اللي بنبدأه
    );
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _controller = _buildController();
    if (widget.isActive) {
      WidgetsBinding.instance.addPostFrameCallback((_) => _startCamera());
    }
  }

  Future<void> _startCamera() async {
    if (!mounted || !widget.isActive) return;
    final ctrl = _controller;
    if (ctrl == null) return;

    try {
      await ctrl.start();
    } catch (e) {
      debugPrint('Error starting camera: $e');
      if (mounted) {
        setState(() {
          _hasError = true;
          _isPermissionDenied =
              e.toString().contains('permissionDenied') ||
              e.toString().toLowerCase().contains('permission');
        });
      }
    }
  }

  void _stopCamera() {
    _controller?.stop();
  }

  // ✅ الحل الحقيقي: بنـ dispose الـ controller القديم ثم بنبني واحد جديد
  // وبنزود الـ _scannerKey عشان Flutter يشيل الـ MobileScanner widget القديم
  // ويبني واحد جديد بالـ controller الجديد من الأول
  Future<void> _recreateController() async {
    if (!mounted) return;

    // 1. نوقف ونـ dispose الـ controller القديم
    final old = _controller;
    _controller = null; // نفصله أولاً عشان الـ widget ميستخدمهوش

    if (old != null) {
      try {
        await old.stop();
      } catch (_) {}
      old.dispose();
    }

    if (!mounted) return;

    // 2. نبني controller جديد ونزود الـ key
    // الـ key الجديد هيخلي Flutter يـ unmount الـ MobileScanner القديم
    // ويبني واحد جديد تماماً مع الـ controller الجديد
    final newController = _buildController();
    setState(() {
      _controller = newController;
      _scannerKey++; // ✅ ده اللي بيحل المشكلة
      _hasError = false;
      _isPermissionDenied = false;
      isScanned = false;
      scannedCode = null;
    });

    // 3. بعد ما الـ widget يتبني، نبدأ الكاميرا
    WidgetsBinding.instance.addPostFrameCallback((_) => _startCamera());
  }

  @override
  void didUpdateWidget(covariant ScanCouponBody oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isActive != oldWidget.isActive) {
      if (widget.isActive) {
        _startCamera();
      } else {
        _stopCamera();
      }
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
        if (widget.isActive && !_hasError) {
          // Only auto-start if there's no pre-existing error.
          // If we have an error (e.g. Deny), wait for manual Retry.
          if (_controller?.value.isRunning == false) {
            _startCamera();
          }
        }
        break;
      case AppLifecycleState.inactive:
      case AppLifecycleState.paused:
      case AppLifecycleState.detached:
        _stopCamera();
        break;
      case AppLifecycleState.hidden:
        break;
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _controller?.dispose();
    super.dispose();
  }

  void _onDetect(BarcodeCapture capture) {
    if (isScanned) return;
    for (final barcode in capture.barcodes) {
      if (barcode.format == BarcodeFormat.qrCode && barcode.rawValue != null) {
        setState(() {
          isScanned = true;
          scannedCode = barcode.rawValue;
        });
        context.read<ScanCubit>().scanQR(barcode.rawValue!, widget.couponId);
        break;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final ctrl = _controller;

    return BlocConsumer<ScanCubit, AsyncState<ScanResult>>(
      listener: (context, state) {
        if (state.isSuccess) {
          showDefaultBottomSheet(
            context: context,
            child: ScanSuccessBottomSheet(scanResult: state.data),
          ).then((_) {
            if (mounted)
              setState(() {
                isScanned = false;
                scannedCode = null;
              });
          });
        } else if (state.isError) {
          ScaffoldMessenger.of(context).removeCurrentSnackBar();
          MessageUtils.showSnackBar(
            context: context,
            message: state.errorMessage ?? LocaleKeys.operationFaild,
            baseStatus: BaseStatus.error,
          );
          if (mounted) setState(() => isScanned = false);
        }
      },
      builder: (context, state) {
        return Container(
          color: AppColors.black,
          child: Stack(
            children: [
              // ✅ الـ key هنا هو اللي بيضمن إن Flutter يعمل dispose للـ widget
              // القديم ويبني واحد جديد لما نزود _scannerKey
              if (!_hasError && ctrl != null)
                MobileScanner(
                  key: ValueKey(_scannerKey),
                  controller: ctrl,
                  onDetect: _onDetect,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, child) {
                    // One-shot error handling to prevent flicker loops
                    if (!_hasError) {
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        if (mounted && !_hasError) {
                          _controller?.stop();
                          setState(() {
                            _hasError = true;
                            _isPermissionDenied =
                                error.errorCode ==
                                MobileScannerErrorCode.permissionDenied;
                          });
                        }
                      });
                    }
                    return const SizedBox.shrink();
                  },
                ),

              if (!_hasError) const ScannerOverlay(),

              if (!_hasError)
                Positioned(
                  bottom: 120.h,
                  left: 0,
                  right: 0,
                  child: _buildBottomControls(context),
                ),

              if (_hasError) _buildErrorFullScreen(context),

              if (state.isLoading)
                Positioned.fill(
                  child: Container(
                    color: AppColors.black.withValues(alpha: 0.5),
                    child: const Center(
                      child: CircularProgressIndicator(color: AppColors.white),
                    ),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildBottomControls(BuildContext context) {
    return Column(
      children: [
        Text(
          LocaleKeys.placeQrCode,
          style: context.textStyle.s17.setWhiteColor.copyWith(
            color: AppColors.white.withValues(alpha: 0.8),
          ),
        ),
        30.szH,
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: LoadingButtonWithIcon(
            title: LocaleKeys.scanCouponCode,
            icon: AppAssets.svg.baseSvg.coupon.path,
            onTap: () async {
              final payload = scannedCode?.isNotEmpty == true ? scannedCode : null;

              if (payload == null) {
                ScaffoldMessenger.of(context).removeCurrentSnackBar();
                MessageUtils.showSnackBar(
                  context: context,
                  message: LocaleKeys.pleaseScanACodeFirst,
                  baseStatus: BaseStatus.initial,
                );
                return;
              }
              await context.read<ScanCubit>().scanQR(payload, widget.couponId);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildErrorFullScreen(BuildContext context) {
    return Positioned.fill(
      child: Container(
        color: AppColors.black,
        child: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 30.w),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.camera_alt_outlined,
                  color: AppColors.white,
                  size: 64,
                ),
                24.szH,
                Text(
                  _isPermissionDenied
                      ? LocaleKeys.cameraPermissionDenied
                      : LocaleKeys.cameraError,
                  style: context.textStyle.s16.medium.setWhiteColor,
                  textAlign: TextAlign.center,
                ),
                32.szH,
                if (_isPermissionDenied) ...[
                  LoadingButton(
                    title: LocaleKeys.settingsTitle,
                    onTap: () => AppSettings.openAppSettings(),
                  ),
                  16.szH,
                ],
                LoadingButton(
                  title: LocaleKeys.retry,
                  // ✅ الـ retry button كمان بيعمل recreate مش بس start
                  onTap: _recreateController,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
