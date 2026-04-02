import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mazaya/src/config/language/locale_keys.g.dart';
import 'package:mazaya/src/config/res/config_imports.dart';
import 'package:mazaya/src/core/base_crud/code/domain/base_domain_imports.dart';
import 'package:mazaya/src/core/base_crud/code/presentation/cubit/get_base_name_and_id/get_base_name_and_id_cubit.dart';
import 'package:mazaya/src/core/extensions/widgets/sized_box_helper.dart';
import 'package:mazaya/src/core/helpers/debouncer.dart';
import 'package:mazaya/src/core/widgets/cards/app_card.dart';
import 'package:mazaya/src/core/widgets/handling_views/empty_widget.dart';
import 'package:mazaya/src/core/widgets/pickers/default_bottom_sheet.dart';
import 'package:mazaya/src/core/widgets/tools/pagination/imports/pagination_imports.dart';
import 'package:mazaya/src/features/coupons/entity/coupon_entity.dart';
import 'package:mazaya/src/features/coupons/presentation/cubits/coupons_cubit.dart';
import 'package:mazaya/src/features/coupons/presentation/widgets/coupons_filter_bottom_sheet.dart';
import 'package:mazaya/src/features/coupons/presentation/widgets/coupons_search_bar.dart';
import 'package:mazaya/src/features/coupons/presentation/view/coupon_details_screen.dart';
import 'package:mazaya/src/core/navigation/navigator.dart';

class CouponsBody extends StatefulWidget {
  const CouponsBody({super.key});

  @override
  State<CouponsBody> createState() => _CouponsBodyState();
}

class _CouponsBodyState extends State<CouponsBody> {
  final _debouncer = Debouncer(delay: const Duration(milliseconds: 700));

  @override
  void dispose() {
    _debouncer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: EdgeInsets.symmetric(horizontal: AppPadding.pW20),
      sliver: SliverMainAxisGroup(
        slivers: [
          SliverToBoxAdapter(
            child: Builder(builder: (searchContext) {
              return CouponsSearchBar(
                onFilterTap: () {
                  showDefaultBottomSheet(
                    context: searchContext,
                    child: MultiBlocProvider(
                      providers: [
                        BlocProvider.value(
                          value: searchContext
                              .read<GetBaseEntityCubit<RegionEntity>>(),
                        ),
                        BlocProvider.value(
                          value: searchContext
                              .read<GetBaseEntityCubit<CategoryEntity>>(),
                        ),
                        BlocProvider.value(
                            value: searchContext.read<CouponsCubit>()),
                      ],
                      child: const CouponsFilterBottomSheet(),
                    ),
                  );
                },
                onChanged: (query) {
                  _debouncer.run(() {
                    context.read<CouponsCubit>().fetchInitialData(
                          key: query.isEmpty ? null : query,
                        );
                  });
                },
              );
            }),
          ),
          SliverToBoxAdapter(child: 20.szH),
          PaginatedSliverListWidget<CouponsCubit, CouponEntity>(
            skeletonItemCount: 10,
            config: const PaginatedListConfig(),
            skeletonBuilder: (context) => AppCard(
              title: CouponEntity.empty().name,
              description: CouponEntity.empty().shortDescription ?? '',
            ),
            itemBuilder: (context, item, index) => AppCard(
              title: item.name,
              description: item.shortDescription ?? '',
              imageUrl: item.productImage,
              isFavorite: item.isFav,
              onTap: () {
                Go.to(CouponDetailsScreen(id: item.id, coupon: item));
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
