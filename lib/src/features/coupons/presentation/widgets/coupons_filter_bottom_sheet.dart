import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mazaya/src/config/language/locale_keys.g.dart';
import 'package:mazaya/src/config/res/config_imports.dart';
import 'package:mazaya/src/core/base_crud/code/domain/base_domain_imports.dart';
import 'package:mazaya/src/core/base_crud/code/presentation/cubit/get_base_name_and_id/get_base_name_and_id_cubit.dart';
import 'package:mazaya/src/core/extensions/context_extension.dart';
import 'package:mazaya/src/core/extensions/text_style_extensions.dart';
import 'package:mazaya/src/core/extensions/widgets/sized_box_helper.dart';
import 'package:mazaya/src/core/shared/cubits/user_cubit/user_cubit.dart';
import 'package:mazaya/src/core/widgets/buttons/loading_button.dart';
import 'package:mazaya/src/core/widgets/fields/drop_downs/app_drop_down/app_dropdown.dart';
import 'package:mazaya/src/features/coupons/presentation/cubits/coupons_cubit.dart';

class CouponsFilterBottomSheet extends StatefulWidget {
  const CouponsFilterBottomSheet({super.key});

  @override
  State<CouponsFilterBottomSheet> createState() =>
      CouponsFilterBottomSheetState();
}

class CouponsFilterBottomSheetState extends State<CouponsFilterBottomSheet> {
  RegionEntity? selectedRegion;
  CategoryEntity? selectedCategory;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: AppPadding.pW20,
        vertical: AppPadding.pH20,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Text(
              LocaleKeys.searchFor,
              style: context.textStyle.s18.bold.setMainTextColor,
            ),
          ),
          20.szH,
          BlocBuilder<
            GetBaseEntityCubit<RegionEntity>,
            GetBaseEntityState<RegionEntity>
          >(
            builder: (context, state) {
              final userState = context.read<UserCubit>().state;
              final isEgypt =
                  userState.selectedCountry?.id == 257 ||
                  userState.selectedCountry?.id == 1;

              return AppDropdown<RegionEntity>(
                items: state.dataState.data ?? [],
                value: selectedRegion,
                itemAsString: (region) => region.name,
                onChanged: (region) {
                  setState(() {
                    selectedRegion = region;
                  });
                },
                hint: isEgypt ? LocaleKeys.city : LocaleKeys.municipality,
                isLoading: state.dataState.isLoading,
              );
            },
          ),
          16.szH,
          BlocBuilder<
            GetBaseEntityCubit<CategoryEntity>,
            GetBaseEntityState<CategoryEntity>
          >(
            builder: (context, state) {
              return AppDropdown<CategoryEntity>(
                items: state.dataState.data ?? [],
                value: selectedCategory,
                itemAsString: (cat) => cat.name,
                onChanged: (cat) {
                  setState(() {
                    selectedCategory = cat;
                  });
                },
                hint: LocaleKeys.section,
                isLoading: state.dataState.isLoading,
              );
            },
          ),
          30.szH,
          LoadingButton(
            title: LocaleKeys.search,
            onTap: () async {
              context.read<CouponsCubit>().applyFilters(
                categoryId: selectedCategory?.id,
                locationId: selectedRegion?.id,
              );
              Navigator.pop(context);
            },
          ),
          SizedBox(height: MediaQuery.of(context).viewInsets.bottom),
        ],
      ),
    );
  }
}
