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
            header: HeaderConfig(
              title: LocaleKeys.notificationsTitle,
              showBackButton: false,
            ),
            slivers: const [NotificationBody()],
          );
        },
      ),
    );
  }
}
