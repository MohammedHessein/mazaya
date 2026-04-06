part of 'imports/pagination_imports.dart';

class LoadMoreIndicatorSliver extends StatefulWidget {
  final Widget? indicator;
  final VoidCallback onLoadMore;

  const LoadMoreIndicatorSliver({
    super.key,
    this.indicator,
    required this.onLoadMore,
  });

  @override
  State<LoadMoreIndicatorSliver> createState() => _LoadMoreIndicatorSliverState();
}

class _LoadMoreIndicatorSliverState extends State<LoadMoreIndicatorSliver> {
  @override
  void initState() {
    super.initState();
    // Trigger load more as soon as this indicator is built/shown at the end of the sliver
    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.onLoadMore();
    });
  }

  @override
  Widget build(BuildContext context) {
    return widget.indicator ?? const Center(child: LoadingIndicator());
  }
}
