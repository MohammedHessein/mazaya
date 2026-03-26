part of '../../imports/forget_password_imports.dart';

class ForgetPasswordScreen extends StatelessWidget {
  const ForgetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ForgetPasswordCubit(),
      child: DefaultScaffold(
        headerType: ScaffoldHeaderType.auth,
        title: LocaleKeys.forgotPassword,
        body: const ForgetPasswordBody(),
      ),
    );
  }
}
