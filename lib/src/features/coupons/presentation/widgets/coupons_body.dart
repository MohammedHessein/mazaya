import 'package:flutter/material.dart';
import 'package:mazaya/src/core/base_crud/code/domain/base_domain_imports.dart';
import 'package:mazaya/src/core/base_crud/code/presentation/cubit/get_base_name_and_id/get_base_name_and_id_cubit.dart';
import 'package:mazaya/src/core/helpers/debouncer.dart';
import 'package:mazaya/src/core/widgets/cards/app_card.dart';
import 'package:mazaya/src/core/widgets/handling_views/empty_widget.dart';
import 'package:mazaya/src/core/widgets/pickers/default_bottom_sheet.dart';
import 'package:mazaya/src/core/widgets/tools/pagination/imports/pagination_imports.dart';
import 'package:mazaya/src/features/coupons/presentation/cubits/coupons_cubit.dart';
import 'package:mazaya/src/features/coupons/presentation/widgets/coupons_filter_bottom_sheet.dart';
import 'package:mazaya/src/features/coupons/presentation/widgets/coupons_filter_chips.dart';
import 'package:mazaya/src/features/coupons/presentation/widgets/coupons_search_bar.dart';
import '../view/view_imports.dart';

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
      padding: EdgeInsets.symmetric(
        horizontal: AppPadding.pW20,
        vertical: AppPadding.pH16,
      ),
      sliver: SliverMainAxisGroup(
        slivers: [
          SliverToBoxAdapter(
            child: Builder(
              builder: (searchContext) {
                return Column(
                  children: [
                    CouponsSearchBar(
                      onFilterTap: () {
                        showDefaultBottomSheet(
                          context: searchContext,
                          child: MultiBlocProvider(
                            providers: [
                              BlocProvider.value(
                                value: searchContext
                                    .read<GetBaseEntityCubit<CountryEntity>>(),
                              ),
                              BlocProvider.value(
                                value: searchContext
                                    .read<GetBaseEntityCubit<CityEntity>>(),
                              ),
                              BlocProvider.value(
                                value: searchContext
                                    .read<GetBaseEntityCubit<RegionEntity>>(),
                              ),
                              BlocProvider.value(
                                value: searchContext
                                    .read<GetBaseEntityCubit<CategoryEntity>>(),
                              ),
                              BlocProvider.value(
                                value: searchContext.read<CouponsCubit>(),
                              ),
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
                    ),
                    12.szH,
                    const CouponsFilterChips(),
                  ],
                );
              },
            ),
          ),
          SliverToBoxAdapter(child: 20.szH),
          BlocBuilder<UserCubit, UserState>(
            builder: (context, userState) {
              final user = userState.userModel;
              return PaginatedSliverListWidget<CouponsCubit, CouponEntity>(
                skeletonItemCount: 10,
                config: const PaginatedListConfig(),
                skeletonBuilder: (context) => AppCard(
                  title: CouponEntity.empty().vendorName ?? '',
                  description: CouponEntity.empty().name,
                ),
                itemBuilder: (context, item, index) {
                  final isDisabled = !item.isActive;
                  return AppCard(
                    title: item.vendorName ?? item.name,
                    description: item.name,
                    imageUrl: item.productImage,
                    isFavorite: item.isFav,
                    packageNames: item.packageNames,
                    isDisabled: isDisabled,
                    onTap: () {
                      Go.to(CouponDetailsScreen(id: item.id, coupon: item));
                    },
                    onFavoriteTap: () {
                      context.read<FavoriteManager>().toggle(
                            id: item.id,
                            coupon: item,
                          );
                    },
                  );
                },
                emptyWidget: EmptyWidget(
                  title: LocaleKeys.noCouponsTitle,
                  desc: LocaleKeys.noCouponsDesc,
                ),
              );
            },
          ),
          SliverToBoxAdapter(child: 40.szH), // Bottom spacing for FAB/Nav
        ],
      ),
    );
  }
}
