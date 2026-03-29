part of '../../imports/login_imports.dart';

class LoginBody extends StatefulWidget {
  const LoginBody({super.key});

  @override
  State<LoginBody> createState() => _LoginBodyState();
}

class _LoginBodyState extends State<LoginBody> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool obscureText = true;
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, AsyncState<UserModel?>>(
      listener: (context, state) {},
      builder: (context, state) {
        return SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: AppPadding.pW20),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                40.szH,
                UniversalMediaWidget(path: AppAssets.svg.baseSvg.login.path),
                context.isArabic
                    ? Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: '${LocaleKeys.register} ',
                              style: context.textStyle.s20.bold,
                            ),
                            TextSpan(
                              text: LocaleKeys.login2,
                              style:
                                  context.textStyle.s20.bold.setPrimaryColor,
                            ),
                          ],
                        ),
                      )
                    : Text(
                        LocaleKeys.login,
                        style: context.textStyle.s20.bold.setPrimaryColor,
                      ),
                8.szH,
                Text(
                  LocaleKeys.loginSubtitle,
                  textAlign: TextAlign.center,
                  style: context.textStyle.s14.regular.setColor(
                    AppColors.gray500,
                  ),
                ),
                30.szH,
                FieldLabel(label: LocaleKeys.username),
                8.szH,
                AppTextField(
                  hint: LocaleKeys.enterUsername,
                  controller: usernameController,
                  keyboardType: TextInputType.text,
                  validator: (value) => Validators.validateName(
                    value,
                    fieldTitle: LocaleKeys.username,
                  ),
                ),
                20.szH,
                FieldLabel(label: LocaleKeys.password),
                8.szH,
                AppTextField(
                  hint: LocaleKeys.pleaseEnterYourPassword,
                  controller: passwordController,
                  obscureText: obscureText,
                  validator: (value) => Validators.validatePassword(
                    value,
                    fieldTitle: LocaleKeys.password,
                  ),
                  suffixIcon: IconButton(
                    onPressed: () =>
                        setState(() => obscureText = !obscureText),
                    icon: Icon(
                      obscureText
                          ? Icons.visibility_off_outlined
                          : Icons.visibility_outlined,
                      color: AppColors.gray500,
                      size: AppSize.sH20,
                    ),
                  ),
                ),
                Align(
                  alignment: AlignmentDirectional.topEnd,
                  child: TextButton(
                    onPressed: () {
                      Go.to(const ForgetPasswordScreen());
                    },
                    child: Text(
                      LocaleKeys.forgotPassword,
                      style: context.textStyle.s16.bold.setPrimaryColor,
                    ),
                  ),
                ),
                20.szH,
                LoadingButton(
                  title: LocaleKeys.login,
                  onTap: () async {
                    if (_formKey.currentState!.validate()) {
                      await context.read<LoginCubit>().login(
                        usernameController.text,
                        passwordController.text,
                      );
                    }
                  },
                ),
                30.szH,
              ],
            ),
          ),
        );
      },
    );
  }
}
