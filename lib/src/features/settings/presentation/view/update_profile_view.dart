part of '../imports/view_imports.dart';

class UpdateProfileScreen extends StatelessWidget {
  const UpdateProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => injector<UpdateProfileCubit>()),
        BlocProvider(
          create: (context) =>
              GetBaseEntityCubit<CountryEntity>()..fGetBaseNameAndId(),
        ),
        BlocProvider(create: (context) => GetBaseEntityCubit<CityEntity>()),
        BlocProvider(create: (context) => GetBaseEntityCubit<RegionEntity>()),
      ],
      child: DefaultScaffold(
        header: HeaderConfig(
          type: ScaffoldHeaderType.profile,
          title: LocaleKeys.settingsEditProfile,
          showBackButton: false,
        ),
        slivers: const [SliverToBoxAdapter(child: UpdateProfileBody())],
      ),
    );
  }
}
