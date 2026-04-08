part of '../imports/view_imports.dart';

class FavouriteBody extends StatelessWidget {
  const FavouriteBody({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultScaffold(
      header: HeaderConfig(title: LocaleKeys.favourite, showBackButton: false),
      slivers: [
        SliverPadding(
          padding: EdgeInsets.symmetric(
            horizontal: AppPadding.pW20,
            vertical: AppPadding.pH16,
          ),
          sliver: BlocBuilder<UserCubit, UserState>(
            builder: (context, userState) {
              final user = userState.userModel;
              return PaginatedSliverListWidget<FavouriteCubit, CouponEntity>(
                skeletonBuilder: (context) => AppCard(
                  title: CouponEntity.empty().name,
                  description: CouponEntity.empty().description ?? '',
                ),
                itemBuilder: (context, coupon, index) {
                  final isDisabled = coupon.packageName != null &&
                      user.userPackageName != null &&
                      coupon.packageName != user.userPackageName;
                  return AppCard(
                    title: coupon.vendorName ?? coupon.name,
                    description: coupon.name,
                    imageUrl: coupon.productImage,
                    isFavorite: coupon.isFav,
                    packageName: coupon.packageName,
                    isDisabled: isDisabled,
                    onFavoriteTap: () => context.read<FavoriteManager>().toggle(
                          id: coupon.id,
                          coupon: coupon,
                        ),
                    onTap: () {
                      Go.to(CouponDetailsScreen(id: coupon.id, coupon: coupon));
                    },
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
