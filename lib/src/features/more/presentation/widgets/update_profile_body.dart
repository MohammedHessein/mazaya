part of '../imports/view_imports.dart';

class UpdateProfileBody extends StatefulWidget {
  const UpdateProfileBody({super.key});

  @override
  State<UpdateProfileBody> createState() => _UpdateProfileBodyState();
}

class _UpdateProfileBodyState extends State<UpdateProfileBody> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _addressController;

  CountryEntity? _selectedCountry;
  CityEntity? _selectedCity;
  RegionEntity? _selectedMunicipality;
  bool _isFetchingLocation = false;

  UserModel get user => UserCubit.instance.state.userModel;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: user.name);
    _emailController = TextEditingController(text: user.email);
    _addressController = TextEditingController(text: user.address);

    _nameController.addListener(_onChanged);
    _emailController.addListener(_onChanged);
    _addressController.addListener(_onChanged);

    // Initialize location hierarchy from UserCubit
    final userState = UserCubit.instance.state;
    _selectedCountry = userState.selectedCountry;
    _selectedCity = userState.selectedCity;
    _selectedMunicipality = userState.selectedRegion;

    // Trigger data fetching for dependent lists if initial values exist
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_selectedCountry != null) {
        context.read<GetBaseEntityCubit<CityEntity>>().fGetBaseNameAndId(
              id: _selectedCountry!.id,
            );
      }
      if (_selectedCity != null) {
        context.read<GetBaseEntityCubit<RegionEntity>>().fGetBaseNameAndId(
              id: _selectedCity!.id,
            );
      }
    });
  }

  void _onChanged() {
    setState(() {});
  }

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
    _nameController.dispose();
    _emailController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  String? get _locationId {
    if (_isEgypt) {
      return _selectedCity?.id.toString();
    } else {
      return _selectedMunicipality?.id.toString();
    }
  }

  bool get _hasChanges {
    final nameChanged = _nameController.text.trim() != user.name.trim();
    final emailChanged = _emailController.text.trim() != user.email.trim();
    final addressChanged =
        (_addressController.text.trim() != (user.address ?? '').trim());
    final locationChanged = _locationId != null;

    return nameChanged || emailChanged || addressChanged || locationChanged;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            FieldLabel(label: LocaleKeys.name),
            8.szH,
            AppTextField(
              controller: _nameController,
              hint: LocaleKeys.name,
            ),
            20.szH,
            FieldLabel(label: LocaleKeys.email),
            8.szH,
            AppTextField(
              controller: _emailController,
              hint: LocaleKeys.email,
              keyboardType: TextInputType.emailAddress,
              validator: (value) => value != null && value.isNotEmpty
                  ? Validators.validateEmail(value)
                  : null,
            ),
            20.szH,
            FieldLabel(label: LocaleKeys.country),
            8.szH,
            BlocBuilder<GetBaseEntityCubit<CountryEntity>,
                GetBaseEntityState<CountryEntity>>(
              builder: (context, state) {
                return const SizedBox().asFormField<CountryEntity>(
                  initialValue: _selectedCountry,
                  validator: (value) => null,
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
                      BlocBuilder<GetBaseEntityCubit<CityEntity>,
                          GetBaseEntityState<CityEntity>>(
                        builder: (context, state) {
                          return const SizedBox().asFormField<CityEntity>(
                            initialValue: _selectedCity,
                            validator: (value) => null,
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
                      BlocBuilder<GetBaseEntityCubit<RegionEntity>,
                          GetBaseEntityState<RegionEntity>>(
                        builder: (context, state) {
                          return const SizedBox().asFormField<RegionEntity>(
                            initialValue: _selectedMunicipality,
                            validator: (value) => null,
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
                  title: LocaleKeys.saveChanges,
                  textColor: AppColors.white,
                  color: _hasChanges ? AppColors.primary : AppColors.placeholder,
                  isDissabled: !_hasChanges || state.isLoading,
                  onTap: () async {
                    UserCubit.instance.updateLocationHierarchy(
                      country: _selectedCountry,
                      city: _selectedCity,
                      region: _selectedMunicipality,
                    );
                    await context.read<UpdateProfileCubit>().updateProfile(
                          name: _nameController.text,
                          email: _emailController.text,
                          locationId: _locationId,
                          address: _addressController.text,
                          isUpdate: true,
                        );
                  },
                );
              },
            ),
            20.szH,
          ],
        ),
      ),
    );
  }
}
