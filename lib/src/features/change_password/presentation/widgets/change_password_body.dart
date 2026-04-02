part of '../../imports/change_password_imports.dart';

class ChangePasswordBody extends StatefulWidget {
  const ChangePasswordBody({super.key});

  @override
  State<ChangePasswordBody> createState() => _ChangePasswordBodyState();
}

class _ChangePasswordBodyState extends State<ChangePasswordBody>
    with FormMixin {
  final _currentPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _obscureCurrent = true;
  bool _obscureNew = true;
  bool _obscureConfirm = true;

  @override
  void dispose() {
    _currentPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: AppPadding.pW20),
      child: Form(
        key: formKey,
        child: Column(
          children: [
            Center(child: Image.asset(AppAssets.svg.baseSvg.verification.path)),
            Center(
              child: Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: '${LocaleKeys.change}\t',
                      style: context.textStyle.s20.bold,
                    ),
                    TextSpan(
                      text: LocaleKeys.password,
                      style: context.textStyle.s20.bold.setPrimaryColor,
                    ),
                  ],
                ),
              ),
            ),
            20.szH,
            FieldLabel(label: LocaleKeys.currentPassword),
            8.szH,
            AppTextField(
              controller: _currentPasswordController,
              hint: LocaleKeys.pleaseEnterYourCurrentPassword,
              obscureText: _obscureCurrent,
              validator: (v) => Validators.validatePassword(
                v,
                fieldTitle: LocaleKeys.currentPassword,
              ),
              suffixIcon: IconButton(
                onPressed: () =>
                    setState(() => _obscureCurrent = !_obscureCurrent),
                icon: Icon(
                  _obscureCurrent
                      ? Icons.visibility_off_outlined
                      : Icons.visibility_outlined,
                  color: AppColors.gray500,
                ),
              ),
            ),
            20.szH,
            FieldLabel(label: LocaleKeys.newPassword),
            8.szH,
            AppTextField(
              controller: _newPasswordController,
              hint: LocaleKeys.pleaseEnterYourNewPassword,
              obscureText: _obscureNew,
              validator: (v) => Validators.validateNewPassword(
                v,
                _currentPasswordController.text,
                fieldTitle: LocaleKeys.newPassword,
              ),
              suffixIcon: IconButton(
                onPressed: () => setState(() => _obscureNew = !_obscureNew),
                icon: Icon(
                  _obscureNew
                      ? Icons.visibility_off_outlined
                      : Icons.visibility_outlined,
                  color: AppColors.gray500,
                ),
              ),
            ),
            20.szH,
            FieldLabel(label: LocaleKeys.confirmNewPassword),
            8.szH,
            AppTextField(
              controller: _confirmPasswordController,
              hint: LocaleKeys.pleaseEnterYourNewPasswordConfirmation,
              obscureText: _obscureConfirm,
              validator: (v) => Validators.validatePasswordConfirm(
                v,
                _newPasswordController.text,
                fieldTitle: LocaleKeys.confirmNewPassword,
              ),
              suffixIcon: IconButton(
                onPressed: () =>
                    setState(() => _obscureConfirm = !_obscureConfirm),
                icon: Icon(
                  _obscureConfirm
                      ? Icons.visibility_off_outlined
                      : Icons.visibility_outlined,
                  color: AppColors.gray500,
                ),
              ),
            ),
            40.szH,
            LoadingButton(
              title: LocaleKeys.save,
              onTap: () async {
                if (validate()) {
                  await context
                      .read<ChangePasswordCubit>()
                      .submitChangePassword(
                        currentPassword: _currentPasswordController.text,
                        newPassword: _newPasswordController.text,
                        confirmPassword: _confirmPasswordController.text,
                      );
                }
              },
            ),
            30.szH,
          ],
        ),
      ),
    );
  }
}
