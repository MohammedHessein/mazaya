part of '../imports/view_imports.dart';

class _SettingsTabBody extends StatelessWidget {
  const _SettingsTabBody();

  @override
  Widget build(BuildContext context) {
    context.locale;
    final generalItems = SettingsItemEntity.generalItems;
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.symmetric(horizontal: AppPadding.pH14).copyWith(top: 60.h),
      itemCount: generalItems.length,
      itemBuilder: (context, index) {
        return MoreMenuCardWidget(menuItem: generalItems[index]);
      },
    );
  }
}
