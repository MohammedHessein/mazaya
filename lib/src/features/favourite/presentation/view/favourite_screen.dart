part of '../imports/view_imports.dart';

class FavouriteScreen extends StatefulWidget {
  const FavouriteScreen({super.key});

  @override
  State<FavouriteScreen> createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends State<FavouriteScreen> {
  late final FavouriteCubit _cubit;

  @override
  void initState() {
    super.initState();
    _cubit = injector<FavouriteCubit>();
    _cubit.fetchInitialData();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _cubit,
      child: const FavouriteBody(),
    );
  }
}
