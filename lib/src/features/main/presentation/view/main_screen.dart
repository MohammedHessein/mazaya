import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mazaya/src/config/language/locale_keys.g.dart';
import 'package:mazaya/src/config/res/assets.gen.dart';
import 'package:mazaya/src/core/notification/notification_service.dart';
import 'package:mazaya/src/core/widgets/navigation_bar/navigation_bar.dart';
import 'package:mazaya/src/core/widgets/scaffolds/default_scaffold.dart';
import 'package:mazaya/src/features/main/entity/main_params.dart';

import '../../../../config/res/config_imports.dart';
import '../../../../core/widgets/universal_media/enums.dart';
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
        String title = '';
        ScaffoldHeaderType headerType = ScaffoldHeaderType.home;

        if (value == 2) {
          return Scaffold(
            body: MainBody(value),
            bottomNavigationBar: CustomNavigationBar(
              selectedIndex: value,
              onTabChange: (newIndex) => params.updateNavValue(newIndex),
              tabs: params.navTabs,
            ),
          );
        }

        switch (value) {
          case 0:
            headerType = ScaffoldHeaderType.home;
            break;
          case 1:
            headerType = ScaffoldHeaderType.standard;
            title = LocaleKeys.couponsTitle;
            break;
          case 3:
            headerType = ScaffoldHeaderType.profile;
            break;
          default:
            headerType = ScaffoldHeaderType.home;
        }

        return DefaultScaffold(
          title: title,
          headerType: headerType,
          showBackButton: false,
          userName: 'محمد حسين',
          imageUrl: AppAssets.svg.baseSvg.profile.path,
          extendBody: true,
          body: MainBody(value),
          bottomNavigationBar: CustomNavigationBar(
            selectedIndex: value,
            onTabChange: (newIndex) => params.updateNavValue(newIndex),
            tabs: params.navTabs,
          ),
        );
      },
    );
  }
}
