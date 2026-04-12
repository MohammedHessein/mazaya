import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mazaya/src/features/location/imports/location_imports.dart';
import 'package:mazaya/src/core/shared/cubits/user_cubit/user_cubit.dart';

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
  bool _isFetchingLocation = false;

  bool get _isEgypt => _selectedCountry?.id == 257 || _selectedCountry?.id == 1;

  String get _level2Label =>
      _isEgypt ? LocaleKeys.governorate : LocaleKeys.city;

  String get _level2Hint =>
      _isEgypt ? LocaleKeys.selectGovernorate : LocaleKeys.selectCity;

  String get _level3Label =>
      _isEgypt ? LocaleKeys.city : LocaleKeys.municipality;

  String get _level3Hint =>
      _isEgypt ? LocaleKeys.selectCity : LocaleKeys.selectMunicipality;

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

  String? get _locationId =>
      (_selectedMunicipality?.id ?? _selectedCity?.id ?? _selectedCountry?.id)
          ?.toString();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => injector<UpdateProfileCubit>(),
      child: Padding(
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
                  return const SizedBox().asFormField<CountryEntity>(
                    initialValue: _selectedCountry,
                    validator: (value) => Validators.validateDropDown(
                      value,
                      fieldTitle: LocaleKeys.country,
                    ),
                    builder: (fieldState) => AppDropdown<CountryEntity>(
                      items: state.dataState.data ?? [],
                      value: _selectedCountry,
                      hint: LocaleKeys.selectCountry,
                      itemAsString: (country) => country.name,
                      onChanged: (val) {
                        _onCountryChanged(val);
                        fieldState.didChange(val);
                      },
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
                        FieldLabel(label: _level2Label),
                        8.szH,
                        BlocBuilder<
                          GetBaseEntityCubit<CityEntity>,
                          GetBaseEntityState<CityEntity>
                        >(
                          builder: (context, state) {
                            return const SizedBox().asFormField<CityEntity>(
                              initialValue: _selectedCity,
                              validator: (value) => Validators.validateDropDown(
                                value,
                                fieldTitle: _level2Label,
                              ),
                              builder: (fieldState) => AppDropdown<CityEntity>(
                                readonly: _selectedCountry == null,
                                items: state.dataState.data ?? [],
                                value: _selectedCity,
                                hint: _level2Hint,
                                itemAsString: (city) => city.name,
                                onChanged: (val) {
                                  _onCityChanged(val);
                                  fieldState.didChange(val);
                                },
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
                        FieldLabel(label: _level3Label),
                        8.szH,
                        BlocBuilder<
                          GetBaseEntityCubit<RegionEntity>,
                          GetBaseEntityState<RegionEntity>
                        >(
                          builder: (context, state) {
                            return const SizedBox().asFormField<RegionEntity>(
                              initialValue: _selectedMunicipality,
                              validator: (value) => Validators.validateDropDown(
                                value,
                                fieldTitle: _level3Label,
                              ),
                              builder: (fieldState) => AppDropdown<RegionEntity>(
                                readonly: _selectedCity == null,
                                items: state.dataState.data ?? [],
                                value: _selectedMunicipality,
                                hint: _level3Hint,
                                itemAsString: (region) => region.name,
                                onChanged: (val) {
                                  _onMunicipalityChanged(val);
                                  fieldState.didChange(val);
                                },
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
                onTap: _isFetchingLocation
                    ? null
                    : () async {
                        setState(() => _isFetchingLocation = true);
                        try {
                          final position =
                              await LocationHelper.getCurrentLocation();
                          final address =
                              await LocationHelper.getAddressFromLatLng(position);
                          if (address != null) {
                            _addressController.text = address;
                          }
                        } catch (e) {
                          if (context.mounted) {
                            MessageUtils.showSnackBar(
                              context: context,
                              baseStatus: BaseStatus.error,
                              message: e.toString(),
                            );
                          }
                        } finally {
                          if (mounted) {
                            setState(() => _isFetchingLocation = false);
                          }
                        }
                      },
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (_isFetchingLocation)
                      SizedBox(
                        width: 20.r,
                        height: 20.r,
                        child: const CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor: AlwaysStoppedAnimation<Color>(
                            AppColors.primary,
                          ),
                        ),
                      )
                    else
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
                      _isFetchingLocation
                          ? LocaleKeys.fetchingLocation
                          : LocaleKeys.useCurrentLocation,
                      style: context.textStyle.s14.bold.setPrimaryColor,
                    ),
                  ],
                ),
              ),
              40.szH,
              BlocBuilder<UpdateProfileCubit, AsyncState<UserModel?>>(
                builder: (context, state) {
                  return LoadingButton(
                    title: LocaleKeys.next,
                    textColor: AppColors.white,
                    color: AppColors.primary,
                    onTap: () async {
                      if (_formKey.currentState!.validate()) {
                        UserCubit.instance.updateLocationHierarchy(
                          country: _selectedCountry,
                          city: _selectedCity,
                          region: _selectedMunicipality,
                        );

                        await context.read<UpdateProfileCubit>().updateProfile(
                          locationId: _locationId,
                          address: _addressController.text,
                        );
                      }
                    },
                  );
                },
              ),
              20.szH,
            ],
          ),
        ),
      ),
    );
  }
}
