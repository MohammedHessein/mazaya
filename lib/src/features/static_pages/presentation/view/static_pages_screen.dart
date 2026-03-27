part of '../imports/view_imports.dart';

class StaticPagesScreen extends StatelessWidget {
  final StaticPageTypeEnum pageType;

  const StaticPagesScreen({super.key, required this.pageType});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => injector<StaticPagesCubit>()
        ..fetchStaticPage(pageType),
      child: DefaultScaffold(
        title: pageType.title,
        body: StaticPagesBody(pageType: pageType),
      ),
    );
  }
}
