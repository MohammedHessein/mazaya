part of '../imports/view_imports.dart';

class StaticPagesBody extends StatelessWidget {
  final StaticPageTypeEnum pageType;

  const StaticPagesBody({super.key, required this.pageType});

  Future<void> _onRefresh(BuildContext context) async {
    await context.read<StaticPagesCubit>().fetchStaticPage(pageType);
  }

  @override
  Widget build(BuildContext context) {
    return AsyncBlocBuilder<StaticPagesCubit, String?>(
      skeletonBuilder: (context) {
        return SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal: AppPadding.pH16,
            vertical: AppPadding.pH20,
          ),
          child: const Text(
            '${SkeltonizerManager.veryLong} \n\n ${SkeltonizerManager.veryLong} \n\n ${SkeltonizerManager.veryLong}',
          ),
        );
      },
      builder: (context, data) {
        return RefreshIndicator(
          onRefresh: () => _onRefresh(context),
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: EdgeInsets.symmetric(
              horizontal: AppPadding.pH16,
              vertical: AppPadding.pH20,
            ),
            child: CustomHtmlWidget(data: data ?? ''),
          ),
        );
      },
    );
  }
}
