part of '../../imports/change_password_imports.dart';

class ChangePasswordScreen extends StatelessWidget {
  const ChangePasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultScaffold(
      showBackButton: true,
      title: LocaleKeys.changePassword,
      headerType: ScaffoldHeaderType.standard,
      body: BlocProvider(
        create: (context) => injector<ChangePasswordCubit>(),
        child: const ChangePasswordBody(),
      ),
    );
  }
}
