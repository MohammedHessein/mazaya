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
                        create: (context) => injector<DeleteAccountCubit>(),
                        child: const DeleteAccountBottomSheet(),
                      ),
                    ),
                    color: AppColors.error,
                  ),
                ),
              ],
            ),
            24.szH,
            AsyncBlocBuilder<AppSettingCubit, AppSettingModel?>(
              builder: (context, data) {
                if (data?.websiteLink == null) return const SizedBox.shrink();
                return InkWell(
                  onTap: () => Go.to(
                    WebViewScreen(
                      url: data!.websiteLink!,
                      title: LocaleKeys.visitOurWebsite.tr(),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconWidget(
                        icon: AppAssets.svg.baseSvg.global.path,
                        width: 20.w,
                        height: 20.w,
                        color: AppColors.primary,
                      ),
                      8.szW,
                      Text(
                        LocaleKeys.visitOurWebsite.tr(),
                        textAlign: TextAlign.center,
                        style: context.textStyle.s16.regular.setPrimaryColor,
                      ),
                    ],
                  ),
                );
              },
            ),
            16.szH,
          ],
        ),
      ),
    );
  }
}
