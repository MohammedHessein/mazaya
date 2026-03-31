part of '../imports/view_imports.dart';

class MemberShipCard extends StatelessWidget {
  const MemberShipCard({super.key});

  @override
  Widget build(BuildContext context) {
    final user = UserCubit.instance.user;

    if (user.userPackageName == null) {
      return const SizedBox.shrink();
    }

    final membershipType = user.memberType == 'golden'
        ? MembershipType.golden
        : user.memberType == 'silver'
        ? MembershipType.sliver
        : MembershipType.diamond;

    final totalCoupons = user.userPackageCouponsLimit ?? 0;
    final usedCoupons = user.userPackageUsedCoupons ?? 0;
    final remainingCoupons =
        totalCoupons > usedCoupons ? totalCoupons - usedCoupons : 0;
    final progress = totalCoupons > 0 ? usedCoupons / totalCoupons : 0.0;

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
                      user.userPackageName ?? '',
                      style: context.textStyle.s14.bold.setMainTextColor,
                    ),
                  ],
                ),
                if (user.userPackageIsActive)
                  Text(
                    LocaleKeys.subscriptionActive.tr(),
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
                  LocaleKeys.totalCoupons(total: totalCoupons.toString()),
                  style: context.textStyle.s14.medium.setMainTextColor,
                ),
                Text(
                  LocaleKeys.remainingCoupons(count: remainingCoupons.toString()),
                  style: context.textStyle.s14.regular.setMainTextColor,
                ),
              ],
            ),
            12.szH,
            ClipRRect(
              borderRadius: BorderRadius.circular(AppCircular.r10),
              child: LinearProgressIndicator(
                value: progress,
                backgroundColor: AppColors.gray100,
                valueColor: const AlwaysStoppedAnimation<Color>(
                  AppColors.primary,
                ),
                minHeight: 10.h,
              ),
            ),
            if (user.userPackageEndDate != null) ...[
              15.szH,
              Align(
                alignment: AlignmentDirectional.topStart,
                child: Builder(
                  builder: (context) {
                    final endDate = DateTime.tryParse(user.userPackageEndDate!);
                    final isExpired = endDate != null && endDate.isBefore(DateTime.now());
                    return Text(
                      LocaleKeys.renewalDate(date: user.userPackageEndDate!),
                      style: context.textStyle.s12.regular.setColor(
                        isExpired ? AppColors.error : AppColors.success,
                      ),
                    );
                  },
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
