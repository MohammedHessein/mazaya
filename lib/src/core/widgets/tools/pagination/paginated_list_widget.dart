part of 'imports/pagination_imports.dart';

/// A customizable paginated list widget with AsyncBlocBuilder
class PaginatedListWidget<C extends PaginatedCubit<T>, T>
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

  const PaginatedListWidget({
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
  State<PaginatedListWidget<C, T>> createState() =>
      _PaginatedListWidgetState<C, T>();
}

class _PaginatedListWidgetState<C extends PaginatedCubit<T>, T>
    extends State<PaginatedListWidget<C, T>> {
  late ScrollController _scrollController;
  late C _cubit;
  late PageStorageKey _pageStorageKey;

  @override
  void initState() {
    super.initState();
    _cubit = context.read<C>();
    _scrollController = widget.config.controller ?? ScrollController();
    _scrollController.addListener(_onScroll);
    // Create a unique key for scroll position storage
    _pageStorageKey = PageStorageKey<String>('paginated_list_${C.toString()}');
  }

  @override
  void dispose() {
    if (widget.config.controller == null) {
      _scrollController.dispose();
    }
    super.dispose();
  }

  void _onScroll() {
    if (!_scrollController.hasClients) return;

    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    final threshold = maxScroll * widget.loadMoreThreshold;

    if (currentScroll >= threshold && _cubit.canLoadMore) {
      _cubit.loadMore();
    }
  }

  Future<void> _onRefresh() async {
    await _cubit.refresh();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<C, AsyncState<PaginatedData<T>>>(
      builder: (context, state) {
        // Show shimmer only on initial load or loading (not on loadingMore)
        if ((state.status == BaseStatus.initial ||
                state.status == BaseStatus.loading) &&
            widget.skeletonBuilder != null) {
          return Skeletonizer(enabled: true, child: _buildSkeletonView());
        }

        // Show error state
        if (state.status == BaseStatus.error) {
          if (widget.errorBuilder != null) {
            return _wrapWithRefreshIndicator(
              widget.errorBuilder!(context, state.errorMessage ?? ''),
              needsScrollable: true,
            );
          }
          return _wrapWithRefreshIndicator(
            ErrorView(error: state.errorMessage ?? ''),
            needsScrollable: true,
          );
        }

        // Show empty state
        final data = state.data;
        if (data.items.isEmpty && state.status == BaseStatus.success) {
          return _wrapWithRefreshIndicator(
            widget.emptyWidget ?? const NotContainData(),
            needsScrollable: true,
          );
        }

        // Show list with data
        return _wrapWithRefreshIndicator(
          _buildListView(data, state.status == BaseStatus.loadingMore),
        );
      },
    );
  }

  Widget _wrapWithRefreshIndicator(
    Widget child, {
    bool needsScrollable = false,
  }) {
    if (!widget.config.enableRefresh) {
      return child;
    }

    // For non-scrollable content (empty/error states), wrap in a scrollable
    // to enable pull-to-refresh gesture
    final scrollableChild = needsScrollable
        ? CustomScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            slivers: [SliverFillRemaining(hasScrollBody: false, child: child)],
          )
        : child;

    return RefreshIndicator(
      onRefresh: _onRefresh,
      color: widget.config.refreshIndicatorColor,
      backgroundColor: widget.config.refreshIndicatorBackgroundColor,
      displacement: widget.config.refreshIndicatorDisplacement,
      child: scrollableChild,
    );
  }

  /// Builds skeleton view that matches the list/grid configuration
  Widget _buildSkeletonView() {
    if (widget.config.viewType == ListViewType.grid) {
      return GridView.builder(
        scrollDirection: widget.config.scrollDirection,
        physics: const NeverScrollableScrollPhysics(),
        padding: widget.config.padding,
        shrinkWrap: widget.config.shrinkWrap,
        reverse: widget.config.reverse,
        primary: widget.config.primary,
        gridDelegate:
            widget.config.gridDelegate ??
            const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 1.0,
              crossAxisSpacing: 8.0,
              mainAxisSpacing: 8.0,
            ),
        itemCount: widget.skeletonItemCount,
        itemBuilder: (context, index) {
          return widget.skeletonBuilder!(context);
        },
      );
    } else if (widget.config.useSeparator) {
      return ListView.separated(
        scrollDirection: widget.config.scrollDirection,
        physics: const NeverScrollableScrollPhysics(),
        padding: widget.config.padding,
        shrinkWrap: widget.config.shrinkWrap,
        reverse: widget.config.reverse,
        primary: widget.config.primary,
        itemCount: widget.skeletonItemCount,
        separatorBuilder: (context, index) {
          return widget.config.separator ?? const Divider();
        },
        itemBuilder: (context, index) {
          return widget.skeletonBuilder!(context);
        },
      );
    } else {
      return ListView.builder(
        scrollDirection: widget.config.scrollDirection,
        physics: const NeverScrollableScrollPhysics(),
        padding: widget.config.padding,
        shrinkWrap: widget.config.shrinkWrap,
        reverse: widget.config.reverse,
        primary: widget.config.primary,
        itemCount: widget.skeletonItemCount,
        itemBuilder: (context, index) {
          return widget.skeletonBuilder!(context);
        },
      );
    }
  }

  Widget _buildListView(PaginatedData<T> data, bool isLoadingMore) {
    // Add extra item for loading indicator only if loading more
    final itemCount = data.items.length + (isLoadingMore ? 1 : 0);
    if (widget.config.viewType == ListViewType.grid) {
      return _buildGridView(data, itemCount, isLoadingMore);
    } else if (widget.config.useSeparator) {
      return _buildSeparatedListView(data, itemCount, isLoadingMore);
    } else {
      return _buildRegularListView(data, itemCount, isLoadingMore);
    }
  }

  /// Returns the scroll physics, ensuring AlwaysScrollableScrollPhysics
  /// when refresh is enabled so pull-to-refresh works even with short lists
  ScrollPhysics? get _scrollPhysics {
    if (widget.config.enableRefresh) {
      return const AlwaysScrollableScrollPhysics();
    }
    return widget.config.physics;
  }

  Widget _buildRegularListView(
    PaginatedData<T> data,
    int itemCount,
    bool isLoadingMore,
  ) {
    return ListView.builder(
      key: _pageStorageKey,
      controller: _scrollController,
      scrollDirection: widget.config.scrollDirection,
      physics: _scrollPhysics,
      padding: widget.config.padding,
      shrinkWrap: widget.config.shrinkWrap,
      reverse: widget.config.reverse,
      primary: widget.config.primary,
      itemCount: itemCount,
      itemBuilder: (context, index) {
        if (index >= data.items.length) {
          return _buildLoadMoreIndicator();
        }
        return _buildItem(context, data.items[index], index);
      },
    );
  }

  Widget _buildSeparatedListView(
    PaginatedData<T> data,
    int itemCount,
    bool isLoadingMore,
  ) {
    return ListView.separated(
      key: _pageStorageKey,
      controller: _scrollController,
      scrollDirection: widget.config.scrollDirection,
      physics: _scrollPhysics,
      padding: widget.config.padding,
      shrinkWrap: widget.config.shrinkWrap,
      reverse: widget.config.reverse,
      primary: widget.config.primary,
      itemCount: itemCount,
      separatorBuilder: (context, index) {
        if (index >= data.items.length - 1) {
          return const SizedBox.shrink();
        }
        return widget.config.separator ?? const Divider();
      },
      itemBuilder: (context, index) {
        if (index >= data.items.length) {
          return _buildLoadMoreIndicator();
        }
        return _buildItem(context, data.items[index], index);
      },
    );
  }

  Widget _buildGridView(
    PaginatedData<T> data,
    int itemCount,
    bool isLoadingMore,
  ) {
    return GridView.builder(
      key: _pageStorageKey,
      controller: _scrollController,
      scrollDirection: widget.config.scrollDirection,
      physics: _scrollPhysics,
      padding: widget.config.padding,
      shrinkWrap: widget.config.shrinkWrap,
      reverse: widget.config.reverse,
      primary: widget.config.primary,
      gridDelegate:
          widget.config.gridDelegate ??
          const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 1.0,
            crossAxisSpacing: 8.0,
            mainAxisSpacing: 8.0,
          ),
      itemCount: itemCount,
      itemBuilder: (context, index) {
        if (index >= data.items.length) {
          return _buildLoadMoreIndicator();
        }
        return _buildItem(context, data.items[index], index);
      },
    );
  }

  Widget _buildItem(BuildContext context, T item, int index) {
    final itemWidget = widget.itemBuilder(context, item, index);

    if (widget.config.itemMargin != null) {
      return Padding(padding: widget.config.itemMargin!, child: itemWidget);
    }

    return itemWidget;
  }

  Widget _buildLoadMoreIndicator() {
    return widget.loadMoreIndicator ?? const Center(child: LoadingIndicator());
  }
}
