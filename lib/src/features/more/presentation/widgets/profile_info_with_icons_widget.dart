part of '../imports/view_imports.dart';

enum ProfileIconAppearEnum { main, more }

class ProfileInfoWithIconsWidget extends StatelessWidget {
  final ProfileIconAppearEnum profileIconAppear;
  const ProfileInfoWithIconsWidget({
    super.key,
    this.profileIconAppear = ProfileIconAppearEnum.main,
  });

  @override
  Widget build(BuildContext context) {
    context.locale;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Visibility(
          visible: UserCubit.instance.isUserLoggedIn,
          replacement: AppAssets.svg.appSvg.home.svg(
            width: AppSize.sH50,
            height: AppSize.sH50,
          ),
          child: const _ProfileInfoWidget(),
        ),
        if (profileIconAppear == ProfileIconAppearEnum.main) ...[
          const _ProfileIconsWidget(),
        ] else ...[
          AppAssets.svg.appSvg.home.svg().onClick(
            onTap: () => Go.to(const SettingsScreen()),
          ),
        ],
      ],
    );
  }
}

class _ProfileInfoWidget extends StatelessWidget {
  const _ProfileInfoWidget();

  @override
  Widget build(BuildContext context) {
    context.locale;
    return Container(
      padding: EdgeInsets.all(AppPadding.pH4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppCircular.infinity),
        border: Border.all(color: AppColors.border, width: AppSize.sW1),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        spacing: AppMargin.mW6,
        children: [
          CachedImage(
            url: UserCubit.instance.user.image,
            boxShape: BoxShape.circle,
            width: AppSize.sH35,
            height: AppSize.sH35,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                LocaleKeys.goodToSee,
                style: const TextStyle().setSecondryColor.s10.regular,
              ),
              Text(
                UserCubit.instance.user.fullName,
                style: const TextStyle().setMainTextColor.s12.regular,
              ),
            ],
          ),
          AppSize.sW6.szW,
        ],
      ),
    );
  }
}

class _ProfileIconsWidget extends StatelessWidget {
  const _ProfileIconsWidget();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      spacing: AppMargin.mW10,
      children: [
        BlocBuilder<UnreadNotificationCountCubit, int>(
          builder: (context, unreadCount) {
            return BadgeIconWidget(
              badgeCount: unreadCount,
              child: AppAssets.svg.appSvg.home.svg(),
            ).onClick(
              onTap: () {
                if (UserCubit.instance.isUserLoggedIn) {
                  final cubit = context.read<UnreadNotificationCountCubit>();
                  Go.to(const NotificationScreen()).then((_) {
                    cubit.fetchUnreadCount();
                  });
                } else {
                  visitorDialog(LocaleKeys.guestNotifBlocked);
                }
              },
            );
          },
        ),
      ],
    );
  }
}
