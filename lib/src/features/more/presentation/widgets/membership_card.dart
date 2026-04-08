part of '../imports/view_imports.dart';

class MemberShipCard extends StatelessWidget {
  const MemberShipCard({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserCubit, UserState>(
      builder: (context, state) {
        final user = state.userModel;

        if (user.userPackageName == null) {
          return const SizedBox.shrink();
        }

        final mType = user.memberType?.toLowerCase() ?? '';
        final membershipType = (mType.contains('gold') || mType.contains('ذهب') || mType.contains('guld'))
            ? MembershipType.golden
            : (mType.contains('silver') || mType.contains('فض') || mType.contains('silv'))
                ? MembershipType.sliver
                : (mType.contains('volu') || mType.contains('متطوع'))
                    ? MembershipType.volunteer
                    : MembershipType.diamond;


        final totalCoupons = user.userPackageCouponsLimit ?? 0;
        final usedCoupons = user.userPackageUsedCoupons ?? 0;
        final remainingCoupons = user.userPackageRemainingCoupons ??
            (totalCoupons > usedCoupons ? totalCoupons - usedCoupons : 0);
        final progress = totalCoupons > 0 ? usedCoupons / totalCoupons : 0.0;

        return Container(
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            color: membershipType == MembershipType.volunteer
                ? AppColors.success.withValues(alpha: 0.1)
                : AppColors.white,
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
                                : membershipType == MembershipType.volunteer
                                    ? AppAssets.svg.baseSvg.volunteer.svg(
                                        width: 30.w,
                                        height: 30.w,
                                      )
                                    : AppAssets.svg.baseSvg.diamondMember.svg(
                                        width: 30.w,
                                        height: 30.w,
                                      ),
                        12.szW,
                        Text(
                          membershipType == MembershipType.golden
                              ? LocaleKeys.goldMember
                              : membershipType == MembershipType.sliver
                                  ? LocaleKeys.silverMember
                                  : membershipType == MembershipType.volunteer
                                      ? LocaleKeys.volunteerMember
                                      : LocaleKeys.diamondMember,
                          style: context.textStyle.s14.bold.setMainTextColor,
                        ),
                      ],
                    ),
                    Text(
                      user.userPackageIsActive
                          ? LocaleKeys.subscriptionActive
                          : LocaleKeys.subscriptionInactive,
                      style: context.textStyle.s12.medium.setColor(
                        user.userPackageIsActive
                            ? AppColors.success
                            : AppColors.error,
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
                      LocaleKeys.remainingCoupons(
                        count: remainingCoupons.toString(),
                      ),
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
                        final isExpired =
                            endDate != null && endDate.isBefore(DateTime.now());
                        return Text(
                          LocaleKeys.renewalDate(date: user.userPackageEndDate!),
                          style: context.textStyle.s12.regular.setColor(
                            isExpired ? AppColors.error : AppColors.primary,
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
      },
    );
  }
}
