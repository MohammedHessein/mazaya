part of '../imports/view_imports.dart';

class UpdateProfileScreen extends StatefulWidget {
  const UpdateProfileScreen({super.key});

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  @override
  void initState() {
    super.initState();
    UserCubit.instance.getProfile();
  }

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
