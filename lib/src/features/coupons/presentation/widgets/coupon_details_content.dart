import 'package:flutter/material.dart';
import 'package:mazaya/src/features/coupons/presentation/cubits/coupon_details_cubit.dart';
import 'package:share_plus/share_plus.dart';

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
      padding: EdgeInsets.symmetric(
        horizontal: AppPadding.pW20,
        vertical: AppPadding.pH16,
      ),
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
                  height: 90.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(AppCircular.r12),
                    border: Border.all(color: AppColors.gray100),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(AppCircular.r12),
                    child: UniversalMediaWidget(
                      path: coupon.vendorImage != null &&
                              coupon.vendorImage!.isNotEmpty
                          ? coupon.vendorImage!
                          : AppAssets.svg.appSvg.appLauncherIcon.path,
                      fit: BoxFit.contain,
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
                      if (coupon.sku != null && coupon.sku!.isNotEmpty) ...[
                        4.szH,
                        Text(
                          'SKU: ${coupon.sku}',
                          style: context.textStyle.s12.regular.setHintColor,
                        ),
                      ],
                    ],
                  ),
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CustomCircularActionButton(
                      icon: AppAssets.svg.baseSvg.share.path,
                      onTap: () {
                        debugPrint(
                          '🚀 Share Clicked for product: ${coupon.id}',
                        );
                        final box = context.findRenderObject() as RenderBox?;
                        final String shareLink =
                            'https://mazaya.com/coupon?id=${coupon.id}';
                        final String message =
                            '${coupon.vendorName ?? ''}\n${coupon.name}\n\n$shareLink';

                        SharePlus.instance.share(
                          ShareParams(
                            text: message,
                            sharePositionOrigin: box != null
                                ? box.localToGlobal(Offset.zero) & box.size
                                : null,
                          ),
                        );
                      },
                    ),
                    10.szW,
                    CustomCircularActionButton(
                      iconColor: AppColors.black,
                      icon: coupon.isFav
                          ? Icons.favorite
                          : Icons.favorite_border,
                      onTap: () {
                        context.read<FavoriteManager>().toggle(
                          id: coupon.id,
                          coupon: coupon,
                        );
                        // Also update the local state of this specific Details Cubit
                        context.read<CouponDetailsCubit>().toggleLocal(
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
