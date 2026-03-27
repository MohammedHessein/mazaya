part of '../imports/view_imports.dart';

class _NotificationBody extends StatelessWidget {
  const _NotificationBody();

  @override
  Widget build(BuildContext context) {
    return PaginatedListWidget<NotificationsCubit, NotificationEntity>(
      skeletonItemCount: 10,
      config: PaginatedListConfig(padding: EdgeInsets.all(AppPadding.pH10)),
      skeletonBuilder: (context) =>
          _NotificationCardWidget(NotificationEntity.initail()),
      itemBuilder: (context, item, index) => _NotificationCardWidget(item),
      emptyWidget: EmptyWidget(
        path: AppAssets.svg.baseSvg.notificationEmpty.path,
        title: LocaleKeys.noNotificationsTitle,
        desc: LocaleKeys.noNotificationsDesc,
      ),
    );
  }
}
