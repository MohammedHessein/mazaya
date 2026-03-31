part of '../imports/view_imports.dart';

class MoreTabBody extends StatelessWidget {
  const MoreTabBody({super.key});

  @override
  Widget build(BuildContext context) {
    final mainItems = MoreItemEntity.mainItems(context);
    return SliverPadding(
      padding: EdgeInsets.symmetric(horizontal: AppPadding.pW20),
      sliver: SliverToBoxAdapter(
        child: Column(
          children: [
            16.szH,
            ...mainItems.map((item) => MoreMenuCardWidget(menuItem: item)),
            16.szH,
            Row(
              children: [
                Expanded(
                  child: ActionTile(
                    title: LocaleKeys.logout,
                    icon: AppAssets.svg.baseSvg.logout.path,
                    onTap: () async => await showDefaultBottomSheet(
                      child: BlocProvider(
                        create: (context) => injector<LogoutCubit>(),
                        child: const LogoutBottomSheet(),
                      ),
                    ),
                    color: AppColors.error,
                  ),
                ),
                12.szW,
                Expanded(
                  child: ActionTile(
                    title: LocaleKeys.settingsDeleteAccount,
                    icon: AppAssets.svg.baseSvg.profileDelete.path,
                    onTap: () async => await showDefaultBottomSheet(
                      child: BlocProvider(
                        create: (context) => injector<MoreDeleteAccountCubit>(),
                        child: const DeleteAccountBottomSheet(),
                      ),
                    ),
                    color: AppColors.error,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
