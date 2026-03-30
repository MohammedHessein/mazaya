part of '../imports/view_imports.dart';

class NotificationBody extends StatelessWidget {
  const NotificationBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: EdgeInsets.symmetric(
        horizontal: AppPadding.pW20,
        vertical: AppPadding.pH10,
      ),
      sliver: PaginatedSliverListWidget<NotificationsCubit, NotificationEntity>(
        skeletonItemCount: 10,
        config: const PaginatedListConfig(),
        skeletonBuilder: (context) =>
            NotificationCardWidget(NotificationEntity.initial()),
        itemBuilder: (context, item, index) => NotificationCardWidget(item),
        emptyWidget: EmptyWidget(
          path: AppAssets.svg.baseSvg.notificationEmpty.path,
          title: LocaleKeys.noNotificationsYet,
          desc: LocaleKeys.notificationReachMsg,
        ),
      ),
    );
  }
}
