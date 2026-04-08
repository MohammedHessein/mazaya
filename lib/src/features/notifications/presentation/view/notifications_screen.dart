part of '../imports/view_imports.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              injector<NotificationsCubit>()..fetchInitialData(),
        ),
        BlocProvider(
          create: (context) => injector<ReadAllNotificationsCubit>(),
        ),
        BlocProvider(create: (context) => injector<ReadNotificationCubit>()),
      ],
      child: Builder(
        builder: (context) {
          return DefaultScaffold(
            header: HeaderConfig(
              title: LocaleKeys.notificationsTitle,
              showBackButton: false,
              trailing: ReadAllButton(),
            ),
            slivers: const [NotificationBody()],
          );
        },
      ),
    );
  }
}

class ReadAllButton extends StatelessWidget {
  const ReadAllButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<ReadAllNotificationsCubit, AsyncState<String>>(
      listener: (context, state) {
        if (state.status == BaseStatus.success) {
          // Refresh the notifications list after marking all as read
          context.read<NotificationsCubit>().fetchInitialData();
        }
      },
      child: GestureDetector(
        onTap: () {
          context.read<ReadAllNotificationsCubit>().readAll();
        },
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.w),
          child: Text(
            LocaleKeys.readAll,
            style: context.textStyle.s14.medium.setWhiteColor,
          ),
        ),
      ),
    );
  }
}
