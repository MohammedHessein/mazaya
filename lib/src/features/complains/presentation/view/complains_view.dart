part of '../imports/view_imports.dart';

class ComplainsScreen extends StatelessWidget {
  const ComplainsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => injector<ComplainsCubit>()..fetchComplains(),
      child: DefaultScaffold(
        title: LocaleKeys.complaintsTitle,
        body: const _ComplainsBody(),
      ),
    );
  }
}
