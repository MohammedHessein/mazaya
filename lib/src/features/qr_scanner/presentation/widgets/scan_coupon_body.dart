import 'package:flutter/material.dart';
import 'package:mazaya/src/core/extensions/base_state.dart';
import 'package:mazaya/src/core/widgets/custom_messages.dart';
import 'package:mazaya/src/core/widgets/pickers/default_bottom_sheet.dart';
import 'package:mazaya/src/features/qr_scanner/entity/scan_result.dart';
import 'package:mazaya/src/features/qr_scanner/presentation/cubits/scan_cubit.dart';
import 'package:mazaya/src/features/qr_scanner/presentation/logic/app_scanner_controller.dart';
import 'package:mazaya/src/features/qr_scanner/presentation/widgets/scan_success_bottom_sheet.dart';
import 'package:mazaya/src/features/qr_scanner/presentation/widgets/scanner_bottom_controls.dart';
import 'package:mazaya/src/features/qr_scanner/presentation/widgets/scanner_camera_view.dart';
import 'package:mazaya/src/features/qr_scanner/presentation/widgets/scanner_error_view.dart';
import 'package:mazaya/src/features/qr_scanner/presentation/widgets/scanner_loading_overlay.dart';
import 'package:mazaya/src/features/qr_scanner/presentation/widgets/scanner_manual_form.dart';

import '../../../coupons/presentation/view/view_imports.dart';

class ScanCouponBody extends StatefulWidget {
  final bool isActive;
  final int? couponId;
  final String? initialQrPayload;
  final double? price;

  const ScanCouponBody({
    super.key,
    required this.isActive,
    this.couponId,
    this.initialQrPayload,
    this.price,
  });

  @override
  State<ScanCouponBody> createState() => _ScanCouponBodyState();
}

class _ScanCouponBodyState extends State<ScanCouponBody> {
  late AppScannerController _scannerController;
  bool _showForm = false;
  double? _capturedPrice;

  @override
  void initState() {
    super.initState();
    _capturedPrice = widget.price;
    _scannerController = AppScannerController(
      onStateUpdate: () => setState(() {}),
      onCodeDetected: (code) {
        context.read<ScanCubit>().scanQR(
              code,
              widget.couponId,
              _capturedPrice,
            );
      },
    );

    if (widget.couponId == null && widget.price == null) {
      _showForm = true;
    } else if (widget.isActive) {
      _scannerController.start();
    }
  }

  @override
  void didUpdateWidget(covariant ScanCouponBody oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isActive != oldWidget.isActive) {
      if (widget.isActive && !_showForm) {
        _scannerController.start();
      } else {
        _scannerController.stop();
      }
    }
  }

  @override
  void dispose() {
    _scannerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_showForm) {
      return ScannerManualForm(
        onContinue: (price, discount) {
          setState(() {
            _capturedPrice = price;
            _showForm = false;
          });
          if (widget.isActive) {
            _scannerController.start();
          }
        },
      );
    }

    return BlocConsumer<ScanCubit, AsyncState<ScanResult>>(
      listener: (context, state) {
        if (state.isSuccess) {
          showDefaultBottomSheet(
            context: context,
            child: ScanSuccessBottomSheet(scanResult: state.data),
          ).then((_) => _scannerController.resetInternalState());
        } else if (state.isError) {
          MessageUtils.showSnackBar(
            context: context,
            message: state.errorMessage ?? LocaleKeys.operationFaild,
            baseStatus: BaseStatus.error,
          );
          _scannerController.resetInternalState();
        }
      },
      builder: (context, state) {
        return Container(
          color: AppColors.black,
          child: Stack(
            children: [
              if (!_scannerController.hasError)
                ScannerCameraView(controller: _scannerController),
              if (!_scannerController.hasError)
                ScannerBottomControls(
                  scannedCode: _scannerController.scannedCode,
                  couponId: widget.couponId,
                  capturedPrice: _capturedPrice,
                ),
              if (_scannerController.hasError)
                ScannerErrorView(
                  isPermissionDenied: _scannerController.isPermissionDenied,
                  onRetry: _scannerController.recreate,
                ),
              if (state.isLoading) const ScannerLoadingOverlay(),
            ],
          ),
        );
      },
    );
  }
}
