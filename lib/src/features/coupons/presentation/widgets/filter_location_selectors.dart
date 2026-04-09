import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../config/language/locale_keys.g.dart';
import '../../../../core/base_crud/code/domain/base_domain_imports.dart';
import '../../../../core/base_crud/code/presentation/cubit/get_base_name_and_id/get_base_name_and_id_cubit.dart';
import '../../../../core/extensions/widgets/sized_box_helper.dart';
import '../../../../core/widgets/fields/drop_downs/app_drop_down/app_dropdown.dart';

class FilterLocationSelectors extends StatelessWidget {
  final CountryEntity? selectedCountry;
  final CityEntity? selectedCity;
  final RegionEntity? selectedRegion;
  final String level2Label;
  final String level3Label;
  final Function(CountryEntity?) onCountryChanged;
  final Function(CityEntity?) onCityChanged;
  final Function(RegionEntity?) onRegionChanged;

  const FilterLocationSelectors({
    super.key,
    required this.selectedCountry,
    required this.selectedCity,
    required this.selectedRegion,
    required this.level2Label,
    required this.level3Label,
    required this.onCountryChanged,
    required this.onCityChanged,
    required this.onRegionChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BlocBuilder<GetBaseEntityCubit<CountryEntity>,
            GetBaseEntityState<CountryEntity>>(
          builder: (context, state) {
            return AppDropdown<CountryEntity>(
              items: state.dataState.data ?? [],
              value: selectedCountry,
              itemAsString: (e) => e.name,
              onChanged: onCountryChanged,
              hint: LocaleKeys.country,
              isLoading: state.dataState.isLoading,
            );
          },
        ),
        16.szH,
        Row(
          children: [
            Expanded(
              child: BlocBuilder<GetBaseEntityCubit<CityEntity>,
                  GetBaseEntityState<CityEntity>>(
                builder: (context, state) {
                  return AppDropdown<CityEntity>(
                    readonly: selectedCountry == null,
                    items: state.dataState.data ?? [],
                    value: selectedCity,
                    itemAsString: (e) => e.name,
                    onChanged: onCityChanged,
                    hint: level2Label,
                    isLoading: state.dataState.isLoading,
                  );
                },
              ),
            ),
            15.szW,
            Expanded(
              child: BlocBuilder<GetBaseEntityCubit<RegionEntity>,
                  GetBaseEntityState<RegionEntity>>(
                builder: (context, state) {
                  return AppDropdown<RegionEntity>(
                    readonly: selectedCity == null,
                    items: state.dataState.data ?? [],
                    value: selectedRegion,
                    itemAsString: (e) => e.name,
                    onChanged: onRegionChanged,
                    hint: level3Label,
                    isLoading: state.dataState.isLoading,
                  );
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}
