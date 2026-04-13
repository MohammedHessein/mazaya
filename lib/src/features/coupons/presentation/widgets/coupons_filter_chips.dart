import 'dart:developer';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mazaya/src/config/language/locale_keys.g.dart';
import 'package:mazaya/src/config/res/config_imports.dart';
import 'package:mazaya/src/core/base_crud/code/presentation/cubit/base_cubit/async_cubit.dart';
import 'package:mazaya/src/core/extensions/context_extension.dart';
import 'package:mazaya/src/core/extensions/text_style_extensions.dart';
import 'package:mazaya/src/core/extensions/widgets/sized_box_helper.dart';
import 'package:mazaya/src/core/base_crud/code/domain/base_domain_imports.dart';
import 'package:mazaya/src/core/base_crud/code/presentation/cubit/get_base_name_and_id/get_base_name_and_id_cubit.dart';
import 'package:mazaya/src/core/widgets/tools/pagination/imports/pagination_imports.dart';
import 'package:mazaya/src/features/coupons/entity/coupon_entity.dart';
import 'package:mazaya/src/features/coupons/presentation/cubits/coupons_cubit.dart';
import 'package:mazaya/src/features/home/presentation/cubits/home_cubit.dart';

class CouponsFilterChips extends StatelessWidget {
  const CouponsFilterChips({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CouponsCubit, AsyncState<PaginatedData<CouponEntity>>>(
      builder: (context, state) {
        final cubit = context.read<CouponsCubit>();
        final category = cubit.selectedCategory;
        final location = cubit.selectedLocation;
        final sort = cubit.selectedSort;
        final nearby = cubit.selectedNearby;

        final hasFilters =
            category != null ||
            location != null ||
            sort != null ||
            (nearby != null && nearby != 'all');

        if (!hasFilters) return const SizedBox.shrink();

        return SizedBox(
          height: 44.h,
          child: ListView(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(vertical: 4.h, horizontal: 16.w),
            children: [
              if (category != null)
                Builder(
                  builder: (context) {
                    String label = category.name;
                    if (label.isEmpty) {
                      label = '...';
                      final homeState = context.watch<HomeCubit>().state;
                      final categoriesState =
                          context.watch<GetBaseEntityCubit<CategoryEntity>>();

                      log(
                        '🔍 CouponsFilterChips: Attempting reactive name resolution for category ${category.id}. Home state: ${homeState.status}, Categories state: ${categoriesState.state.dataState.isSuccess ? 'success' : 'not_ready'}',
                      );

                      // Source 1: Home Categories (Faster, but incomplete subset)
                      if (homeState.isSuccess) {
                        final homeCategories =
                            homeState.data?.categories ?? [];
                        final match = homeCategories.firstWhereOrNull(
                          (c) => c.id == category.id,
                        );
                        if (match != null) {
                          label = match.name;
                          log('✅ CouponsFilterChips: Resolved from HomeCubit: $label');
                        }
                      }

                      // Source 2: Global Categories Cubit (Full list)
                      if (label == '...' &&
                          categoriesState.state.dataState.isSuccess) {
                        final allCategories =
                            categoriesState.state.dataState.data ?? [];
                        final match = allCategories.firstWhereOrNull(
                          (c) => c.id == category.id,
                        );
                        if (match != null) {
                          label = match.name;
                          log('✅ CouponsFilterChips: Resolved from Global CategoriesCubit: $label');
                        }
                      }

                      if (label == '...') {
                        log(
                          '⚠️ CouponsFilterChips: ID ${category.id} NOT FOUND in sources yet.',
                        );
                      }
                    }

                    return _buildChip(
                      context,
                      label: label,
                      onDelete: () => cubit.removeCategory(),
                    );
                  },
                ),
              if (category != null &&
                  (location != null ||
                      sort != null ||
                      (nearby != null && nearby != 'all')))
                8.szW,

              if (location != null)
                _buildChip(
                  context,
                  label: location.name,
                  onDelete: () => cubit.removeLocation(),
                ),
              if (location != null &&
                  (sort != null || (nearby != null && nearby != 'all')))
                8.szW,

              if (sort != null)
                _buildChip(
                  context,
                  label:
                      "${LocaleKeys.sortBy}: ${sort == 'asc' ? LocaleKeys.sortAsc : LocaleKeys.sortDesc}",
                  onDelete: () => cubit.removeSort(),
                ),
              if (sort != null && (nearby != null && nearby != 'all')) 8.szW,

              if (nearby != null && nearby != 'all')
                _buildChip(
                  context,
                  label:
                      "${LocaleKeys.nearby}: ${LocaleKeys.nearbyKm(distance: nearby)}",
                  onDelete: () => cubit.removeNearby(),
                ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildChip(
    BuildContext context, {
    required String label,
    required VoidCallback onDelete,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(AppCircular.r10),
        border: Border.all(color: AppColors.gray100),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withValues(alpha: 0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          GestureDetector(
            onTap: onDelete,
            child: Icon(
              Icons.cancel_outlined,
              size: 20.r,
              color: AppColors.primary,
            ),
          ),
          SizedBox(width: 8.w),
          Text(label, style: context.textStyle.s14.regular.setMainTextColor),
        ],
      ),
    );
  }
}
