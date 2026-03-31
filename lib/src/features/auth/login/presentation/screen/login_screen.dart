part of '../../imports/login_imports.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultScaffold(
      header: const HeaderConfig(
        showBackButton: false,
        title: '',
        type: ScaffoldHeaderType.auth,
      ),
      slivers: [
        SliverToBoxAdapter(
          child: BlocProvider(
            create: (context) => injector<LoginCubit>(),
            child: const LoginBody(),
          ),
        ),
      ],
    );
  }
}
