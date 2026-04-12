import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mazaya/src/config/language/locale_keys.g.dart';
import 'package:mazaya/src/config/res/config_imports.dart';
import 'package:mazaya/src/core/base_crud/code/domain/base_domain_imports.dart';
import 'package:mazaya/src/core/base_crud/code/presentation/cubit/get_base_name_and_id/get_base_name_and_id_cubit.dart';
import 'package:mazaya/src/core/extensions/widgets/sized_box_helper.dart';
import 'package:mazaya/src/core/shared/cubits/user_cubit/user_cubit.dart';
import 'package:mazaya/src/features/coupons/presentation/cubits/coupons_cubit.dart';

import 'filter_apply_button.dart';
import 'filter_header.dart';
import 'filter_location_selectors.dart';
import 'filter_nearby_section.dart';
import 'filter_sort_and_category_section.dart';

class CouponsFilterBottomSheet extends StatefulWidget {
  const CouponsFilterBottomSheet({super.key});

  @override
  State<CouponsFilterBottomSheet> createState() =>
      _CouponsFilterBottomSheetState();
}

class _CouponsFilterBottomSheetState extends State<CouponsFilterBottomSheet> {
  CountryEntity? _selectedCountry;
  CityEntity? _selectedCity;
  RegionEntity? _selectedRegion;
  CategoryEntity? _selectedCategory;
  String? _selectedSort;
  String? _selectedNearby;

  bool get _isEgypt => _selectedCountry?.id == 257 || _selectedCountry?.id == 1;

  String get _level2Label =>
      _isEgypt ? LocaleKeys.governorate : LocaleKeys.city;

  String get _level3Label =>
      _isEgypt ? LocaleKeys.city : LocaleKeys.municipality;

  @override
  void initState() {
    super.initState();
    final cubit = context.read<CouponsCubit>();
    final userState = context.read<UserCubit>().state;
    final user = userState.userModel;

    // Prioritize values from CouponsCubit (last selected), fallback to profile/login response
    _selectedCountry = cubit.selectedCountry ??
        (user.locationGrandparentId != null
            ? CountryEntity(
                id: user.locationGrandparentId!,
                name: user.locationGrandparentName ?? '',
              )
            : null);

    _selectedCity = cubit.selectedCity ??
        (user.locationParentId != null
            ? CityEntity(
                id: user.locationParentId!,
                name: user.locationParentName ?? '',
              )
            : null);

    _selectedRegion = cubit.selectedRegion ??
        (user.locationId != null
            ? RegionEntity(
                id: user.locationId!,
                name: user.locationName ?? '',
              )
            : null);

    _selectedCategory = cubit.selectedCategory;
    _selectedSort = cubit.selectedSort;
    _selectedNearby = cubit.selectedNearby ?? 'all';

    // Trigger region fetching if a city is set
    if (_selectedCity != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        context.read<GetBaseEntityCubit<RegionEntity>>().fGetBaseNameAndId(
              id: _selectedCity!.id,
            );
      });
    }

    _validateNearby();
  }

  void _onCountryChanged(CountryEntity? country) {
    setState(() {
      _selectedCountry = country;
      _selectedCity = null;
      _selectedRegion = null;
      _validateNearby();
    });
    if (country != null) {
      context.read<GetBaseEntityCubit<CityEntity>>().fGetBaseNameAndId(
            id: country.id,
          );
    }
  }

  void _onCityChanged(CityEntity? city) {
    setState(() {
      _selectedCity = city;
      _selectedRegion = null;
      _validateNearby();
    });
    if (city != null) {
      context.read<GetBaseEntityCubit<RegionEntity>>().fGetBaseNameAndId(
            id: city.id,
          );
    }
  }

  void _onRegionChanged(RegionEntity? region) {
    setState(() {
      _selectedRegion = region;
      _validateNearby();
    });
  }

  void _validateNearby() {
    if (!_isNearbyEnabled) {
      _selectedNearby = 'all';
    }
  }

  bool get _isNearbyEnabled {
    final userState = context.read<UserCubit>().state;
    return _selectedCountry?.id == userState.selectedCountry?.id &&
        _selectedCity?.id == userState.selectedCity?.id &&
        _selectedRegion?.id == userState.selectedRegion?.id;
  }

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
          FilterHeader(
            onReset: () {
              context.read<CouponsCubit>().clearFilters();
              Navigator.pop(context);
            },
          ),
          20.szH,
          FilterLocationSelectors(
            selectedCountry: _selectedCountry,
            selectedCity: _selectedCity,
            selectedRegion: _selectedRegion,
            level2Label: _level2Label,
            level3Label: _level3Label,
            onCountryChanged: _onCountryChanged,
            onCityChanged: _onCityChanged,
            onRegionChanged: _onRegionChanged,
          ),
          16.szH,
          FilterSortAndCategorySection(
            selectedCategory: _selectedCategory,
            selectedSort: _selectedSort,
            onCategoryChanged: (cat) => setState(() => _selectedCategory = cat),
            onSortChanged: (val) => setState(() => _selectedSort = val),
          ),
          20.szH,
          FilterNearbySection(
            isNearbyEnabled: _isNearbyEnabled,
            selectedNearby: _selectedNearby,
            onNearbyChanged: (val) => setState(() => _selectedNearby = val),
          ),
          30.szH,
          FilterApplyButton(
            onTap: () {
              context.read<CouponsCubit>().applyFilters(
                    category: _selectedCategory,
                    country: _selectedCountry,
                    city: _selectedCity,
                    region: _selectedRegion,
                    sort: _selectedSort,
                    nearby: _selectedNearby,
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
