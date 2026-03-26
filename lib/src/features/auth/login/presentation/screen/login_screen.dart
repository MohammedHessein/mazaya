part of '../../imports/login_imports.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const DefaultScaffold(
      showBackButton: true,
      title: '',
      headerType: ScaffoldHeaderType.auth,
      body: LoginBody(),
    );
  }
}
