import 'package:flutter/material.dart';
import '../../../../../config/language/locale_keys.g.dart';
import '../../../../../config/res/assets.gen.dart';
import '../../../../../core/navigation/navigator.dart';
import '../../../../settings/complains/presentation/imports/view_imports.dart';
import '../../../../settings/contact_us/presentation/imports/contact_us_imports.dart';
import '../../../../settings/faqs/presentation/imports/view_imports.dart';
import '../../../../settings/static_pages/entity/static_pages_enum.dart';
import '../../../../settings/static_pages/presentation/imports/view_imports.dart';
import '../presentation/imports/view_imports.dart';

class MoreItemEntity {
  final String title;
  final String icon;
  final VoidCallback onTap;
  final bool disableArrow;
  final bool useSwitch;

  MoreItemEntity({
    required this.title,
    required this.icon,
    required this.onTap,
    this.disableArrow = false,
    this.useSwitch = false,
  });

  static List<MoreItemEntity> get generalItems => [
    MoreItemEntity(
      title: LocaleKeys.profile,
      icon: AppAssets.svg.appSvg.home.path,
      // onTap: () => Go.to(const ProfileInfoScreen()),
      onTap: () {},
    ),
  ];

  /// Others section menu items
  static List<MoreItemEntity> get otherItems => [
    MoreItemEntity(
      title: LocaleKeys.whoUs,
      icon: AppAssets.svg.appSvg.home.path,
      onTap: () => Go.to(
        const StaticPagesScreen(pageType: StaticPageTypeEnum.aboutRita),
      ),
    ),
    MoreItemEntity(
      title: LocaleKeys.contactUs,
      icon: AppAssets.svg.appSvg.home.path,
      onTap: () => Go.to(const ContactUsScreen()),
    ),
    MoreItemEntity(
      title: LocaleKeys.complaints,
      icon: AppAssets.svg.appSvg.home.path,
      onTap: () => Go.to(const ComplainsScreen()),
    ),
    MoreItemEntity(
      title: LocaleKeys.terms,
      icon: AppAssets.svg.appSvg.home.path,
      onTap: () => Go.to(
        const StaticPagesScreen(
          pageType: StaticPageTypeEnum.termsAndConditions,
        ),
      ),
    ),
    MoreItemEntity(
      title: LocaleKeys.policy,
      icon: AppAssets.svg.appSvg.home.path,
      onTap: () => Go.to(
        const StaticPagesScreen(pageType: StaticPageTypeEnum.usagePolicy),
      ),
    ),
    MoreItemEntity(
      title: LocaleKeys.faqs,
      icon: AppAssets.svg.appSvg.home.path,
      onTap: () => Go.to(const FaqsScreen()),
    ),
    MoreItemEntity(
      title: LocaleKeys.logout,
      icon: AppAssets.svg.appSvg.home.path,
      disableArrow: true,
      onTap: () async => await logOut(),
    ),
  ];

  /// Others section menu items
  static List<MoreItemEntity> get guestItems => [
    MoreItemEntity(
      title: LocaleKeys.whoUs,
      icon: AppAssets.svg.appSvg.home.path,
      onTap: () => Go.to(
        const StaticPagesScreen(pageType: StaticPageTypeEnum.aboutRita),
      ),
    ),
    MoreItemEntity(
      title: LocaleKeys.contactUs,
      icon: AppAssets.svg.appSvg.home.path,
      onTap: () => Go.to(const ContactUsScreen()),
    ),
    MoreItemEntity(
      title: LocaleKeys.complaints,
      icon: AppAssets.svg.appSvg.home.path,
      onTap: () => Go.to(const ComplainsScreen()),
    ),
    MoreItemEntity(
      title: LocaleKeys.terms,
      icon: AppAssets.svg.appSvg.home.path,
      onTap: () => Go.to(
        const StaticPagesScreen(
          pageType: StaticPageTypeEnum.termsAndConditions,
        ),
      ),
    ),
    MoreItemEntity(
      title: LocaleKeys.policy,
      icon: AppAssets.svg.appSvg.home.path,
      onTap: () => Go.to(
        const StaticPagesScreen(pageType: StaticPageTypeEnum.usagePolicy),
      ),
    ),
    MoreItemEntity(
      title: LocaleKeys.faqs,
      icon: AppAssets.svg.appSvg.home.path,
      onTap: () => Go.to(const FaqsScreen()),
    ),
    MoreItemEntity(
      title: LocaleKeys.logout,
      icon: AppAssets.svg.appSvg.home.path,
      disableArrow: true,
      onTap: () async => await logOut(),
    ),
  ];
}
