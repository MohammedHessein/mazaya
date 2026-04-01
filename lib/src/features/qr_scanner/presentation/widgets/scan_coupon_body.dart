import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mazaya/src/config/language/locale_keys.g.dart';
import 'package:mazaya/src/config/res/assets.gen.dart';
import 'package:mazaya/src/config/res/config_imports.dart';
import 'package:mazaya/src/core/base_crud/code/presentation/cubit/base_cubit/async_cubit.dart';
import 'package:mazaya/src/core/extensions/context_extension.dart';
import 'package:mazaya/src/core/extensions/text_style_extensions.dart';
import 'package:mazaya/src/core/extensions/widgets/sized_box_helper.dart';
import 'package:mazaya/src/core/widgets/buttons/loading_button.dart';
import 'package:mazaya/src/core/widgets/pickers/default_bottom_sheet.dart';
import 'package:mazaya/src/features/coupons/entity/coupon_entity.dart';
import 'package:mazaya/src/features/coupons/presentation/cubits/coupon_details_cubit.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

import 'scan_success_bottom_sheet.dart';
import 'scanner_overlay.dart';

class ScanCouponBody extends StatefulWidget {
  const ScanCouponBody({super.key});

  @override
  State<ScanCouponBody> createState() => _ScanCouponBodyState();
}

class _ScanCouponBodyState extends State<ScanCouponBody>
    with WidgetsBindingObserver {
  late final MobileScannerController controller;
  bool isScanned = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    controller = MobileScannerController(
      detectionSpeed: DetectionSpeed.normal,
      facing: CameraFacing.back,
      autoStart: true,
    );
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (!controller.value.isInitialized) return;

    switch (state) {
      case AppLifecycleState.resumed:
        controller.start();
        break;
      case AppLifecycleState.inactive:
      case AppLifecycleState.paused:
      case AppLifecycleState.detached:
        controller.stop();
        break;
      default:
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
    if (context.read<CouponDetailsCubit>().isLoading) return;

    final List<Barcode> barcodes = capture.barcodes;
    if (barcodes.isEmpty) return;

    final String? rawValue = barcodes.first.rawValue;
    if (rawValue == null || rawValue.isEmpty) return;

    String scannedValue = rawValue;

    // Try parsing as JSON first
    try {
      final jsonMap = jsonDecode(rawValue);
      if (jsonMap is Map && jsonMap.containsKey('id')) {
        scannedValue = jsonMap['id'].toString();
      }
    } catch (e) {
      // Not a valid JSON, try to extract from URL if present
      if (rawValue.contains('/')) {
        scannedValue = rawValue.split('/').last;
      }
    }

    if (mounted) {
      setState(() {
        isScanned = true;
      });
    }

    // Fetch coupon details via Cubit with extracted real ID
    context.read<CouponDetailsCubit>().getCouponDetails(scannedValue);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CouponDetailsCubit, AsyncState<CouponEntity>>(
      listener: (context, state) {
        if (state.isSuccess) {
          showDefaultBottomSheet(
            context: context,
            child: ScanSuccessBottomSheet(coupon: state.data),
          ).then((value) {
            if (mounted) {
              setState(() {
                isScanned = false;
              });
            }
          });
        } else if (state.isError) {
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
                  child: Text(
                    '${LocaleKeys.cameraError}${error.errorCode}',
                    style: context.textStyle.s14.medium.setWhiteColor,
                    textAlign: TextAlign.center,
                  ),
                );
              },
            ),
            const ScannerOverlay(),
            Positioned(
              bottom: 40.h,
              left: 20.w,
              right: 20.w,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    LocaleKeys.placeQrCode,
                    style: context.textStyle.s16.medium.setWhiteColor,
                    textAlign: TextAlign.center,
                  ),
                  30.szH,
                  LoadingButtonWithIcon(
                    icon: AppAssets.svg.baseSvg.coupon.path,
                    title: LocaleKeys.scanCouponCode,
                    onTap: () async {
                      // Show the success bottom sheet directly for UI testing
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        backgroundColor: Colors.transparent,
                        builder: (context) => ScanSuccessBottomSheet(
                          coupon: CouponEntity(
                            id: 7,
                            categoryName: 'مقاهي',
                            vendorName: 'ستاربكس',
                            discount: 15,
                            name: 'خصم 15% على المشروبات',
                            vendorImage:
                                AppAssets.svg.appSvg.appLauncherIcon.path,
                            description: 'صالح لمدة 3 أيام',
                            isFav: false,
                            productImage: '',
                          ),
                        ),
                      );
                    },
                  ),
                  100.szH,
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
