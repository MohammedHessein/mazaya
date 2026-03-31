import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mazaya/src/config/language/locale_keys.g.dart';
import 'package:mazaya/src/config/res/config_imports.dart';
import 'package:mazaya/src/core/base_crud/code/domain/base_domain_imports.dart';
import 'package:mazaya/src/core/base_crud/code/presentation/cubit/get_base_name_and_id/get_base_name_and_id_cubit.dart';
import 'package:mazaya/src/core/widgets/scaffolds/default_scaffold.dart';
import 'package:mazaya/src/core/widgets/scaffolds/header_config.dart';
import 'package:mazaya/src/features/coupons/presentation/cubits/coupons_cubit.dart';
import 'package:mazaya/src/features/coupons/presentation/widgets/coupons_body.dart';

class CouponsView extends StatelessWidget {
  const CouponsView({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<CouponsCubit>(
          create: (context) => injector<CouponsCubit>()..fetchInitialData(),
        ),
        BlocProvider<GetBaseEntityCubit<CityEntity>>(
          create: (context) => GetBaseEntityCubit<CityEntity>(),
        ),
        BlocProvider<GetBaseEntityCubit<CategoryEntity>>(
          create: (context) =>
              GetBaseEntityCubit<CategoryEntity>()..fGetBaseNameAndId(),
        ),
      ],
      child: DefaultScaffold(
        header: HeaderConfig(title: LocaleKeys.coupons, showBackButton: false),
        slivers: const [CouponsBody()],
      ),
    );
  }
}
