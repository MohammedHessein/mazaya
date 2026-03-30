import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mazaya/src/config/language/locale_keys.g.dart';
import 'package:mazaya/src/config/res/assets.gen.dart';
import 'package:mazaya/src/core/notification/notification_service.dart';
import 'package:mazaya/src/core/widgets/navigation_bar/navigation_bar.dart';
import 'package:mazaya/src/core/widgets/scaffolds/sliver_scaffold_body.dart';
import 'package:mazaya/src/features/main/entity/main_params.dart';

import '../../../../config/res/config_imports.dart';
import '../../../../core/widgets/universal_media/enums.dart';
import '../../../home/presentation/view/home_screen.dart';
import '../../../more/presentation/imports/view_imports.dart';
import '../../../coupons/presentation/view/coupons_view.dart';
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
              // Tab 0: Home
              SliverScaffoldBody(
                headerType: ScaffoldHeaderType.home,
                imageUrl: AppAssets.svg.baseSvg.profile.path,
                userName: 'محمد حسين',
                showBackButton: false,
                title: '',
                slivers: const [HomeScreen()],
                extendBody: true,
              ),
              // Tab 1: Coupons
              SliverScaffoldBody(
                headerType: ScaffoldHeaderType.standard,
                imageUrl: AppAssets.svg.baseSvg.profile.path,
                userName: 'محمد حسين',
                showBackButton: false,
                title: LocaleKeys.couponsTitle.tr(),
                slivers: const [CouponsView()],
                extendBody: true,
              ),
              // Tab 2: Scan
              MainBody(2),
              // Tab 3: More
              SliverScaffoldBody(
                headerType: ScaffoldHeaderType.profile,
                imageUrl: AppAssets.svg.baseSvg.profile.path,
                userName: 'محمد حسين',
                showBackButton: false,
                title: '',
                slivers: const [MoreTabBody()],
                extendBody: true,
              ),
            ],
          ),
        );
      },
    );
  }
}
