part of '../imports/view_imports.dart';

class MoreTabBody extends StatelessWidget {
  const MoreTabBody({super.key});

  @override
  Widget build(BuildContext context) {
    final mainItems = MoreItemEntity.mainItems(context);
    return SliverPadding(
      padding: EdgeInsets.symmetric(horizontal: AppPadding.pW20),
      sliver: SliverToBoxAdapter(
        child: Transform.translate(
          offset: Offset(0, -50.h),
          child: Column(
            children: [
              if (UserCubit.instance.isUserLoggedIn) ...[
                15.szH,
                const ProfileDecorationWidget(
                  membershipType: MembershipType.diamond,
                ),
                16.szH,
                const MemberShipCard(membershipType: MembershipType.golden),
                12.szH,
              ],
              ...mainItems.map((item) => MoreMenuCardWidget(menuItem: item)),
              16.szH,
              Row(
                children: [
                  Expanded(
                    child: ActionTile(
                      title: LocaleKeys.logout,
                      icon: AppAssets.svg.baseSvg.logout.path,
                      onTap: () async => await logOut(),
                      color: AppColors.error,
                    ),
                  ),
                  12.szW,
                  Expanded(
                    child: ActionTile(
                      title: LocaleKeys.settingsDeleteAccount,
                      icon: AppAssets.svg.baseSvg.profileDelete.path,
                      onTap: () {},
                      color: AppColors.error,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
