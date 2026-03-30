part of 'imports/pagination_imports.dart';

class PaginatedSliverListView<T> extends StatelessWidget {
  final List<T> items;
  final bool isLoadingMore;
  final Widget Function(BuildContext context, T item, int index) itemBuilder;
  final PaginatedListConfig config;
  final Widget? loadMoreIndicator;

  const PaginatedSliverListView({
    super.key,
    required this.items,
    required this.isLoadingMore,
    required this.itemBuilder,
    required this.config,
    this.loadMoreIndicator,
  });

  @override
  Widget build(BuildContext context) {
    final itemsCount = items.length;
    final totalCount = itemsCount + (isLoadingMore ? 1 : 0);

    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          if (index >= itemsCount) {
            return LoadMoreIndicatorSliver(indicator: loadMoreIndicator);
          }
          final itemWidget = itemBuilder(context, items[index], index);

          if (config.itemMargin != null) {
            return Padding(padding: config.itemMargin!, child: itemWidget);
          }
          return itemWidget;
        },
        childCount: totalCount,
      ),
    );
  }
}
