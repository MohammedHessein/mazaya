part of 'imports/pagination_imports.dart';

class PaginatedSliverGridView<T> extends StatelessWidget {
  final List<T> items;
  final bool isLoadingMore;
  final Widget Function(BuildContext context, T item, int index) itemBuilder;
  final PaginatedListConfig config;
  final Widget? loadMoreIndicator;

  const PaginatedSliverGridView({
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

    return SliverGrid(
      gridDelegate:
          config.gridDelegate ??
          const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 1.0,
            crossAxisSpacing: 8.0,
            mainAxisSpacing: 8.0,
          ),
      delegate: SliverChildBuilderDelegate((context, index) {
        if (index >= itemsCount) {
          return LoadMoreIndicatorSliver(indicator: loadMoreIndicator);
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
