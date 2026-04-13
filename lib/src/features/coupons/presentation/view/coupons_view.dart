import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mazaya/src/config/language/locale_keys.g.dart';
import 'package:mazaya/src/config/res/config_imports.dart';
import 'package:mazaya/src/core/base_crud/code/domain/base_domain_imports.dart';
import 'package:mazaya/src/core/base_crud/code/presentation/cubit/get_base_name_and_id/get_base_name_and_id_cubit.dart';
import 'package:mazaya/src/core/shared/cubits/user_cubit/user_cubit.dart';
import 'package:mazaya/src/core/widgets/scaffolds/app_header_sliver.dart';
import 'package:mazaya/src/core/widgets/scaffolds/header_config.dart';
import 'package:mazaya/src/features/coupons/presentation/cubits/coupons_cubit.dart';
import 'package:mazaya/src/features/coupons/presentation/widgets/coupons_body.dart';
import 'package:mazaya/src/features/home/presentation/cubits/home_cubit.dart';

class CouponsView extends StatefulWidget {
  const CouponsView({super.key});

  @override
  State<CouponsView> createState() => _CouponsViewState();
}

class _CouponsViewState extends State<CouponsView> {
  late final CouponsCubit _cubit;

  @override
  void initState() {
    super.initState();
    _cubit = injector<CouponsCubit>();
    _cubit.fetchInitialData();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: _cubit),
        BlocProvider<GetBaseEntityCubit<CountryEntity>>(
          lazy: false,
          create: (context) =>
              GetBaseEntityCubit<CountryEntity>()..fGetBaseNameAndId(),
        ),
        BlocProvider<GetBaseEntityCubit<CityEntity>>(
          lazy: false,
          create: (context) {
            final userState = context.read<UserCubit>().state;
            final countryId = userState.selectedCountry?.id;
            return GetBaseEntityCubit<CityEntity>()
              ..fGetBaseNameAndId(id: countryId);
          },
        ),
        BlocProvider<GetBaseEntityCubit<RegionEntity>>(
          lazy: false,
          create: (context) {
            final userState = context.read<UserCubit>().state;
            final parentId = userState.selectedCity?.id;

            return GetBaseEntityCubit<RegionEntity>()
              ..fGetBaseNameAndId(id: parentId);
          },
        ),
        BlocProvider<GetBaseEntityCubit<CategoryEntity>>(
          lazy: false,
          create: (context) =>
              GetBaseEntityCubit<CategoryEntity>()..fGetBaseNameAndId(),
        ),
        BlocProvider.value(value: injector<HomeCubit>()),
      ],
      child: BlocListener<UserCubit, UserState>(
        listenWhen: (prev, curr) =>
            prev.selectedCity?.id != curr.selectedCity?.id ||
            prev.selectedCountry?.id != curr.selectedCountry?.id,
        listener: (context, state) {
          final parentId = state.selectedCity?.id;

          // Refresh City only if we have a valid country
          if (state.selectedCountry?.id != null) {
            context.read<GetBaseEntityCubit<CityEntity>>().fGetBaseNameAndId(
              id: state.selectedCountry?.id,
            );
          }

          if (parentId != null) {
            context.read<GetBaseEntityCubit<RegionEntity>>().fGetBaseNameAndId(
              id: parentId,
            );
          }
          context
              .read<GetBaseEntityCubit<CategoryEntity>>()
              .fGetBaseNameAndId();
          context.read<CouponsCubit>().fetchInitialData();
        },
        child: Builder(
          builder: (context) {
            return Scaffold(
              body: RefreshIndicator(
                onRefresh: () async => context.read<CouponsCubit>().refresh(),
                color: AppColors.primary,
                child: CustomScrollView(
                  physics: const BouncingScrollPhysics(
                    parent: AlwaysScrollableScrollPhysics(),
                  ),
                  slivers: [
                    AppHeaderSliver(
                      config: HeaderConfig(
                        title: LocaleKeys.couponsTitle,
                        showBackButton: false,
                      ),
                    ),
                    const CouponsBody(),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
