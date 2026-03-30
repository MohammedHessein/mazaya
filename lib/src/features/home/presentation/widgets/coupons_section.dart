import 'package:flutter/material.dart';
import 'package:mazaya/src/config/language/locale_keys.g.dart';
import 'package:mazaya/src/config/res/config_imports.dart';
import 'package:mazaya/src/core/extensions/context_extension.dart';
import 'package:mazaya/src/core/extensions/text_style_extensions.dart';
import 'package:mazaya/src/core/widgets/cards/app_card.dart';

class CouponsSection extends StatefulWidget {
  const CouponsSection({super.key});

  @override
  State<CouponsSection> createState() => _CouponsSectionState();
}

class _CouponsSectionState extends State<CouponsSection> {
  final Set<int> _favorites = {1};

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
                onPressed: () {},
                child: Text(
                  LocaleKeys.showMore,
                  style: context.textStyle.s14.regular.setHintColor,
                ),
              ),
            ],
          ),
          ListView.builder(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 4,
            itemBuilder: (context, index) {
              final isFavorite = _favorites.contains(index);
              return AppCard(
                title: 'ملابس زارا',
                description: 'خصم 25% علي جميع المنتجات',
                status: null,
                isFavorite: isFavorite,
                onFavoriteTap: () {
                  setState(() {
                    if (isFavorite) {
                      _favorites.remove(index);
                    } else {
                      _favorites.add(index);
                    }
                  });
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
