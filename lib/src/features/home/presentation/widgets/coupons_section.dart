import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mazaya/src/config/language/locale_keys.g.dart';
import 'package:mazaya/src/config/res/config_imports.dart';
import 'package:mazaya/src/core/extensions/context_extension.dart';
import 'package:mazaya/src/core/extensions/text_style_extensions.dart';
import 'package:mazaya/src/core/widgets/cards/app_card.dart';
import 'package:mazaya/src/core/widgets/tools/bloc_builder/async_bloc_builder.dart';
import 'package:mazaya/src/core/navigation/navigator.dart';
import 'package:mazaya/src/features/coupons/presentation/view/coupons_view.dart';
import 'package:mazaya/src/features/coupons/presentation/view/coupon_details_screen.dart';
import 'package:mazaya/src/core/utils/favorite_manager.dart';
import '../cubits/home_cubit.dart';
import '../../model/home_model.dart';
import 'package:mazaya/src/core/shared/cubits/user_cubit/user_cubit.dart';

class CouponsSection extends StatefulWidget {
  const CouponsSection({super.key});

  @override
  State<CouponsSection> createState() => _CouponsSectionState();
}

class _CouponsSectionState extends State<CouponsSection> {

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppPadding.pW20),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  LocaleKeys.latestCoupons,
                  style: context.textStyle.s16.bold.setBlackColor,
                ),
              ),
              TextButton(
                onPressed: () {
                  Go.to(const CouponsView());
                },
                child: Text(
                  LocaleKeys.showMore,
                  style: context.textStyle.s14.regular.setHintColor,
                ),
              ),
            ],
          ),
          AsyncBlocBuilder<HomeCubit, HomeModel?>(
            skeletonBuilder: (context) => ListView.builder(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 4,
              itemBuilder: (context, index) => const AppCard(
                title: 'Loading...',
                description: 'Loading description...',
                status: null,
              ),
            ),
            builder: (context, home) {
              final products = home?.products ?? [];
              return BlocBuilder<UserCubit, UserState>(
                builder: (context, userState) {
                  final user = userState.userModel;
                  return ListView.builder(
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: products.length,
                    itemBuilder: (context, index) {
                      final product = products[index];
                      final isDisabled = !product.isActive;

                      return AppCard(
                        title: product.vendorName ?? product.name,
                        description: product.name,
                        imageUrl: product.productImage,
                        status: null,
                        isFavorite: product.isFav,
                        packageNames: product.packageNames,
                        isDisabled: isDisabled,
                        onFavoriteTap: () {
                          context.read<FavoriteManager>().toggle(
                                id: product.id,
                                coupon: product.toCouponEntity(),
                              );
                        },
                        onTap: () {
                          Go.to(CouponDetailsScreen(
                              id: product.id,
                              coupon: product.toCouponEntity()));
                        },
                      );
                    },
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
