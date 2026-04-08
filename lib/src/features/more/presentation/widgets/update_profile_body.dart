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
  late TextEditingController _poBoxController;
  late TextEditingController _nationalIdController;

  CountryEntity? _selectedCountry;
  CityEntity? _selectedCity;
  RegionEntity? _selectedMunicipality;

  UserModel get user => UserCubit.instance.state.userModel;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: user.name);
    _emailController = TextEditingController(text: user.email);
    _addressController = TextEditingController(text: user.address);
    _poBoxController = TextEditingController(text: user.poBox);
    _nationalIdController = TextEditingController(text: user.nationalId);

    _nameController.addListener(_onChanged);
    _emailController.addListener(_onChanged);
    _addressController.addListener(_onChanged);
    _poBoxController.addListener(_onChanged);
    _nationalIdController.addListener(_onChanged);

    // Initialize location hierarchy from UserModel IDs (instead of stale cache)
    _selectedCountry = user.locationGrandparentId != null
        ? CountryEntity(
            id: user.locationGrandparentId!,
            name: user.locationGrandparentName ?? '',
          )
        : null;
    _selectedCity = user.locationParentId != null
        ? CityEntity(
            id: user.locationParentId!,
            name: user.locationParentName ?? '',
          )
        : null;
    _selectedMunicipality = user.locationId != null
        ? RegionEntity(
            id: user.locationId!,
            name: user.locationName ?? '',
          )
        : null;

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
    _poBoxController.dispose();
    _nationalIdController.dispose();
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
    final poBoxChanged =
        (_poBoxController.text.trim() != (user.poBox ?? '').trim());
    final nationalIdChanged =
        (_nationalIdController.text.trim() != (user.nationalId ?? '').trim());
    final locationChanged = _locationId != null;

    return nameChanged || emailChanged || addressChanged || poBoxChanged || nationalIdChanged || locationChanged;
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
            20.szH,
            FieldLabel(label: LocaleKeys.poBox),
            8.szH,
            AppTextField(
              controller: _poBoxController,
              hint: LocaleKeys.enterPoBox,
              keyboardType: TextInputType.number,
            ),
            20.szH,
            FieldLabel(label: LocaleKeys.nationalId),
            8.szH,
            AppTextField(
              controller: _nationalIdController,
              hint: LocaleKeys.enterNationalId,
              keyboardType: TextInputType.number,
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
                          poBox: _poBoxController.text,
                          nationalId: _nationalIdController.text,
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
