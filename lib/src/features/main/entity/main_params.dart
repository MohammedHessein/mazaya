import 'package:flutter/material.dart';
import 'package:mazaya/src/config/language/locale_keys.g.dart';
import 'package:mazaya/src/config/res/assets.gen.dart';
import 'package:mazaya/src/config/res/config_imports.dart';
import 'package:mazaya/src/core/shared/cubits/user_cubit/user_cubit.dart';
import 'package:mazaya/src/core/widgets/navigation_bar/navigation_bar_entity.dart';

class MainParams {
  MainParams({int initialIndex = 0})
    : selectedIndexNotifier = ValueNotifier<int>(initialIndex);

  final ValueNotifier<int> selectedIndexNotifier;

  void dispose() => selectedIndexNotifier.dispose();

  String visitorDesc(int value) {
    switch (value) {
      case 1:
        return LocaleKeys.home;
      case 2:
        return LocaleKeys.home;
      case 3:
        return LocaleKeys.home;
      default:
        return ConstantManager.emptyText;
    }
  }

  void updateNavValue(int value) {
    if (value == 0 || value == 1) {
      selectedIndexNotifier.value = value;
    } else if (value == 2) {
      if (UserCubit.instance.checkMembership()) {
        selectedIndexNotifier.value = value;
      }
    } else {
      if (UserCubit.instance.checkAuth()) {
        selectedIndexNotifier.value = value;
      }
    }
  }

  List<NavigationBarEntity> get navTabs => [
    NavigationBarEntity(
      text: LocaleKeys.home,
      icon: AppAssets.svg.baseSvg.inactiveHome.path,
      activeIcon: AppAssets.svg.baseSvg.activeHome.path,
    ),
    NavigationBarEntity(
      text: LocaleKeys.coupons,
      icon: AppAssets.svg.baseSvg.inactiveCoupons.path,
      activeIcon: AppAssets.svg.baseSvg.activeCoupons.path,
    ),
    NavigationBarEntity(
      text: LocaleKeys.scan,
      icon: AppAssets.svg.baseSvg.inactiveScanner.path,
      activeIcon: AppAssets.svg.baseSvg.activeScanner.path,
    ),
    NavigationBarEntity(
      text: LocaleKeys.myAccount,
      icon: AppAssets.svg.baseSvg.inactiveMore.path,
      activeIcon: AppAssets.svg.baseSvg.activeMore.path,
    ),
  ];
}
