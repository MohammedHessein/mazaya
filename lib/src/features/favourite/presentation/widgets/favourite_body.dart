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
          sliver: PaginatedSliverListWidget<FavouriteCubit, CouponEntity>(
            skeletonBuilder: (context) => AppCard(
              title: CouponEntity.empty().name,
              description: CouponEntity.empty().description ?? '',
            ),
            itemBuilder: (context, coupon, index) {
              return AppCard(
                title: coupon.name,
                description: coupon.description ?? '',
                isFavorite: coupon.isFav,
                onFavoriteTap: () => context.read<FavoriteManager>().toggle(
                  id: coupon.id,
                  coupon: coupon,
                ),
                onTap: () {
                  Go.to(CouponDetailsScreen(id: coupon.id));
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
