import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mazaya/src/config/language/locale_keys.g.dart';
import 'package:mazaya/src/config/res/assets.gen.dart';
import 'package:mazaya/src/core/notification/notification_service.dart';
import 'package:mazaya/src/core/shared/cubits/user_cubit/user_cubit.dart';
import 'package:mazaya/src/core/widgets/navigation_bar/navigation_bar.dart';
import 'package:mazaya/src/core/widgets/scaffolds/app_header_sliver.dart';
import 'package:mazaya/src/core/widgets/scaffolds/header_config.dart';
import 'package:mazaya/src/features/main/entity/main_params.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../config/res/config_imports.dart';
import '../../../../core/widgets/universal_media/enums.dart';
import '../../../coupons/presentation/widgets/coupons_body.dart';
import '../../../coupons/presentation/cubits/coupons_cubit.dart';
import '../../../home/presentation/view/home_screen.dart';
import '../../../../core/base_crud/code/domain/base_domain_imports.dart';
import '../../../../core/base_crud/code/presentation/cubit/get_base_name_and_id/get_base_name_and_id_cubit.dart';
import '../../../more/presentation/imports/view_imports.dart';
import '../widgets/main_body.dart';

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
    initNotifications();
  }

  void initNotifications() {
    NotificationNavigator();
    injector<NotificationService>().setupNotifications();
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
        return Scaffold(
          extendBody: true,
          bottomNavigationBar: CustomNavigationBar(
            selectedIndex: value,
            onTabChange: (newIndex) => params.updateNavValue(newIndex),
            tabs: params.navTabs,
          ),
          body: IndexedStack(
            index: value,
            children: [
              CustomScrollView(
                physics: const BouncingScrollPhysics(),
                slivers: [
                  AppHeaderSliver(
                    config: HeaderConfig(
                      type: ScaffoldHeaderType.home,
                      imageUrl: AppAssets.svg.baseSvg.profile.path,
                      userName: UserCubit.instance.user.name,
                      showBackButton: false,
                    ),
                  ),
                  const HomeScreen(),
                  const SliverToBoxAdapter(child: SizedBox(height: 100)),
                ],
              ),
              MultiBlocProvider(
                providers: [
                  BlocProvider<CouponsCubit>(
                    create: (context) =>
                        injector<CouponsCubit>()..fetchInitialData(),
                  ),
                  BlocProvider<GetBaseEntityCubit<CityEntity>>(
                    create: (context) => GetBaseEntityCubit<CityEntity>(),
                  ),
                  BlocProvider<GetBaseEntityCubit<CategoryEntity>>(
                    create: (context) =>
                        GetBaseEntityCubit<CategoryEntity>()
                          ..fGetBaseNameAndId(),
                  ),
                ],
                child: CustomScrollView(
                  physics: const BouncingScrollPhysics(),
                  slivers: [
                    AppHeaderSliver(
                      config: HeaderConfig(
                        type: ScaffoldHeaderType.standard,
                        imageUrl: AppAssets.svg.baseSvg.profile.path,
                        userName: 'محمد حسين',
                        showBackButton: false,
                        title: LocaleKeys.couponsTitle.tr(),
                      ),
                    ),
                    const CouponsBody(),
                    const SliverToBoxAdapter(child: SizedBox(height: 100)),
                  ],
                ),
              ),
              MainBody(2),
              CustomScrollView(
                clipBehavior: Clip.none,
                physics: const BouncingScrollPhysics(),
                slivers: [
                  const ProfileHeaderSliver(),
                  const MoreTabBody(),
                  const SliverToBoxAdapter(child: SizedBox(height: 100)),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
