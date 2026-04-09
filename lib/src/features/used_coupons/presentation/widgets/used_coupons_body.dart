part of '../imports/view_imports.dart';

class UsedCouponsBody extends StatelessWidget {
  const UsedCouponsBody({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultScaffold(
      header: HeaderConfig(
        title: LocaleKeys.usedCoupons,
        showBackButton: false,
      ),
      slivers: [
        BlocBuilder<UsedCouponsCubit, AsyncState<List<CouponEntity>>>(
          builder: (context, state) {
            final items = (state.isLoading && state.data.isEmpty)
                ? List.generate(5, (index) => const CouponEntity.empty())
                : state.data;

            if (!state.isLoading && items.isEmpty) {
              return SliverFillRemaining(
                child: Center(child: Text(LocaleKeys.noItemsFound)),
              );
            }

            return SliverPadding(
              padding: EdgeInsets.symmetric(
                horizontal: AppPadding.pW20,
                vertical: AppPadding.pH16,
              ),
              sliver: BlocBuilder<UserCubit, UserState>(
                builder: (context, userState) {
                  final user = userState.userModel;
                  return Skeletonizer.sliver(
                    enabled: state.isLoading && state.data.isEmpty,
                    child: SliverList(
                      delegate: SliverChildBuilderDelegate((context, index) {
                        final coupon = items[index];
                        final isDisabled = !coupon.isActive;
                        return AppCard(
                          title: coupon.vendorName ?? coupon.name,
                          description: coupon.name,
                          imageUrl: coupon.productImage,
                          isFavorite: coupon.isFav,
                          packageNames: coupon.packageNames,
                          isDisabled: isDisabled,
                          onFavoriteTap: () => context
                              .read<FavoriteManager>()
                              .toggle(id: coupon.id, coupon: coupon),
                          onTap: () {
                            Go.to(CouponDetailsScreen(
                                id: coupon.id, coupon: coupon));
                          },
                        );
                      }, childCount: items.length),
                    ),
                  );
                },
              ),
            );
          },
        ),
      ],
    );
  }
}
