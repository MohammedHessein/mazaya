import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mazaya/src/config/language/locale_keys.g.dart';
import 'package:mazaya/src/config/res/assets.gen.dart';
import 'package:mazaya/src/core/shared/cubits/user_cubit/user_cubit.dart';
import 'package:mazaya/src/core/widgets/navigation_bar/navigation_bar.dart';
import 'package:mazaya/src/core/widgets/scaffolds/app_header_sliver.dart';
import 'package:mazaya/src/core/widgets/scaffolds/header_config.dart';
import 'package:mazaya/src/features/main/entity/main_params.dart';
import 'package:mazaya/src/core/widgets/dialogs/exit_app_bottom_sheet.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mazaya/src/config/res/config_imports.dart';
import 'package:mazaya/src/core/widgets/universal_media/enums.dart';
import 'package:mazaya/src/features/coupons/presentation/widgets/coupons_body.dart';
import 'package:mazaya/src/features/coupons/presentation/cubits/coupons_cubit.dart';
import 'package:mazaya/src/features/home/presentation/view/home_screen.dart';
import 'package:mazaya/src/features/home/presentation/cubits/home_cubit.dart';
import 'package:mazaya/src/core/base_crud/code/domain/base_domain_imports.dart';
import 'package:mazaya/src/core/base_crud/code/presentation/cubit/get_base_name_and_id/get_base_name_and_id_cubit.dart';
import 'package:mazaya/src/features/more/presentation/imports/view_imports.dart';
import 'package:mazaya/src/features/main/presentation/widgets/main_body.dart';

class MainScreen extends StatefulWidget {
  final int initialTabIndex;
  const MainScreen({super.key, this.initialTabIndex = 0});

  @override
  State<MainScreen> createState() => MainScreenState();
}

class MainScreenState extends State<MainScreen> with WidgetsBindingObserver {
  late final MainParams params = MainParams(
    initialIndex: widget.initialTabIndex,
  );

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    params.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.locale;
    return ValueListenableBuilder<int>(
      valueListenable: params.selectedIndexNotifier,
      builder: (context, value, child) {
        return PopScope(
          canPop: false,
          onPopInvokedWithResult: (didPop, result) async {
            if (didPop) return;
            
            if (value != 0) {
              // Go to home if not on home
              params.updateNavValue(0);
            } else {
              // Show exit confirmation if on home
              await showExitAppBottomSheet();
            }
          },
          child: Scaffold(
            bottomNavigationBar: CustomNavigationBar(
              selectedIndex: value,
              onTabChange: (newIndex) => params.updateNavValue(newIndex),
              tabs: params.navTabs,
            ),
            body: BlocProvider(
              create: (context) => injector<UpdatePhotoCubit>(),
              child: IndexedStack(
                index: value,
                children: [
                  BlocProvider<HomeCubit>(
                    create: (context) => injector<HomeCubit>()..getHomeData(),
                    child: BlocListener<UserCubit, UserState>(
                      listenWhen: (prev, curr) =>
                          prev.selectedCity?.id != curr.selectedCity?.id ||
                          prev.selectedCountry?.id != curr.selectedCountry?.id,
                      listener: (context, state) {
                        context.read<HomeCubit>().getHomeData();
                      },
                      child: Builder(
                        builder: (context) {
                          return RefreshIndicator(
                            onRefresh: () =>
                                context.read<HomeCubit>().getHomeData(),
                            color: AppColors.primary,
                            child: CustomScrollView(
                              physics: const BouncingScrollPhysics(
                                parent: AlwaysScrollableScrollPhysics(),
                              ),
                              slivers: [
                                BlocBuilder<UserCubit, UserState>(
                                  builder: (context, state) {
                                    return AppHeaderSliver(
                                      config: HeaderConfig(
                                        type: ScaffoldHeaderType.home,
                                        imageUrl: AppAssets.svg.baseSvg.profile.path,
                                        userName: state.userModel.name,
                                        showBackButton: false,
                                      ),
                                    );
                                  }
                                ),
                                const HomeScreen(),
                                const SliverToBoxAdapter(
                                  child: SizedBox(height: 100),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  MultiBlocProvider(
                    providers: [
                      BlocProvider<CouponsCubit>(
                        lazy: false,
                        create: (context) =>
                            injector<CouponsCubit>()..fetchInitialData(),
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
                            GetBaseEntityCubit<CategoryEntity>()
                              ..fGetBaseNameAndId(),
                      ),
                    ],
                    child: BlocListener<UserCubit, UserState>(
                      listenWhen: (prev, curr) =>
                          prev.selectedCity?.id != curr.selectedCity?.id ||
                          prev.selectedCountry?.id != curr.selectedCountry?.id,
                      listener: (context, state) {
                        final parentId = state.selectedCity?.id;
                        
                        // Refresh Region/Municipality only if we have a valid parent
                        if (parentId != null) {
                          context
                              .read<GetBaseEntityCubit<RegionEntity>>()
                              .fGetBaseNameAndId(id: parentId);
                        }
                            
                        // Refresh Categories
                        context
                            .read<GetBaseEntityCubit<CategoryEntity>>()
                            .fGetBaseNameAndId();
                            
                        // Also refresh the coupons themselves
                        context.read<CouponsCubit>().fetchInitialData();
                      },
                      child: Builder(
                        builder: (context) {
                          return CustomScrollView(
                            physics: const BouncingScrollPhysics(),
                            slivers: [
                              BlocBuilder<UserCubit, UserState>(
                                builder: (context, state) {
                                  return AppHeaderSliver(
                                    config: HeaderConfig(
                                      type: ScaffoldHeaderType.standard,
                                      imageUrl: AppAssets.svg.baseSvg.profile.path,
                                      userName: state.userModel.name,
                                      showBackButton: false,
                                      title: LocaleKeys.couponsTitle.tr(),
                                    ),
                                  );
                                }
                              ),
                              const CouponsBody(),
                              const SliverToBoxAdapter(child: SizedBox(height: 100)),
                            ],
                          );
                        }
                      ),
                    ),
                  ),
                  MainBody(2, currentIndex: value),
                  CustomScrollView(
                    physics: const BouncingScrollPhysics(),
                    slivers: [
                      const ProfileHeaderSliver(),
                      const MoreTabBody(),
                      const SliverToBoxAdapter(child: SizedBox(height: 100)),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
