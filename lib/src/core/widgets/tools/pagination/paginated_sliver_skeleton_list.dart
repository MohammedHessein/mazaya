part of 'imports/pagination_imports.dart';

class PaginatedSliverSkeletonList extends StatelessWidget {
  final PaginatedListConfig config;
  final Widget Function(BuildContext context) skeletonBuilder;
  final int skeletonItemCount;

  const PaginatedSliverSkeletonList({
    super.key,
    required this.config,
    required this.skeletonBuilder,
    required this.skeletonItemCount,
  });

  @override
  Widget build(BuildContext context) {
    if (config.viewType == ListViewType.grid) {
      return SliverGrid(
        gridDelegate:
            config.gridDelegate ??
            const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 1.0,
              crossAxisSpacing: 8.0,
              mainAxisSpacing: 8.0,
            ),
        delegate: SliverChildBuilderDelegate(
          (context, index) => skeletonBuilder(context),
          childCount: skeletonItemCount,
        ),
      );
    }
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) => skeletonBuilder(context),
        childCount: skeletonItemCount,
      ),
    );
  }
}
