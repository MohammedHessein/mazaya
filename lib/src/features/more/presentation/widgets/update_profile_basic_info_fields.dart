part of '../imports/view_imports.dart';

class UpdateProfileBasicInfoFields extends StatelessWidget {
  const UpdateProfileBasicInfoFields({
    super.key,
    required this.nameController,
    required this.emailController,
    required this.firstNameController,
    required this.lastNameController,
  });

  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController firstNameController;
  final TextEditingController lastNameController;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FieldLabel(label: LocaleKeys.name),
        8.szH,
        AppTextField(
          controller: nameController,
          hint: LocaleKeys.name,
          validator: (v) =>
              Validators.validateName(v, fieldTitle: LocaleKeys.name),
        ),
        20.szH,
        FieldLabel(label: LocaleKeys.email),
        8.szH,
        AppTextField(
          controller: emailController,
          hint: LocaleKeys.email,
          keyboardType: TextInputType.emailAddress,
          validator: (value) => value != null && value.isNotEmpty
              ? Validators.validateEmail(value)
              : null,
        ),
        20.szH,
        Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FieldLabel(label: LocaleKeys.firstName),
                  8.szH,
                  AppTextField(
                    controller: firstNameController,
                    hint: LocaleKeys.firstName,
                    validator: (v) => Validators.validateName(
                      v,
                      fieldTitle: LocaleKeys.firstName,
                    ),
                  ),
                ],
              ),
            ),
            15.szW,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FieldLabel(label: LocaleKeys.lastName),
                  8.szH,
                  AppTextField(
                    controller: lastNameController,
                    hint: LocaleKeys.lastName,
                    validator: (v) => Validators.validateName(
                      v,
                      fieldTitle: LocaleKeys.lastName,
                    ),
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
