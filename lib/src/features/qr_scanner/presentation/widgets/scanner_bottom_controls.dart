import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mazaya/src/core/extensions/context_extension.dart';
import 'package:mazaya/src/core/extensions/text_style_extensions.dart';

import '../../../../config/language/locale_keys.g.dart';
import '../../../../config/res/assets.gen.dart';
import '../../../../config/res/config_imports.dart';
import '../../../../core/extensions/base_state.dart';
import '../../../../core/extensions/widgets/sized_box_helper.dart';
import '../../../../core/widgets/buttons/loading_button.dart';
import '../../../../core/widgets/custom_messages.dart';
import '../cubits/scan_cubit.dart';

class ScannerBottomControls extends StatelessWidget {
  final String? scannedCode;
  final int? couponId;
  final double? capturedPrice;

  const ScannerBottomControls({
    super.key,
    this.scannedCode,
    this.couponId,
    this.capturedPrice,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
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
                if (scannedCode == null || scannedCode!.isEmpty) {
                  MessageUtils.showSnackBar(
                    context: context,
                    message: LocaleKeys.pleaseScanACodeFirst,
                    baseStatus: BaseStatus.initial,
                  );
                  return;
                }
                await context.read<ScanCubit>().scanQR(
                  scannedCode!,
                  couponId,
                  capturedPrice,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
