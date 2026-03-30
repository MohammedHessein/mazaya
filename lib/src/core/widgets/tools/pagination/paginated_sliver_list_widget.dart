part of 'imports/pagination_imports.dart';

/// A customizable paginated sliver list widget with AsyncBlocBuilder
class PaginatedSliverListWidget<C extends PaginatedCubit<T>, T>
    extends StatefulWidget {
  /// Item builder for each item in the list
  final Widget Function(BuildContext context, T item, int index) itemBuilder;

  /// Configuration for the list view
  final PaginatedListConfig config;

  /// Skeleton builder for loading state
  final Widget Function(BuildContext context)? skeletonBuilder;

  /// Error builder for error state
  final Widget Function(BuildContext context, String error)? errorBuilder;

  /// Empty state widget when no items
  final Widget? emptyWidget;

  /// Loading indicator for load more
  final Widget? loadMoreIndicator;

  /// Threshold for triggering load more (0.0 to 1.0)
  /// 0.8 means load more when scrolled 80% of the list
  final double loadMoreThreshold;

  /// Number of skeleton items to show during loading
  final int skeletonItemCount;

  const PaginatedSliverListWidget({
    super.key,
    required this.itemBuilder,
    this.config = const PaginatedListConfig(),
    this.skeletonBuilder,
    this.errorBuilder,
    this.emptyWidget,
    this.loadMoreIndicator,
    this.loadMoreThreshold = 0.8,
    this.skeletonItemCount = 6,
  });

  @override
  State<PaginatedSliverListWidget<C, T>> createState() =>
      _PaginatedSliverListWidgetState<C, T>();
}

class _PaginatedSliverListWidgetState<C extends PaginatedCubit<T>, T>
    extends State<PaginatedSliverListWidget<C, T>> {
  late C _cubit;

  @override
  void initState() {
    super.initState();
    _cubit = context.read<C>();
  }

  void _onScrollNotification(ScrollNotification notification) {
    if (notification is ScrollUpdateNotification) {
      final metrics = notification.metrics;
      final maxScroll = metrics.maxScrollExtent;
      final currentScroll = metrics.pixels;
      final threshold = maxScroll * widget.loadMoreThreshold;

      if (currentScroll >= threshold && _cubit.canLoadMore) {
        _cubit.loadMore();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
      onNotification: (notification) {
        _onScrollNotification(notification);
        return false;
      },
      child: BlocBuilder<C, AsyncState<PaginatedData<T>>>(
        builder: (context, state) {
          // Show shimmer only on initial load or loading (not on loadingMore)
          if ((state.status == BaseStatus.initial ||
                  state.status == BaseStatus.loading) &&
              widget.skeletonBuilder != null) {
            return Skeletonizer.sliver(
              enabled: true,
              child: PaginatedSliverSkeletonList(
                config: widget.config,
                skeletonBuilder: widget.skeletonBuilder!,
                skeletonItemCount: widget.skeletonItemCount,
              ),
            );
          }

          // Show error state
          if (state.status == BaseStatus.error) {
            return SliverToBoxAdapter(
              child: widget.errorBuilder?.call(context, state.errorMessage ?? '') ??
                  ErrorView(error: state.errorMessage ?? ''),
            );
          }

          // Show empty state
          final data = state.data;
          if (data.items.isEmpty && state.status == BaseStatus.success) {
            return SliverToBoxAdapter(
              child: widget.emptyWidget ?? const NotContainData(),
            );
          }

          // Show list/grid with data
          if (widget.config.viewType == ListViewType.grid) {
            return PaginatedSliverGridView<T>(
              items: data.items,
              isLoadingMore: state.status == BaseStatus.loadingMore,
              itemBuilder: widget.itemBuilder,
              config: widget.config,
              loadMoreIndicator: widget.loadMoreIndicator,
            );
          } else {
            return PaginatedSliverListView<T>(
              items: data.items,
              isLoadingMore: state.status == BaseStatus.loadingMore,
              itemBuilder: widget.itemBuilder,
              config: widget.config,
              loadMoreIndicator: widget.loadMoreIndicator,
            );
          }
        },
      ),
    );
  }
}
