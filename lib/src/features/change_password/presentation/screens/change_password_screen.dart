part of '../../imports/change_password_imports.dart';

class ChangePasswordScreen extends StatelessWidget {
  const ChangePasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultScaffold(
      header: HeaderConfig(
        showBackButton: false,
        title: LocaleKeys.changePassword,
        type: ScaffoldHeaderType.standard,
      ),
      slivers: [
        SliverToBoxAdapter(
          child: BlocProvider(
            create: (context) => injector<ChangePasswordCubit>(),
            child: const ChangePasswordBody(),
          ),
        ),
      ],
    );
  }
}
