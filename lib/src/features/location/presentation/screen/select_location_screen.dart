import 'package:mazaya/src/features/location/imports/location_imports.dart';

class SelectLocationScreen extends StatelessWidget {
  const SelectLocationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              GetBaseEntityCubit<CountryEntity>()..fGetBaseNameAndId(),
        ),
        BlocProvider(create: (context) => GetBaseEntityCubit<CityEntity>()),
        BlocProvider(create: (context) => GetBaseEntityCubit<RegionEntity>()),
      ],
      child: DefaultScaffold(
        header: HeaderConfig(
          type: ScaffoldHeaderType.auth,
          showBackButton: false,
        ),
        slivers: const [SliverToBoxAdapter(child: SelectLocationBody())],
      ),
    );
  }
}
