part of '../../imports/forget_password_imports.dart';

class ForgetPasswordBody extends StatefulWidget {
  const ForgetPasswordBody({super.key});

  @override
  State<ForgetPasswordBody> createState() => _ForgetPasswordBodyState();
}

class _ForgetPasswordBodyState extends State<ForgetPasswordBody> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController usernameController = TextEditingController();

  @override
  void dispose() {
    usernameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ForgetPasswordCubit, AsyncState<String?>>(
      listener: (context, state) {
        if (state.isSuccess) {
          Go.to(OtpVerificationScreen(username: usernameController.text));
        }
      },
      builder: (context, state) {
        return SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: AppPadding.pW20),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                UniversalMediaWidget(path: AppAssets.svg.baseSvg.login.path),
                context.isArabic
                    ? Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: LocaleKeys.forgotPassword1,
                              style: context.textStyle.s20.bold,
                            ),
                            TextSpan(
                              text: LocaleKeys.forgotPassword2,
                              style: context.textStyle.s20.bold.setPrimaryColor,
                            ),
                          ],
                        ),
                      )
                    : Text(
                        LocaleKeys.forgotPassword,
                        style: context.textStyle.s20.bold.setPrimaryColor,
                      ),
                8.szH,
                Text(
                  LocaleKeys.forgotPasswordDesc,
                  textAlign: TextAlign.center,
                  style: context.textStyle.s14.regular.setHintColor,
                ),
                30.szH,
                FieldLabel(label: LocaleKeys.username),
                8.szH,
                AppTextField(
                  hint: LocaleKeys.enterUsername,
                  controller: usernameController,
                  validator: (value) => Validators.validateName(
                    value,
                    fieldTitle: LocaleKeys.username,
                  ),
                ),
                40.szH,
                LoadingButton(
                  title: LocaleKeys.next,
                  onTap: () async {
                    if (_formKey.currentState!.validate()) {
                      // await context.read<ForgetPasswordCubit>().fForgetPassword(
                      //       username: usernameController.text,
                      //     );
                      Go.to(
                        OtpVerificationScreen(
                          username: usernameController.text,
                        ),
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
