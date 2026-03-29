part of '../../imports/login_imports.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultScaffold(
      showBackButton: true,
      title: '',
      headerType: ScaffoldHeaderType.auth,
      body: BlocProvider(
        create: (context) => injector<LoginCubit>(),
        child: const LoginBody(),
      ),
    );
  }
}
