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
import '../cubits/home_cubit.dart';
import '../../model/home_model.dart';

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
              Text(
                LocaleKeys.latestCoupons,
                style: context.textStyle.s16.bold.setBlackColor,
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
              return ListView.builder(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: products.length,
                itemBuilder: (context, index) {
                  final product = products[index];
                  return AppCard(
                    title: product.name,
                    description: product.shortDescription ?? '',
                    imageUrl: product.productImage,
                    status: null,
                    isFavorite: product.isFav,
                    onFavoriteTap: () {
                      context.read<HomeCubit>().toggleFavorite(product.id);
                    },
                    onTap: () {},
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
