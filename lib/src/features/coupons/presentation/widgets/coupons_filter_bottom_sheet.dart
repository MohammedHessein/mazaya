import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mazaya/src/config/language/locale_keys.g.dart';
import 'package:mazaya/src/config/res/config_imports.dart';
import 'package:mazaya/src/core/base_crud/code/domain/base_domain_imports.dart';
import 'package:mazaya/src/core/base_crud/code/presentation/cubit/get_base_name_and_id/get_base_name_and_id_cubit.dart';
import 'package:mazaya/src/core/extensions/context_extension.dart';
import 'package:mazaya/src/core/extensions/text_style_extensions.dart';
import 'package:mazaya/src/core/extensions/widgets/sized_box_helper.dart';
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
  CityEntity? selectedCity;
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
          // City Dropdown
          BlocBuilder<
            GetBaseEntityCubit<CityEntity>,
            GetBaseEntityState<CityEntity>
          >(
            builder: (context, state) {
              return AppDropdown<CityEntity>(
                items: state.dataState.data ?? [],
                value: selectedCity,
                itemAsString: (city) => city.name,
                onChanged: (city) {
                  setState(() {
                    selectedCity = city;
                  });
                },
                hint: LocaleKeys.city,
                isLoading: state.dataState.isLoading,
              );
            },
          ),
          16.szH,
          // Category Dropdown
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
              // Apply filter logic
              // In this project's PaginatedCubit pattern, we can pass a map or key to fetchInitialData
              // For now, we follow the instruction to just go back and fetch
              context.read<CouponsCubit>().fetchInitialData(
                key:
                    null, // Resetting search query for now, or we could pass filter params
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
