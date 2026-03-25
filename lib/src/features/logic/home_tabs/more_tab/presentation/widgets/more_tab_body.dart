part of '../imports/view_imports.dart';

class _MoreTabBody extends StatelessWidget {
  const _MoreTabBody();

  @override
  Widget build(BuildContext context) {
    context.locale;
    final generalItems = MoreItemEntity.generalItems;
    final otherItems = MoreItemEntity.otherItems;
    final guestItems = MoreItemEntity.guestItems;
    return Column(
      spacing: AppMargin.mH30,
      children: [
        if (UserCubit.instance.isUserLoggedIn)
          const ProfileInfoWithIconsWidget(
            profileIconAppear: ProfileIconAppearEnum.more,
          ),
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: AppMargin.mH18,
              children: [
                if (UserCubit.instance.isUserLoggedIn) ...[
                  _MoreSectionWidget(
                    titleKey: LocaleKeys.moreGeneralTitle,
                    items: generalItems,
                  ),
                  _MoreSectionWidget(
                    titleKey: LocaleKeys.moreOthersTitle,
                    items: otherItems,
                  ),
                ] else ...[
                  _MoreSectionWidget(
                    titleKey: ConstantManager.emptyText,
                    items: guestItems,
                  ),
                ],
              ],
            ),
          ),
        ),
      ],
    ).paddingAll(AppPadding.pH14);
  }
}
