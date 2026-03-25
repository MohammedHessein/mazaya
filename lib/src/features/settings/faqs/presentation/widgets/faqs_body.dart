part of '../imports/view_imports.dart';

class _FaqsBody extends StatelessWidget {
  const _FaqsBody();

  Future<void> _onRefresh(BuildContext context) async {
    await context.read<FaqsCubit>().fetchFaqs();
  }

  @override
  Widget build(BuildContext context) {
    return AsyncBlocBuilder<FaqsCubit, List<FaqEntity>>(
      skeletonBuilder: (context) {
        return _FaqsBuilder(
          itemCount: 10,
          itemBuilder: (context, index) {
            return _FaqCardWidget(faqEntity: FaqEntity.initial());
          },
        );
      },
      builder: (context, data) {
        return RefreshIndicator(
          onRefresh: () => _onRefresh(context),
          child: _FaqsBuilder(
            itemCount: data.length,
            itemBuilder: (context, index) {
              final faq = data[index];
              return _FaqCardWidget(faqEntity: faq);
            },
          ),
        );
      },
    );
  }
}

class _FaqsBuilder extends StatelessWidget {
  final Widget? Function(BuildContext, int) itemBuilder;
  final int itemCount;
  const _FaqsBuilder({required this.itemCount, required this.itemBuilder});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      physics: const AlwaysScrollableScrollPhysics(),
      padding: EdgeInsets.symmetric(
        vertical: AppPadding.pH16,
        horizontal: AppPadding.pW14,
      ),
      itemCount: itemCount,
      separatorBuilder: (context, index) =>
          Divider(color: AppColors.border, height: AppSize.sH1),
      itemBuilder: itemBuilder,
    );
  }
}
