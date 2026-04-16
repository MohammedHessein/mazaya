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
  late TextEditingController _firstNameController;
  late TextEditingController _lastNameController;
  late TextEditingController _mobileController;
  late TextEditingController _countryCodeController;
  late TextEditingController _personalNumberController;
  FlCountryCodePicker get _countryPicker => FlCountryCodePicker(
    localize: true,
    favorites: const ['EG', 'SE', 'SA', 'US'],
    favoritesIcon: Icon(
      Icons.star_rounded,
      color: AppColors.orange,
      size: 18.w,
    ),
    title: Padding(
      padding: EdgeInsets.all(12.h),
      child: Text(LocaleKeys.selectCountry, style: context.textStyle.s18.bold),
    ),
    searchBarDecoration: InputDecoration(
      hintText: LocaleKeys.searchFor,
      prefixIcon: Padding(
        padding: EdgeInsets.all(12.w),
        child: AppAssets.svg.baseSvg.search.svg(),
      ),
      prefixIconColor: WidgetStateColor.resolveWith((states) {
        if (states.contains(WidgetState.focused)) {
          return AppColors.primary;
        }
        return AppColors.placeholder;
      }),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: AppColors.primary, width: 1.w),
        borderRadius: BorderRadius.circular(12.r),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: AppColors.hintText, width: 1.w),
        borderRadius: BorderRadius.circular(12.r),
      ),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.r)),
    ),
  );
  CountryCode? _pickedCountryCode;
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
    _firstNameController = TextEditingController(text: user.firstName);
    _lastNameController = TextEditingController(text: user.lastName);
    _mobileController = TextEditingController(text: user.mobile);
    _countryCodeController = TextEditingController(text: user.countryCode);
    _pickedCountryCode = CountryCode.fromDialCode(_countryCodeController.text);
    _personalNumberController = TextEditingController(
      text: user.personalNumber,
    );

    _nameController.addListener(_onChanged);
    _emailController.addListener(_onChanged);
    _addressController.addListener(_onChanged);
    _poBoxController.addListener(_onChanged);
    _nationalIdController.addListener(_onChanged);
    _firstNameController.addListener(_onChanged);
    _lastNameController.addListener(_onChanged);
    _mobileController.addListener(_onChanged);
    _countryCodeController.addListener(_onChanged);
    _personalNumberController.addListener(_onChanged);

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
        ? RegionEntity(id: user.locationId!, name: user.locationName ?? '')
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
    _firstNameController.dispose();
    _lastNameController.dispose();
    _mobileController.dispose();
    _countryCodeController.dispose();
    _personalNumberController.dispose();
    super.dispose();
  }

  String? get _locationId =>
      (_selectedMunicipality?.id ?? _selectedCity?.id ?? _selectedCountry?.id)
          ?.toString();

  bool get _hasChanges {
    final nameChanged = _nameController.text.trim() != user.name.trim();
    final firstNameChanged =
        _firstNameController.text.trim() != (user.firstName ?? '').trim();
    final lastNameChanged =
        _lastNameController.text.trim() != (user.lastName ?? '').trim();
    final mobileChanged = _mobileController.text.trim() != user.mobile.trim();
    final countryCodeChanged =
        _countryCodeController.text.trim() != (user.countryCode ?? '').trim();
    final personalNumberChanged =
        _personalNumberController.text.trim() !=
        (user.personalNumber ?? '').trim();
    final emailChanged = _emailController.text.trim() != user.email.trim();
    final addressChanged =
        (_addressController.text.trim() != (user.address ?? '').trim());
    final poBoxChanged =
        (_poBoxController.text.trim() != (user.poBox ?? '').trim());
    final nationalIdChanged =
        (_nationalIdController.text.trim() != (user.nationalId ?? '').trim());
    final initialLocationId =
        (user.locationId ?? user.locationParentId ?? user.locationGrandparentId)
            ?.toString();
    final locationChanged = _locationId != initialLocationId;

    return nameChanged ||
        firstNameChanged ||
        lastNameChanged ||
        mobileChanged ||
        countryCodeChanged ||
        personalNumberChanged ||
        emailChanged ||
        addressChanged ||
        poBoxChanged ||
        nationalIdChanged ||
        locationChanged;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            UpdateProfileBasicInfoFields(
              nameController: _nameController,
              emailController: _emailController,
              firstNameController: _firstNameController,
              lastNameController: _lastNameController,
            ),
            20.szH,
            UpdateProfilePhoneFields(
              mobileController: _mobileController,
              countryCodeController: _countryCodeController,
              pickedCountryCode: _pickedCountryCode,
              onCountryPickerTap: () async {
                final picked = await _countryPicker.showPicker(
                  context: context,
                  pickerMaxHeight: ScreenUtil().screenHeight * 0.7,
                );
                if (picked != null) {
                  setState(() {
                    _pickedCountryCode = picked;
                    _countryCodeController.text = picked.dialCode;
                  });
                }
              },
            ),
            20.szH,
            UpdateProfileAdditionalInfoFields(
              personalNumberController: _personalNumberController,
              addressController: _addressController,
              poBoxController: _poBoxController,
              nationalIdController: _nationalIdController,
            ),
            20.szH,
            UpdateProfileLocationSection(
              selectedCountry: _selectedCountry,
              selectedCity: _selectedCity,
              selectedMunicipality: _selectedMunicipality,
              onCountryChanged: _onCountryChanged,
              onCityChanged: _onCityChanged,
              onMunicipalityChanged: _onMunicipalityChanged,
              level2Label: _level2Label,
              level2Hint: _level2Hint,
              level3Label: _level3Label,
              level3Hint: _level3Hint,
            ),
            40.szH,
            BlocBuilder<UpdateProfileCubit, AsyncState<UserModel?>>(
              builder: (context, state) {
                return LoadingButton(
                  title: LocaleKeys.saveChanges,
                  textColor: AppColors.white,
                  color: _hasChanges
                      ? AppColors.primary
                      : AppColors.placeholder,
                  isDissabled: !_hasChanges,
                  onTap: () async {
                    if (_formKey.currentState!.validate()) {
                      await UserCubit.instance.updateLocationHierarchy(
                        country: _selectedCountry,
                        city: _selectedCity,
                        region: _selectedMunicipality,
                      );
                      final cubit = context.read<UpdateProfileCubit>();
                      await cubit.updateProfile(
                        name: _nameController.text,
                        email: _emailController.text,
                        locationId: _locationId,
                        address: _addressController.text,
                        poBox: _poBoxController.text,
                        nationalId: _nationalIdController.text,
                        firstName: _firstNameController.text,
                        lastName: _lastNameController.text,
                        mobile: _mobileController.text,
                        countryCode: _countryCodeController.text,
                        personalNumber: _personalNumberController.text,
                        isUpdate: true,
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
    );
  }
}
