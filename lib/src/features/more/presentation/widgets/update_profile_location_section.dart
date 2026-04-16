part of '../imports/view_imports.dart';

class UpdateProfileLocationSection extends StatelessWidget {
  const UpdateProfileLocationSection({
    super.key,
    required this.selectedCountry,
    required this.selectedCity,
    required this.selectedMunicipality,
    required this.onCountryChanged,
    required this.onCityChanged,
    required this.onMunicipalityChanged,
    required this.level2Label,
    required this.level2Hint,
    required this.level3Label,
    required this.level3Hint,
  });

  final CountryEntity? selectedCountry;
  final CityEntity? selectedCity;
  final RegionEntity? selectedMunicipality;
  final Function(CountryEntity?) onCountryChanged;
  final Function(CityEntity?) onCityChanged;
  final Function(RegionEntity?) onMunicipalityChanged;
  final String level2Label;
  final String level2Hint;
  final String level3Label;
  final String level3Hint;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FieldLabel(label: LocaleKeys.country),
        8.szH,
        BlocBuilder<
          GetBaseEntityCubit<CountryEntity>,
          GetBaseEntityState<CountryEntity>
        >(
          builder: (context, state) {
            return const SizedBox().asFormField<CountryEntity>(
              initialValue: selectedCountry,
              validator: (v) => Validators.validateDropDown(
                v,
                fieldTitle: LocaleKeys.country,
              ),
              builder: (fieldState) => AppDropdown<CountryEntity>(
                items: state.dataState.data ?? [],
                value: selectedCountry,
                hint: LocaleKeys.selectCountry,
                itemAsString: (country) => country.name.isNotEmpty
                    ? country.name
                    : (country.key ?? country.id.toString()),
                onChanged: (val) {
                  onCountryChanged(val);
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
                  FieldLabel(label: level2Label),
                  8.szH,
                  BlocBuilder<
                    GetBaseEntityCubit<CityEntity>,
                    GetBaseEntityState<CityEntity>
                  >(
                    builder: (context, state) {
                      return const SizedBox().asFormField<CityEntity>(
                        initialValue: selectedCity,
                        validator: (v) => Validators.validateDropDown(
                          v,
                          fieldTitle: level2Label,
                        ),
                        builder: (fieldState) => AppDropdown<CityEntity>(
                          readonly: selectedCountry == null,
                          items: state.dataState.data ?? [],
                          value: selectedCity,
                          hint: level2Hint,
                          itemAsString: (city) => city.name.isNotEmpty
                              ? city.name
                              : city.id.toString(),
                          onChanged: (val) {
                            onCityChanged(val);
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
                  FieldLabel(label: level3Label),
                  8.szH,
                  BlocBuilder<
                    GetBaseEntityCubit<RegionEntity>,
                    GetBaseEntityState<RegionEntity>
                  >(
                    builder: (context, state) {
                      return const SizedBox().asFormField<RegionEntity>(
                        initialValue: selectedMunicipality,
                        validator: (v) => Validators.validateDropDown(
                          v,
                          fieldTitle: level3Label,
                        ),
                        builder: (fieldState) => AppDropdown<RegionEntity>(
                          readonly: selectedCity == null,
                          items: state.dataState.data ?? [],
                          value: selectedMunicipality,
                          hint: level3Hint,
                          itemAsString: (region) => region.name.isNotEmpty
                              ? region.name
                              : region.id.toString(),
                          onChanged: (val) {
                            onMunicipalityChanged(val);
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
      ],
    );
  }
}
