part of 'imports/pagination_imports.dart';

class LoadMoreIndicatorSliver extends StatelessWidget {
  final Widget? indicator;

  const LoadMoreIndicatorSliver({super.key, this.indicator});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: indicator ?? const Center(child: LoadingIndicator()),
    );
  }
}
