part of '../imports/view_imports.dart';

class UpdateProfileAdditionalInfoFields extends StatelessWidget {
  const UpdateProfileAdditionalInfoFields({
    super.key,
    required this.personalNumberController,
    required this.addressController,
    required this.poBoxController,
    required this.nationalIdController,
  });

  final TextEditingController personalNumberController;
  final TextEditingController addressController;
  final TextEditingController poBoxController;
  final TextEditingController nationalIdController;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FieldLabel(label: LocaleKeys.personalNumber),
        8.szH,
        AppTextField(
          controller: personalNumberController,
          hint: LocaleKeys.personalNumber,
          keyboardType: TextInputType.number,
          validator: (v) => Validators.validateEmpty(
            v,
            fieldTitle: LocaleKeys.personalNumber,
          ),
        ),
        20.szH,
        FieldLabel(label: LocaleKeys.address),
        8.szH,
        AppTextField(
          controller: addressController,
          hint: LocaleKeys.enterAddress,
          validator: (v) =>
              Validators.validateEmpty(v, fieldTitle: LocaleKeys.address),
        ),
        20.szH,
        FieldLabel(label: LocaleKeys.poBox),
        8.szH,
        AppTextField(
          controller: poBoxController,
          hint: LocaleKeys.enterPoBox,
          keyboardType: TextInputType.number,
          validator: (v) =>
              Validators.validateEmpty(v, fieldTitle: LocaleKeys.poBox),
        ),
        20.szH,
        FieldLabel(label: LocaleKeys.nationalId),
        8.szH,
        AppTextField(
          controller: nationalIdController,
          hint: LocaleKeys.enterNationalId,
          keyboardType: TextInputType.number,
          validator: (v) => Validators.validateEmpty(
            v,
            fieldTitle: LocaleKeys.nationalId,
          ),
        ),
      ],
    );
  }
}
