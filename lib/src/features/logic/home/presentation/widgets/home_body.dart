part of '../imports/view_imports.dart';

class _HomeBody extends StatelessWidget {
  final int index;
  const _HomeBody(this.index);

  @override
  Widget build(BuildContext context) {
    switch (index) {
      case 0:
        return const SizedBox.shrink();
      case 1:
        return const SizedBox.shrink();
      case 2:
        return const SizedBox.shrink();
      case 3:
        return const SizedBox.shrink();
      case 4:
        return const MoreTabView();

      default:
        return const SizedBox.shrink();
    }
  }
}
