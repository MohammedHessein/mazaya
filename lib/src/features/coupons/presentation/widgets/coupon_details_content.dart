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
    return BlocBuilder<UserCubit, UserState>(
      builder: (context, userState) {
        final user = userState.userModel;
        final isDisabled = !coupon.isActive;

        return Column(
          children: [
            Padding(
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 70.w,
                          height: 70.h,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(AppCircular.r12),
                            border: Border.all(color: AppColors.blue100),
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
                            children: [
                              Text(
                                coupon.categoryName ?? '',
                                style: context.textStyle.s14.medium.setHintColor,
                              ),
                              Text(
                                coupon.vendorName ?? '',
                                style: context.textStyle.s16.bold.setBlackColor,
                              ),
                              if (coupon.sku != null && coupon.sku!.isNotEmpty)
                                Text(
                                  'SKU: ${coupon.sku}',
                                  style:
                                      context.textStyle.s14.regular.setHintColor,
                                ),
                              if (coupon.packageNames != null &&
                                  coupon.packageNames!.isNotEmpty) ...[
                                8.szH,
                                Wrap(
                                  spacing: 4.w,
                                  runSpacing: 4.h,
                                  children: coupon.packageNames!.map((name) {
                                    final mType =
                                        MembershipType.fromString(name);
                                    return Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: AppPadding.pW12,
                                        vertical: AppPadding.pH4,
                                      ),
                                      decoration: BoxDecoration(
                                        color: mType.backgroundColor(context),
                                        borderRadius: BorderRadius.circular(
                                          AppCircular.r20,
                                        ),
                                      ),
                                      child: Text(
                                        mType.shortLabel,
                                        style:
                                            context.textStyle.s10.bold.setColor(
                                          mType.textColor(context),
                                        ),
                                      ),
                                    );
                                  }).toList(),
                                ),
                              ],
                            ],
                          ),
                        ),
                      ],
                    ),
                    if (coupon.description != null &&
                        coupon.description!.isNotEmpty) ...[
                      16.szH,
                      Text(
                        coupon.description ?? '',
                        style: context.textStyle.s12.regular.setColor(
                          AppColors.gray600,
                        ),
                        textAlign: TextAlign.start,
                      ),
                    ],
                    if (coupon.vendorDescription != null &&
                        coupon.vendorDescription!.isNotEmpty) ...[
                      12.szH,
                      Text(
                        LocaleKeys.storeDescription,
                        style: context.textStyle.s14.bold.setBlackColor,
                      ),
                      4.szH,
                      Text(
                        coupon.vendorDescription!,
                        style: context.textStyle.s12.regular.setColor(
                          AppColors.gray600,
                        ),
                        textAlign: TextAlign.start,
                      ),
                    ],
                    Divider(color: AppColors.gray100),
                    Row(
                      children: [
                        IconWidget(
                          icon: AppAssets.svg.baseSvg.percentage.path,
                          color: AppColors.primary,
                          height: 20.h,
                        ),
                        8.szW,
                        Expanded(
                          child: Text(
                            coupon.shortDescription ?? '',
                            style: context.textStyle.s14.bold.setPrimaryColor,
                          ),
                        ),
                      ],
                    ),
                    16.szH,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomCircularActionButton(
                          icon: AppAssets.svg.baseSvg.share.path,
                          onTap: isDisabled
                              ? null
                              : () {
                                  final box =
                                      context.findRenderObject() as RenderBox?;
                                  final String shareLink =
                                      'https://mazaya.com/coupon?id=${coupon.id}';
                                  final String message =
                                      '${coupon.vendorName ?? ''}\n${coupon.name}\n\n$shareLink';

                                  SharePlus.instance.share(
                                    ShareParams(
                                      text: message,
                                      sharePositionOrigin: box != null
                                          ? box.localToGlobal(Offset.zero) &
                                              box.size
                                          : null,
                                    ),
                                  );
                                },
                        ),
                        if (coupon.hasValidLocation ||
                            (coupon.vendorLink != null &&
                                coupon.vendorLink!.isNotEmpty)) ...[
                          16.szW,
                          CustomCircularActionButton(
                            icon: AppAssets.svg.baseSvg.location.path,
                            onTap: isDisabled
                                ? null
                                : () {
                                    if (coupon.hasValidLocation) {
                                      Go.to(
                                        OsmMapScreen(
                                          lat: coupon.lat!,
                                          lng: coupon.lng!,
                                          title: coupon.vendorName ??
                                              LocaleKeys.openMap,
                                        ),
                                      );
                                    } else if (coupon.vendorLink != null) {
                                      Go.to(
                                        WebViewScreen(
                                          url: coupon.vendorLink!,
                                          title: coupon.vendorName ?? '',
                                        ),
                                      );
                                    }
                                  },
                          ),
                        ],
                        16.szW,
                        CustomCircularActionButton(
                          iconColor:
                              coupon.isFav ? Colors.red : AppColors.black,
                          icon: coupon.isFav
                              ? Icons.favorite
                              : Icons.favorite_border,
                          onTap: isDisabled
                              ? null
                              : () {
                                  context.read<FavoriteManager>().toggle(
                                        id: coupon.id,
                                        coupon: coupon,
                                      );
                                  context
                                      .read<CouponDetailsCubit>()
                                      .toggleLocal(
                                        coupon.id,
                                      );
                                },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            if (coupon.productImage.isNotEmpty)
              Padding(
                padding: EdgeInsets.symmetric(horizontal: AppPadding.pW20),
                child: Container(
                  height: 200.h,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(AppCircular.r20),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(AppCircular.r20),
                    child: UniversalMediaWidget(
                      path: coupon.productImage,
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
            24.szH,
          ],
        );
      },
    );
  }
}
