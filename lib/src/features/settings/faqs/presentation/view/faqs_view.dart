part of '../imports/view_imports.dart';

class FaqsScreen extends StatelessWidget {
  const FaqsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => injector<FaqsCubit>()
        ..fetchFaqs(),
      child: DefaultScaffold(
        title: LocaleKeys.faqs,
        body: const _FaqsBody(),
      ),
    );
  }
}
