part of '../../imports/reset_password_imports.dart';

class ResetPasswordBody extends StatefulWidget {
  final String email;
  final String code;

  const ResetPasswordBody({super.key, required this.email, required this.code});

  @override
  State<ResetPasswordBody> createState() => _ResetPasswordBodyState();
}

class _ResetPasswordBodyState extends State<ResetPasswordBody> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  bool obscurePassword = true;
  bool obscureConfirmPassword = true;

  @override
  void dispose() {
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ResetPasswordCubit, AsyncState<String?>>(
      listener: (context, state) async {},
      builder: (context, state) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: AppPadding.pW20),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                UniversalMediaWidget(
                  path: AppAssets.svg.baseSvg.verification.path,
                ),
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: LocaleKeys.resetPassword1,
                        style: context.textStyle.s20.bold,
                      ),
                      TextSpan(
                        text: LocaleKeys.resetPassword2,
                        style: context.textStyle.s20.bold.setPrimaryColor,
                      ),
                      TextSpan(
                        text: LocaleKeys.resetPassword3,
                        style: context.textStyle.s20.bold,
                      ),
                    ],
                  ),
                ),
                8.szH,
                Text(
                  LocaleKeys.enterNewPassword,
                  textAlign: TextAlign.center,
                  style: context.textStyle.s14.regular.setHintColor,
                ),
                30.szH,
                FieldLabel(label: LocaleKeys.newPasswordLabel),
                8.szH,
                AppTextField(
                  hint: LocaleKeys.enterNewPassword,
                  controller: passwordController,
                  obscureText: obscurePassword,
                  suffixIcon: IconButton(
                    onPressed: () =>
                        setState(() => obscurePassword = !obscurePassword),
                    icon: Icon(
                      obscurePassword
                          ? Icons.visibility_off_outlined
                          : Icons.visibility_outlined,
                      size: AppSize.sH20,
                      color: AppColors.gray500,
                    ),
                  ),
                  validator: (value) => Validators.validatePassword(
                    value,
                    fieldTitle: LocaleKeys.newPasswordLabel,
                  ),
                ),
                20.szH,
                FieldLabel(label: LocaleKeys.confirmPassword),
                8.szH,
                AppTextField(
                  hint: LocaleKeys.confirmPassword,
                  controller: confirmPasswordController,
                  obscureText: obscureConfirmPassword,
                  suffixIcon: IconButton(
                    onPressed: () => setState(
                      () => obscureConfirmPassword = !obscureConfirmPassword,
                    ),
                    icon: Icon(
                      obscureConfirmPassword
                          ? Icons.visibility_off_outlined
                          : Icons.visibility_outlined,
                      color: AppColors.gray500,
                      size: AppSize.sH20,
                    ),
                  ),
                  validator: (value) => Validators.validatePasswordConfirm(
                    value,
                    passwordController.text,
                    fieldTitle: LocaleKeys.confirmPassword,
                  ),
                ),
                40.szH,
                LoadingButton(
                  title: LocaleKeys.save,
                  onTap: () async {
                    if (_formKey.currentState!.validate()) {
                      await context.read<ResetPasswordCubit>().fResetPassword(
                        email: widget.email,
                        code: widget.code,
                        password: passwordController.text,
                        confirmPassword: confirmPasswordController.text,
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
