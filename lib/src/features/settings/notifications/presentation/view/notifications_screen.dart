part of '../imports/view_imports.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => injector<NotificationsCubit>()..fetchInitialData(),
      child: Builder(
        builder: (context) {
          return DefaultScaffold(
            title: LocaleKeys.notificationsTitle,
            body: const _NotificationBody(),
            trailing: BlocBuilder<NotificationsCubit, AsyncState<PaginatedData<NotificationEntity>>>(
              builder: (context, state) {
                if (state.data.items.isEmpty) {
                  return const SizedBox.shrink();
                }
                return BlocProvider(
                  create: (context) =>
                      DeleteNotificationCubit(context.read<NotificationsCubit>()),
                  child: Builder(
                    builder: (context) {
                      return AppAssets.svg.baseSvg.deleteAll
                          .svg(width: AppSize.sW30, height: AppSize.sH30)
                          .onClick(
                            onTap: () async {
                              final cubit =
                                  context.read<DeleteNotificationCubit>();
                              deleteNotifications(
                                cubit: cubit,
                                title: LocaleKeys.notificationsClearAll,
                                onTap: () async =>
                                    await cubit.deleteAllNotifications(),
                              );
                            },
                          );
                    },
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

 
