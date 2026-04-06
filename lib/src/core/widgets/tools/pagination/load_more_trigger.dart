part of 'imports/pagination_imports.dart';

/// A hidden widget that triggers a callback when it is built/rendered.
/// Used at the end of lists to trigger pagination without fragile scroll listeners.
class LoadMoreTrigger extends StatefulWidget {
  final VoidCallback onLoadMore;
  const LoadMoreTrigger({required this.onLoadMore, super.key});

  @override
  State<LoadMoreTrigger> createState() => _LoadMoreTriggerState();
}

class _LoadMoreTriggerState extends State<LoadMoreTrigger> {
  @override
  void initState() {
    super.initState();
    // Trigger load more as soon as this widget is built (meaning it's near the viewport)
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        widget.onLoadMore();
      }
    });
  }

  @override
  Widget build(BuildContext context) => const SizedBox.shrink();
}
