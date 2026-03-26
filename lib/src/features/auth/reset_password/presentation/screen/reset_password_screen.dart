part of '../../imports/reset_password_imports.dart';

class ResetPasswordScreen extends StatelessWidget {
  final String username;
  final String code;
  const ResetPasswordScreen({
    super.key,
    required this.username,
    required this.code,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ResetPasswordCubit(),
      child: DefaultScaffold(
        headerType: ScaffoldHeaderType.auth,
        title: LocaleKeys.resetPasswordTitle,
        body: ResetPasswordBody(username: username, code: code),
      ),
    );
  }
}
