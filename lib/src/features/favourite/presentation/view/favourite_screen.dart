part of '../imports/view_imports.dart';

class FavouriteScreen extends StatelessWidget {
  const FavouriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => injector<FavouriteCubit>()..fetchInitialData(),
      child: const FavouriteBody(),
    );
  }
}
