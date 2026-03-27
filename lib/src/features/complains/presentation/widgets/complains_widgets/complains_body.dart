part of '../../imports/view_imports.dart';

class _ComplainsBody extends StatelessWidget {
  const _ComplainsBody();

  Future<void> _onRefresh(BuildContext context) async {
    await context.read<ComplainsCubit>().fetchComplains();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      spacing: AppMargin.mH6,
      children: [
        Expanded(
          child: AsyncBlocBuilder<ComplainsCubit, List<ComplainEntity>>(
            builder: (context, data) {
              if (data.isEmpty) {
                return RefreshIndicator(
                  onRefresh: () => _onRefresh(context),
                  child: CustomScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    slivers: [
                      SliverFillRemaining(
                        hasScrollBody: false,
                        child: EmptyWidget(
                          path: AppAssets.svg.baseSvg.complainEmpty.path,
                          desc: LocaleKeys.errorexceptionNotcontaindesc,
                          title: LocaleKeys.noItemsFound,
                        ),
                      ),
                    ],
                  ),
                );
              } else {
                return RefreshIndicator(
                  onRefresh: () => _onRefresh(context),
                  child: ListView.builder(
                    physics: const AlwaysScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      return _ComplainCardWidget(data[index]);
                    },
                  ),
                );
              }
            },
            skeletonBuilder: (context) {
              return ListView.builder(
                shrinkWrap: true,
                itemCount: 8,
                itemBuilder: (context, index) {
                  return _ComplainCardWidget(ComplainEntity.initial());
                },
              );
            },
          ),
        ),
        LoadingButton(
          title: LocaleKeys.complaintsAddBtn,
          onTap: () async => Go.to(
            BlocProvider.value(
              value: context.read<ComplainsCubit>(),
              child: const AddComplainScreen(),
            ),
          ),
        ),
      ],
    ).paddingAll(AppPadding.pH14);
  }
}
