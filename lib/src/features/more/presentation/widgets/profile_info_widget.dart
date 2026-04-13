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
            : (mType.contains('volu') || mType.contains('متطوع'))
            ? MembershipType.volunteer
            : MembershipType.diamond;
        final userName = user.name;
        final subTitle = membershipType.label;
        final hasPackage = user.userPackageName != null;

        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              userName.isNotEmpty ? userName : LocaleKeys.visitorText,
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
                      : membershipType == MembershipType.volunteer
                      ? AppColors.success.withValues(alpha: 0.1)
                      : AppColors.blue100,
                  borderRadius: BorderRadius.circular(AppCircular.r20),
                  border: Border.all(color: Colors.transparent),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      membershipType.label,
                      style: membershipType == MembershipType.golden
                          ? context.textStyle.s14.setColor(AppColors.orange)
                          : membershipType == MembershipType.sliver
                          ? context.textStyle.s14.setHintColor
                          : membershipType == MembershipType.volunteer
                          ? context.textStyle.s14.setColor(AppColors.success)
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
                        : membershipType == MembershipType.volunteer
                        ? AppAssets.svg.baseSvg.volunteer.svg(
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
            if (userName.isNotEmpty) ...[
              10.szH,
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  AppAssets.svg.baseSvg.calendar.svg(
                    width: 14.w,
                    height: 14.w,
                    colorFilter: const ColorFilter.mode(
                      AppColors.hintText,
                      BlendMode.srcIn,
                    ),
                  ),
                  4.szW,
                  Text(
                    LocaleKeys.memberSince(
                      date: DateTime.tryParse(user.createdAt)?.toDayMonthYear(
                            context.locale.languageCode,
                          ) ??
                          '',
                    ),
                    style: context.textStyle.s12.regular.setHintColor.setHeight(
                      1.7,
                    ),
                  ),
                ],
              ),
            ],
          ],
        );
      },
    );
  }
}
