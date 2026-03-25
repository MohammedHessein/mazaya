part of '../imports/view_imports.dart';

class _SettingsTabBody extends StatelessWidget {
  const _SettingsTabBody();

  @override
  Widget build(BuildContext context) {
    context.locale;
    final generalItems = SettingsItemEntity.generalItems;
    return ListView.builder(
      padding: EdgeInsets.all(AppPadding.pH14),
      itemCount: generalItems.length,

      itemBuilder: (context, index) {
        return MoreMenuCardWidget(menuItem: generalItems[index]);
      },
    );
  }
}
