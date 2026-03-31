part of '../imports/view_imports.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context.locale;
    return DefaultScaffold(
      header: HeaderConfig(title: LocaleKeys.settingsTitle),
      slivers: const [SliverToBoxAdapter(child: _SettingsTabBody())],
    );
  }
}
