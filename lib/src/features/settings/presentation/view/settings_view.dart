part of '../imports/view_imports.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context.locale;
    return DefaultScaffold(
      title: LocaleKeys.settingsTitle,
      body: const _SettingsTabBody(),
    );
  }
}
