import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mazaya/src/config/language/locale_keys.g.dart';
import 'package:mazaya/src/config/res/config_imports.dart';
import 'package:mazaya/src/core/base_crud/code/domain/base_domain_imports.dart';
import 'package:mazaya/src/core/base_crud/code/presentation/cubit/get_base_name_and_id/get_base_name_and_id_cubit.dart';
import 'package:mazaya/src/core/shared/cubits/user_cubit/user_cubit.dart';
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
          lazy: false,
          create: (context) => injector<CouponsCubit>()..fetchInitialData(),
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
      ],
      child: BlocListener<UserCubit, UserState>(
        listenWhen: (prev, curr) =>
            prev.selectedCity?.id != curr.selectedCity?.id ||
            prev.selectedCountry?.id != curr.selectedCountry?.id,
        listener: (context, state) {
          final parentId = state.selectedCity?.id;
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
            return DefaultScaffold(
              header: HeaderConfig(
                title: LocaleKeys.couponsTitle.tr(),
                showBackButton: false,
              ),
              slivers: [const CouponsBody()],
            );
          },
        ),
      ),
    );
  }
}
