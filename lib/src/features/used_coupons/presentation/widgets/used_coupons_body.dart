part of '../imports/view_imports.dart';

class UsedCouponsBody extends StatelessWidget {
  const UsedCouponsBody({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultScaffold(
      title: LocaleKeys.usedCoupons,
      body: PaginatedListWidget<UsedCouponsCubit, CouponEntity>(
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
            status: coupon.status ?? '',
            isFavorite: false,
            onFavoriteTap: null,
            onTap: () {},
          );
        },
      ),
    );
  }
}
