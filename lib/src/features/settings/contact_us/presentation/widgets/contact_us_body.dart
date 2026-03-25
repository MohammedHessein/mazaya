part of '../imports/contact_us_imports.dart';

class _ContactUsBody extends StatefulWidget {
  const _ContactUsBody();

  @override
  State<_ContactUsBody> createState() => _ContactUsBodyState();
}

class _ContactUsBodyState extends State<_ContactUsBody> {
  final ContactUsParams params = ContactUsParams();
  @override
  void dispose() {
    params.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ContactUsCubit>();
    return Form(
      key: params.formKey,
      child:
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: AppMargin.mH10,
                  children: [
                    if (!UserCubit.instance.isUserLoggedIn) ...[
                      CustomTextFiled(
                        controller: params.fullNameController,
                        hint: LocaleKeys.fullNameLabel,
                        title: LocaleKeys.fullNameLabel,
                        textInputType: TextInputType.text,
                        textInputAction: TextInputAction.next,
                        validator: (value) => Validators.validateEmpty(
                          value,
                          fieldTitle: LocaleKeys.fullNameLabel,
                        ),
                      ),
                      CustomTextFiled(
                        controller: params.phoneController,
                        hint: LocaleKeys.phoneNumber,
                        title: LocaleKeys.phoneNumber,
                        textInputType: TextInputType.phone,
                        textInputAction: TextInputAction.next,
                        validator: (value) => Validators.validatePhone(
                          value,
                          fieldTitle: LocaleKeys.phoneNumber,
                        ),
                      ),
                    ],
                    CustomTextFiled(
                      hint: LocaleKeys.messageHint,
                      title: LocaleKeys.messageLabel,
                      isOptional: true,
                      controller: params.messageController,
                      maxLines: ConstantManager.maxLines,
                      textInputType: TextInputType.multiline,
                      textInputAction: TextInputAction.newline,
                      validator: (value) => Validators.validateEmpty(value),
                    ),
                  ],
                ),
              ),
              LoadingButton(
                title: LocaleKeys.sendBtn,
                onTap: () async => await cubit.contactUs(params),
              ),
            ],
          ).paddingSymmetric(
            vertical: AppPadding.pH16,
            horizontal: AppPadding.pW14,
          ),
    );
  }
}
