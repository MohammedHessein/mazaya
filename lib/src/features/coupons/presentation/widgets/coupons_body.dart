import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mazaya/src/config/language/locale_keys.g.dart';
import 'package:mazaya/src/config/res/config_imports.dart';
import 'package:mazaya/src/core/base_crud/code/domain/base_domain_imports.dart';
import 'package:mazaya/src/core/base_crud/code/presentation/cubit/get_base_name_and_id/get_base_name_and_id_cubit.dart';
import 'package:mazaya/src/core/extensions/widgets/sized_box_helper.dart';
import 'package:mazaya/src/core/widgets/cards/app_card.dart';
import 'package:mazaya/src/core/widgets/handling_views/empty_widget.dart';
import 'package:mazaya/src/core/widgets/pickers/default_bottom_sheet.dart';
import 'package:mazaya/src/core/widgets/tools/pagination/imports/pagination_imports.dart';
import 'package:mazaya/src/features/coupons/entity/coupon_entity.dart';
import 'package:mazaya/src/features/coupons/presentation/cubits/coupons_cubit.dart';
import 'package:mazaya/src/features/coupons/presentation/widgets/coupons_filter_bottom_sheet.dart';
import 'package:mazaya/src/features/coupons/presentation/widgets/coupons_search_bar.dart';

class CouponsBody extends StatelessWidget {
  const CouponsBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: EdgeInsets.symmetric(horizontal: AppPadding.pW20),
      sliver: SliverMainAxisGroup(
        slivers: [
          SliverToBoxAdapter(
            child: CouponsSearchBar(
              onFilterTap: () {
                showDefaultBottomSheet(
                  context: context,
                  child: MultiBlocProvider(
                    providers: [
                      BlocProvider.value(
                        value: context.read<GetBaseEntityCubit<CityEntity>>(),
                      ),
                      BlocProvider.value(
                        value: context
                            .read<GetBaseEntityCubit<CategoryEntity>>(),
                      ),
                      BlocProvider.value(value: context.read<CouponsCubit>()),
                    ],
                    child: const CouponsFilterBottomSheet(),
                  ),
                );
              },
              onChanged: (query) {
                context.read<CouponsCubit>().fetchInitialData(
                  key: query.isEmpty ? null : query,
                );
              },
            ),
          ),
          SliverToBoxAdapter(child: 20.szH),
          PaginatedSliverListWidget<CouponsCubit, CouponEntity>(
            skeletonItemCount: 10,
            config: const PaginatedListConfig(),
            skeletonBuilder: (context) => AppCard(
              title: CouponEntity.initial().name,
              description: CouponEntity.initial().description ?? '',
            ),
            itemBuilder: (context, item, index) => AppCard(
              title: item.name,
              description: item.description ?? '',
              imageUrl: item.productImage,
              status: item.categoryName, // Using categoryName as status for now
              isFavorite: item.isFav,
              onTap: () {
                // Handle coupon tap
              },
              onFavoriteTap: () {
                context.read<CouponsCubit>().toggleFavorite(item.id);
              },
            ),
            emptyWidget: EmptyWidget(
              title: LocaleKeys.noCouponsTitle,
              desc: LocaleKeys.noCouponsDesc,
            ),
          ),
          SliverToBoxAdapter(child: 40.szH), // Bottom spacing for FAB/Nav
        ],
      ),
    );
  }
}
