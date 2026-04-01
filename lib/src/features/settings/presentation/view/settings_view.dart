part of '../imports/view_imports.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context.locale;
    return BlocProvider(
      create: (context) => injector<UpdatePhotoCubit>(),
      child: DefaultScaffold(
        header: HeaderConfig(
          title: LocaleKeys.settingsTitle,
          type: ScaffoldHeaderType.profile,
          overlayWidget: const ProfileAvatarWidget(),
        ),
        slivers: const [SliverToBoxAdapter(child: _SettingsTabBody())],
      ),
    );
  }
}
