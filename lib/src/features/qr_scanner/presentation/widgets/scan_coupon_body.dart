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
  late final MobileScannerController controller;
  bool isScanned = false;
  String? scannedCode;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    controller = MobileScannerController(
      detectionSpeed: DetectionSpeed.noDuplicates,
      formats: [BarcodeFormat.qrCode],
      autoStart: true,
    );
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

  void _startCamera() {
    if (!controller.value.isRunning && widget.isActive) {
      controller.start().catchError((e) {
        debugPrint('Error starting camera: $e');
      });
    }
  }

  void _stopCamera() {
    if (controller.value.isRunning) {
      controller.stop();
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (!controller.value.isInitialized) return;

    switch (state) {
      case AppLifecycleState.resumed:
        if (widget.isActive) _startCamera();
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
    controller.dispose();
    super.dispose();
  }

  void _onDetect(BarcodeCapture capture) {
    if (isScanned) return;

    final String? code = capture.barcodes.first.rawValue;
    if (code != null) {
      setState(() {
        isScanned = true;
        scannedCode = code;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ScanCubit, AsyncState<ScanResult>>(
      listener: (context, state) {
        if (state.isSuccess) {
          showDefaultBottomSheet(
            context: context,
            child: ScanSuccessBottomSheet(scanResult: state.data),
          ).then((value) {
            if (mounted) {
              setState(() {
                isScanned = false;
                scannedCode = null;
              });
            }
          });
        } else if (state.isError) {
          // Provide visual feedback for errors
          MessageUtils.showSnackBar(
            message: state.errorMessage ?? LocaleKeys.operationFaild,
            baseStatus: BaseStatus.error,
          );
          if (mounted) {
            setState(() {
              isScanned = false;
            });
          }
        }
      },
      child: Container(
        color: AppColors.black,
        child: Stack(
          children: [
            MobileScanner(
              controller: controller,
              onDetect: _onDetect,
              fit: BoxFit.cover,
              errorBuilder: (context, error, child) {
                return Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.error_outline,
                        color: AppColors.white,
                        size: 48,
                      ),
                      16.szH,
                      Text(
                        LocaleKeys.cameraPermissionDenied,
                        style: context.textStyle.s16.setWhiteColor,
                      ),
                      16.szH,
                      LoadingButton(
                        title: LocaleKeys.retry,
                        onTap: () async => _startCamera(),
                      ),
                    ],
                  ),
                );
              },
            ),
            const ScannerOverlay(),
            Positioned(
              bottom: 120.h,
              left: 0,
              right: 0,
              child: Column(
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
                        final cubit = context.read<ScanCubit>();
                        String? payload;
                        debugPrint('--- Manual Scan Triggered ---');
                        debugPrint('scannedCode: $scannedCode');
                        debugPrint(
                          'initialQrPayload: ${widget.initialQrPayload}',
                        );
                        debugPrint('couponId: ${widget.couponId}');
                        if (scannedCode != null && scannedCode!.isNotEmpty) {
                          payload = scannedCode!;
                          debugPrint('Payload source: Scanned Camera');
                        } else if (widget.initialQrPayload != null &&
                            widget.initialQrPayload!.isNotEmpty) {
                          payload = widget.initialQrPayload!;
                          debugPrint('Payload source: Initial Data');
                        }
                        if (payload == null) {
                          debugPrint('No payload available. Aborting scan.');
                          MessageUtils.showSnackBar(
                            message: LocaleKeys.pleaseScanACodeFirst,
                            baseStatus: BaseStatus.initial,
                          );
                          return;
                        }
                        debugPrint('Sending payload: $payload');
                        await cubit.scanQR(payload, widget.couponId);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
