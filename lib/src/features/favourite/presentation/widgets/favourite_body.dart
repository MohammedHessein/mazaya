part of '../imports/view_imports.dart';

class FavouriteBody extends StatelessWidget {
  const FavouriteBody({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultScaffold(
      title: LocaleKeys.favourite,
      body: PaginatedListWidget<FavouriteCubit, CouponEntity>(
        config: PaginatedListConfig(
          padding: EdgeInsets.symmetric(horizontal: AppPadding.pW20),
        ),
        skeletonBuilder: (context) => AppCard(
          title: CouponEntity.initial().title,
          description: CouponEntity.initial().description,
        ),
        itemBuilder: (context, coupon, index) {
          return AppCard(
            title: coupon.title,
            description: coupon.description,
            isFavorite: coupon.isFavorite,
            onFavoriteTap: () =>
                context.read<FavouriteCubit>().toggleFavorite(coupon.id),
            onTap: () {},
          );
        },
      ),
    );
  }
}
