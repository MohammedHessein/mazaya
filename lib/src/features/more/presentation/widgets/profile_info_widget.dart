part of '../imports/view_imports.dart';

class ProfileInfoWidget extends StatelessWidget {
  const ProfileInfoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserCubit, UserState>(
      builder: (context, state) {
        final user = state.userModel;
        final mType = user.memberType?.toLowerCase() ?? '';
        final membershipType =
            (mType.contains('gold') ||
                mType.contains('ذهب') ||
                mType.contains('guld'))
            ? MembershipType.golden
            : (mType.contains('silver') ||
                  mType.contains('فض') ||
                  mType.contains('silv'))
            ? MembershipType.sliver
            : MembershipType.diamond;
        final userName = user.name;
        final subTitle = membershipType == MembershipType.golden
            ? LocaleKeys.goldMember
            : membershipType == MembershipType.sliver
            ? LocaleKeys.silverMember
            : LocaleKeys.diamondMember;
        final hasPackage = user.userPackageName != null;

        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              userName.isNotEmpty ? userName : LocaleKeys.visitorText.tr(),
              style: context.textStyle.s18.bold.setMainTextColor,
            ),
            if (hasPackage && subTitle.isNotEmpty) ...[
              12.szH,
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: AppPadding.pW16,
                  vertical: AppPadding.pH8,
                ),
                decoration: BoxDecoration(
                  color: membershipType == MembershipType.golden
                      ? AppColors.orange.withValues(alpha: 0.1)
                      : membershipType == MembershipType.sliver
                      ? AppColors.gray200
                      : AppColors.blue100,
                  borderRadius: BorderRadius.circular(AppCircular.r20),
                  border: Border.all(color: Colors.transparent),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      subTitle,
                      style: membershipType == MembershipType.golden
                          ? context.textStyle.s14.setColor(AppColors.orange)
                          : membershipType == MembershipType.sliver
                          ? context.textStyle.s14.setHintColor
                          : context.textStyle.s14.setColor(AppColors.primary),
                    ),
                    10.szW,
                    membershipType == MembershipType.sliver
                        ? AppAssets.svg.baseSvg.silverMember.svg(
                            width: 18.w,
                            height: 18.w,
                          )
                        : membershipType == MembershipType.golden
                        ? AppAssets.svg.baseSvg.goldenMember.svg(
                            width: 18.w,
                            height: 18.w,
                          )
                        : AppAssets.svg.baseSvg.diamondMember.svg(
                            width: 18.w,
                            height: 18.w,
                          ),
                  ],
                ),
              ),
            ],
          ],
        );
      },
    );
  }
}
