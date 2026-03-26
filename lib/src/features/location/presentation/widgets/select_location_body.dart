import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../imports/location_imports.dart';

class SelectLocationBody extends StatefulWidget {
  const SelectLocationBody({super.key});

  @override
  State<SelectLocationBody> createState() => _SelectLocationBodyState();
}

class _SelectLocationBodyState extends State<SelectLocationBody> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _addressController = TextEditingController();
  CountryEntity? _selectedCountry;
  CityEntity? _selectedCity;
  RegionEntity? _selectedMunicipality;

  void _onCountryChanged(CountryEntity? country) {
    setState(() {
      _selectedCountry = country;
      _selectedCity = null;
      _selectedMunicipality = null;
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
      _selectedMunicipality = null;
    });
    if (city != null) {
      context.read<GetBaseEntityCubit<RegionEntity>>().fGetBaseNameAndId(
        id: city.id,
      );
    }
  }

  void _onMunicipalityChanged(RegionEntity? municipality) {
    setState(() {
      _selectedMunicipality = municipality;
    });
  }

  @override
  void dispose() {
    _addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            AppAssets.svg.baseSvg.determineLocation.image(),
            Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: '${LocaleKeys.determine} ',
                    style: context.textStyle.s20.bold,
                  ),
                  TextSpan(
                    text: LocaleKeys.yourLocation,
                    style: context.textStyle.s20.bold.setPrimaryColor,
                  ),
                ],
              ),
            ),
            8.szH,
            Text(
              LocaleKeys.loginSubtitle,
              style: context.textStyle.s14.regular.setHintColor,
              textAlign: TextAlign.center,
            ),
            30.szH,
            FieldLabel(label: LocaleKeys.country),
            8.szH,
            BlocBuilder<
              GetBaseEntityCubit<CountryEntity>,
              GetBaseEntityState<CountryEntity>
            >(
              builder: (context, state) {
                return AppDropdown<CountryEntity>(
                  items: state.dataState.data ?? [],
                  value: _selectedCountry,
                  hint: LocaleKeys.selectCountry,
                  itemAsString: (country) => country.name,
                  onChanged: _onCountryChanged,
                  isLoading: state.dataState.isLoading,
                ).asFormField<CountryEntity>(
                  validator: (value) => Validators.validateDropDown(
                    value,
                    fieldTitle: LocaleKeys.country,
                  ),
                  builder: (fieldState) => AppDropdown<CountryEntity>(
                    items: state.dataState.data ?? [],
                    value: _selectedCountry,
                    hint: LocaleKeys.selectCountry,
                    itemAsString: (country) => country.name,
                    onChanged: _onCountryChanged,
                    isLoading: state.dataState.isLoading,
                    hasError: fieldState.hasError,
                  ),
                );
              },
            ),
            20.szH,
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FieldLabel(label: LocaleKeys.city),
                      8.szH,
                      BlocBuilder<
                        GetBaseEntityCubit<CityEntity>,
                        GetBaseEntityState<CityEntity>
                      >(
                        builder: (context, state) {
                          return AppDropdown<CityEntity>(
                            readonly: _selectedCountry == null,
                            items: state.dataState.data ?? [],
                            value: _selectedCity,
                            hint: LocaleKeys.selectCity,
                            itemAsString: (city) => city.name,
                            onChanged: _onCityChanged,
                            isLoading: state.dataState.isLoading,
                          ).asFormField<CityEntity>(
                            validator: (value) => Validators.validateDropDown(
                              value,
                              fieldTitle: LocaleKeys.city,
                            ),
                            builder: (fieldState) => AppDropdown<CityEntity>(
                              readonly: _selectedCountry == null,
                              items: state.dataState.data ?? [],
                              value: _selectedCity,
                              hint: LocaleKeys.selectCity,
                              itemAsString: (city) => city.name,
                              onChanged: _onCityChanged,
                              isLoading: state.dataState.isLoading,
                              hasError: fieldState.hasError,
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
                15.szW,
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FieldLabel(label: LocaleKeys.municipality),
                      8.szH,
                      BlocBuilder<
                        GetBaseEntityCubit<RegionEntity>,
                        GetBaseEntityState<RegionEntity>
                      >(
                        builder: (context, state) {
                          return AppDropdown<RegionEntity>(
                            readonly: _selectedCity == null,
                            items: state.dataState.data ?? [],
                            value: _selectedMunicipality,
                            hint: LocaleKeys.selectMunicipality,
                            itemAsString: (region) => region.name,
                            onChanged: _onMunicipalityChanged,
                            isLoading: state.dataState.isLoading,
                          ).asFormField<RegionEntity>(
                            validator: (value) => Validators.validateDropDown(
                              value,
                              fieldTitle: LocaleKeys.municipality,
                            ),
                            builder: (fieldState) => AppDropdown<RegionEntity>(
                              readonly: _selectedCity == null,
                              items: state.dataState.data ?? [],
                              value: _selectedMunicipality,
                              hint: LocaleKeys.selectMunicipality,
                              itemAsString: (region) => region.name,
                              onChanged: _onMunicipalityChanged,
                              isLoading: state.dataState.isLoading,
                              hasError: fieldState.hasError,
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
            20.szH,
            FieldLabel(label: LocaleKeys.address),
            8.szH,
            AppTextField(
              controller: _addressController,
              hint: LocaleKeys.enterAddress,
              validator: (value) => Validators.validateEmpty(
                value,
                fieldTitle: LocaleKeys.address,
              ),
            ),
            15.szH,
            InkWell(
              onTap: () async {
                try {
                  final position = await LocationHelper.getCurrentLocation();
                  final address = await LocationHelper.getAddressFromLatLng(
                    position,
                  );
                  if (address != null) {
                    _addressController.text = address;
                  }
                } catch (e) {
                  if (context.mounted) {
                    ScaffoldMessenger.of(
                      context,
                    ).showSnackBar(SnackBar(content: Text(e.toString())));
                  }
                }
              },
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  AppAssets.svg.baseSvg.compress.svg(
                    width: 20.r,
                    height: 20.r,
                    colorFilter: const ColorFilter.mode(
                      AppColors.primary,
                      BlendMode.srcIn,
                    ),
                  ),
                  8.szW,
                  Text(
                    LocaleKeys.useCurrentLocation,
                    style: context.textStyle.s14.bold.setPrimaryColor,
                  ),
                ],
              ),
            ),
            40.szH,
            LoadingButton(
              title: LocaleKeys.next,
              textColor: AppColors.white,
              color: AppColors.primary,
              onTap: () async {
                if (_formKey.currentState!.validate()) {
                  // TODO: Proceed to next step
                }
              },
            ),
            20.szH,
          ],
        ),
      ),
    );
  }
}
