import '../../imports/location_imports.dart';

class SelectLocationScreen extends StatelessWidget {
  const SelectLocationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => GetBaseEntityCubit<CountryEntity>()..fGetBaseNameAndId(),
        ),
        BlocProvider(create: (context) => GetBaseEntityCubit<CityEntity>()),
        BlocProvider(create: (context) => GetBaseEntityCubit<RegionEntity>()),
      ],
      child: DefaultScaffold(
        headerType: ScaffoldHeaderType.auth,
        title: LocaleKeys.setLocation,
        body: const SelectLocationBody(),
      ),
    );
  }
}
