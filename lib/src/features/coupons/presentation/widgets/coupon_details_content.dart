import 'package:flutter/material.dart';
import 'package:mazaya/src/features/coupons/presentation/cubits/coupon_details_cubit.dart';

import '../view/view_imports.dart';

class CouponDetailsContent extends StatelessWidget {
  final CouponEntity coupon;
  final bool isSkeleton;

  const CouponDetailsContent({
    super.key,
    required this.coupon,
    this.isSkeleton = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppPadding.pW20),
      child: Container(
        padding: EdgeInsets.all(AppPadding.pW16),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(AppCircular.r20),
          boxShadow: [
            BoxShadow(
              color: AppColors.black.withValues(alpha: 0.05),
              blurRadius: 15,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 70.w,
                  height: 70.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(AppCircular.r12),
                    border: Border.all(color: AppColors.gray100),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(AppCircular.r12),
                    child: UniversalMediaWidget(
                      path:
                          coupon.vendorImage != null &&
                              coupon.vendorImage!.isNotEmpty
                          ? coupon.vendorImage!
                          : AppAssets.svg.appSvg.appLauncherIcon.path,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                12.szW,
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        coupon.categoryName ?? '',
                        style: context.textStyle.s12.medium.setHintColor,
                      ),
                      4.szH,
                      Text(
                        coupon.vendorName ?? '',
                        style: context.textStyle.s16.bold.setBlackColor,
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CustomCircularActionButton(
                      icon: AppAssets.svg.baseSvg.share.path,
                      onTap: () {},
                    ),
                    10.szW,
                    CustomCircularActionButton(
                      iconColor: AppColors.black,
                      icon: coupon.isFav
                          ? Icons.favorite
                          : Icons.favorite_border,
                      onTap: () {
                        context.read<CouponDetailsCubit>().toggleFavorite(
                          coupon.id,
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
            24.szH,
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
              decoration: BoxDecoration(
                color: AppColors.blue50,
                borderRadius: BorderRadius.circular(AppCircular.r12),
                border: Border.all(color: AppColors.blue100),
              ),
              child: Row(
                children: [
                  IconWidget(
                    icon: AppAssets.svg.baseSvg.percentage.path,
                    color: AppColors.primary,
                    height: 25.h,
                  ),
                  10.szW,
                  Expanded(
                    child: Text(
                      coupon.shortDescription ?? '',
                      style: context.textStyle.s14.bold.setPrimaryColor,
                    ),
                  ),
                ],
              ),
            ),
            24.szH,
            Text(coupon.name, style: context.textStyle.s16.bold.setBlackColor),
            12.szH,
            Text(
              coupon.description ?? '',
              style: context.textStyle.s14.regular.setColor(AppColors.gray600),
              textAlign: TextAlign.start,
            ),
          ],
        ),
      ),
    );
  }
}
