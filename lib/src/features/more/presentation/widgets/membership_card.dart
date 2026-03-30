part of '../imports/view_imports.dart';

class MemberShipCard extends StatelessWidget {
  final MembershipType membershipType;

  const MemberShipCard({super.key, required this.membershipType});

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(AppCircular.r20),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withValues(alpha: 0.05),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
        border: Border.all(color: AppColors.black.withValues(alpha: 0.05)),
      ),
      child: Padding(
        padding: EdgeInsets.all(AppPadding.pH20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    membershipType == MembershipType.sliver
                        ? AppAssets.svg.baseSvg.silverMember.svg(
                            width: 30.w,
                            height: 30.w,
                          )
                        : membershipType == MembershipType.golden
                        ? AppAssets.svg.baseSvg.goldenMember.svg(
                            width: 30.w,
                            height: 30.w,
                          )
                        : AppAssets.svg.baseSvg.diamondMember.svg(
                            width: 30.w,
                            height: 30.w,
                          ),
                    12.szW,
                    Text(
                      membershipType == MembershipType.sliver
                          ? LocaleKeys.silverMembership
                          : membershipType == MembershipType.golden
                          ? LocaleKeys.goldMembership
                          : LocaleKeys.diamondMembership,
                      style: context.textStyle.s14.bold.setMainTextColor,
                    ),
                  ],
                ),
                Text(
                  LocaleKeys.subscriptionActive,
                  style: context.textStyle.s12.medium.setColor(
                    AppColors.success,
                  ),
                ),
              ],
            ),
            16.szH,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  LocaleKeys.totalCoupons(total: '20'),
                  style: context.textStyle.s14.medium.setMainTextColor,
                ),
                Text(
                  LocaleKeys.remainingCoupons(count: '15'),
                  style: context.textStyle.s14.regular.setMainTextColor,
                ),
              ],
            ),
            12.szH,
            ClipRRect(
              borderRadius: BorderRadius.circular(AppCircular.r10),
              child: LinearProgressIndicator(
                value: 0.75,
                backgroundColor: AppColors.gray100,
                valueColor: const AlwaysStoppedAnimation<Color>(
                  AppColors.primary,
                ),
                minHeight: 10.h,
              ),
            ),
            15.szH,
            Align(
              alignment: AlignmentDirectional.topStart,
              child: Text(
                LocaleKeys.renewalDate(date: '20 أكتوبر 2023'),
                style: context.textStyle.s12.regular.setPrimaryColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
