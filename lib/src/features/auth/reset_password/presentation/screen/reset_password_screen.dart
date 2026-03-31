part of '../../imports/reset_password_imports.dart';

class ResetPasswordScreen extends StatelessWidget {
  final String email;
  final String code;
  const ResetPasswordScreen({
    super.key,
    required this.email,
    required this.code,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ResetPasswordCubit(),
      child: DefaultScaffold(
        header: HeaderConfig(
          showBackButton: false,
          type: ScaffoldHeaderType.auth,
          title: LocaleKeys.resetPasswordTitle,
        ),
        slivers: [
          SliverToBoxAdapter(
            child: ResetPasswordBody(email: email, code: code),
          ),
        ],
      ),
    );
  }
}
