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
        SliverPadding(
          padding: EdgeInsets.symmetric(horizontal: AppPadding.pW20),
          sliver: PaginatedSliverListWidget<UsedCouponsCubit, CouponEntity>(
            skeletonBuilder: (context) => AppCard(
              title: CouponEntity.initial().name,
              description: CouponEntity.initial().description ?? '',
            ),
            itemBuilder: (context, coupon, index) {
              return AppCard(
                title: coupon.name,
                description: coupon.description ?? '',
                status: coupon.categoryName ?? '',
                isFavorite: coupon.isFav,
                onFavoriteTap: () =>
                    context.read<UsedCouponsCubit>().toggleFavorite(coupon.id),
                onTap: () {},
              );
            },
          ),
        ),
      ],
    );
  }
}
