part of '../imports/view_imports.dart';

class ComplainDetailsScreen extends StatelessWidget {
  final int id;
  const ComplainDetailsScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => injector<ComplainsDetailsCubit>()
        ..complainDetails(id),
      child: DefaultScaffold(
        title: LocaleKeys.complaintsDetailsTitle,
        body: const _ComplainsDetailsBody(),
      ),
    );
  }
}
