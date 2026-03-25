part of '../imports/view_imports.dart';

class _NotificationCardWidget extends StatelessWidget {
  final NotificationEntity notificationEntity;
  const _NotificationCardWidget(this.notificationEntity);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(AppPadding.pH10),
      margin: EdgeInsets.symmetric(vertical: AppMargin.mH4),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.border),
        borderRadius: BorderRadius.circular(AppCircular.r5),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: AppMargin.mW8,
        children: [
          AppAssets.svg.baseSvg.notifications.svg(
            width: AppSize.sW40,
            height: AppSize.sH40,
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: AppMargin.mH6,
              children: [
                Text(
                  notificationEntity.body,
                  style: const TextStyle().setMainTextColor.s11.regular,
                ),
                Text(
                  notificationEntity.createdAt,
                  style: const TextStyle()
                      .setColor(const Color(0xff7B7B7B))
                      .s10
                      .regular,
                ),
              ],
            ),
          ),
          BlocProvider(
            create: (context) =>
                DeleteNotificationCubit(context.read<NotificationsCubit>()),
            child: Builder(
              builder: (context) {
                return Skeleton.ignore(
                  child: AppAssets.svg.baseSvg.deleteAll
                      .svg(width: AppSize.sW25, height: AppSize.sH25)
                      .onClick(
                        onTap: () {
                          final cubit = context.read<DeleteNotificationCubit>();
                          deleteNotifications(
                            cubit: cubit,
                            title: LocaleKeys.deleteNotification,
                            onTap: () async => await cubit
                                .deleteOneNotification(notificationEntity),
                          );
                        },
                      ),
                );
              },
            ),
          ),
        ],
      ),
    ).onClick(
      onTap: () => NotificationRoutes.navigateByType(notificationEntity.toMap),
    );
  }
}
