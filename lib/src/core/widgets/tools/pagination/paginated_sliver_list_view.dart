part of 'imports/pagination_imports.dart';

class PaginatedSliverListView<T> extends StatelessWidget {
  final List<T> items;
  final bool isLoadingMore;
  final bool hasMorePages;
  final VoidCallback onLoadMore;
  final Widget Function(BuildContext context, T item, int index) itemBuilder;
  final PaginatedListConfig config;
  final Widget? loadMoreIndicator;

  const PaginatedSliverListView({
    super.key,
    required this.items,
    required this.isLoadingMore,
    required this.hasMorePages,
    required this.onLoadMore,
    required this.itemBuilder,
    required this.config,
    this.loadMoreIndicator,
  });

  @override
  Widget build(BuildContext context) {
    final itemsCount = items.length;
    final totalCount = itemsCount + (hasMorePages || isLoadingMore ? 1 : 0);

    return SliverList(
      delegate: SliverChildBuilderDelegate((context, index) {
        if (index >= itemsCount) {
          return LoadMoreIndicatorSliver(
            indicator: loadMoreIndicator,
            onLoadMore: onLoadMore,
          );
        }
        final itemWidget = itemBuilder(context, items[index], index);

        if (config.itemMargin != null) {
          return Padding(padding: config.itemMargin!, child: itemWidget);
        }
        return itemWidget;
      }, childCount: totalCount),
    );
  }
}
