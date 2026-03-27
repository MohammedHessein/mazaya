part of '../imports/view_imports.dart';

class _MainBody extends StatelessWidget {
  final int index;
  const _MainBody(this.index);

  @override
  Widget build(BuildContext context) {
    switch (index) {
      case 0:
        return const HomeScreen();
      case 1:
        return const SizedBox.shrink();
      case 2:
        return const SizedBox.shrink();
      case 3:
        return const MoreTabView();

      default:
        return const SizedBox.shrink();
    }
  }
}
