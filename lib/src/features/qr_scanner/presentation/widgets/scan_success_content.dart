import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mazaya/src/config/language/locale_keys.g.dart';
import 'package:mazaya/src/config/res/assets.gen.dart';
import 'package:mazaya/src/config/res/config_imports.dart';
import 'package:mazaya/src/core/extensions/context_extension.dart';
import 'package:mazaya/src/core/extensions/text_style_extensions.dart';
import 'package:mazaya/src/core/extensions/widgets/sized_box_helper.dart';
import 'package:mazaya/src/core/navigation/navigator.dart';
import 'package:mazaya/src/core/widgets/buttons/loading_button.dart';
import 'package:mazaya/src/core/widgets/universal_media/universal_media_widget.dart';
import 'package:mazaya/src/features/coupons/entity/coupon_entity.dart';
import 'package:mazaya/src/features/main/presentation/view/main_screen.dart';

class ScanSuccessContent extends StatelessWidget {
  final CouponEntity coupon;

  const ScanSuccessContent({super.key, required this.coupon});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        UniversalMediaWidget(
          path: AppAssets.svg.baseSvg.doneAction.path,
          width: 140.w,
          height: 140.w,
        ),
        26.szH,
        Container(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
          decoration: BoxDecoration(
            color: const Color(0xFFE8F5E9), // Light Green
            borderRadius: BorderRadius.circular(AppCircular.r20),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                LocaleKeys.scannedSuccessfully,
                style: context.textStyle.s14.bold.copyWith(
                  color: AppColors.success,
                ),
              ),
              Icon(Icons.check, size: 18.sp, color: AppColors.success),
              8.szW,
            ],
          ),
        ),
        24.szH,
        Row(
          children: [
            Container(
              width: 50.w,
              height: 50.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(AppCircular.r8),
                border: Border.all(color: AppColors.gray200),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(AppCircular.r8),
                child: UniversalMediaWidget(
                  path:
                      coupon.vendorImage ??
                      AppAssets.svg.appSvg.appLauncherIcon.path,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            12.szW,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    coupon.categoryName ?? '',
                    style: context.textStyle.s12.medium.setHintColor,
                  ),
                  Text(
                    coupon.vendorName ?? '',
                    style: context.textStyle.s16.bold.setBlackColor,
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
              decoration: BoxDecoration(
                color: const Color(0xFFE3F2FD), // Light Blue
                borderRadius: BorderRadius.circular(AppCircular.r8),
              ),
              child: Text(
                '${LocaleKeys.oFF} ${coupon.discount}%',
                style: context.textStyle.s12.bold.copyWith(
                  color: AppColors.primary,
                ),
              ),
            ),
          ],
        ),
        40.szH,
        LoadingButton(
          title: LocaleKeys.returnToHome,
          onTap: () async {
            Go.back();
            Go.offAll(const MainScreen());
          },
        ),
        10.szH,
      ],
    );
  }
}
