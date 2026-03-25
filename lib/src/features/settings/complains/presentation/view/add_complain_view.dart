part of '../imports/view_imports.dart';

class AddComplainScreen extends StatelessWidget {
  const AddComplainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => injector<AddComplainCubit>(),
      child: DefaultScaffold(
        title: LocaleKeys.complaintsAddBtn,
        body: const _AddComplainBody(),
      ),
    );
  }
}
