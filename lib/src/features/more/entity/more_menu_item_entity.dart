import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mazaya/src/config/language/languages.dart';
import 'package:mazaya/src/config/language/locale_keys.g.dart';
import 'package:mazaya/src/config/res/assets.gen.dart';
import 'package:mazaya/src/config/res/config_imports.dart';
import 'package:mazaya/src/core/navigation/navigator.dart';
import 'package:mazaya/src/core/network/api_endpoints.dart';
import 'package:mazaya/src/core/widgets/language/open_language_sheet.dart';
import 'package:mazaya/src/core/widgets/pickers/default_bottom_sheet.dart';
import 'package:mazaya/src/core/widgets/web_view/webview_screen.dart';
import 'package:mazaya/src/features/change_password/imports/change_password_imports.dart';
import 'package:mazaya/src/features/favourite/presentation/imports/view_imports.dart';
import 'package:mazaya/src/features/more/presentation/cubits/logout_cubit.dart';
import 'package:mazaya/src/features/more/presentation/widgets/delete_account_bottom_sheet.dart';
import 'package:mazaya/src/features/more/presentation/widgets/logout_bottom_sheet.dart';
import 'package:mazaya/src/features/more/presentation/imports/view_imports.dart';
import 'package:mazaya/src/features/used_coupons/presentation/imports/view_imports.dart';
import 'package:mazaya/src/features/complaints/presentation/imports/view_imports.dart';

class MoreItemEntity {
  final String title;
  final String icon;
  final void Function()? onTap;
  final bool disableArrow;
  final bool useSwitch;
  final String? trailingText;

  MoreItemEntity({
    required this.title,
    required this.icon,
    this.onTap,
    this.disableArrow = false,
    this.useSwitch = false,
    this.trailingText,
  });

  static List<MoreItemEntity> mainItems(BuildContext context) => [
    MoreItemEntity(
      title: LocaleKeys.settingsEditProfile,
      icon: AppAssets.svg.baseSvg.unlock.path,
      onTap: () => Go.to(const UpdateProfileScreen()),
    ),
    MoreItemEntity(
      title: LocaleKeys.settingsChangePassword,
      icon: AppAssets.svg.baseSvg.editProfile.path,
      onTap: () => Go.to(const ChangePasswordScreen()),
    ),
    MoreItemEntity(
      title: LocaleKeys.favourite,
      icon: AppAssets.svg.baseSvg.heart.path,
      onTap: () => Go.to(const FavouriteScreen()),
    ),
    MoreItemEntity(
      title: LocaleKeys.usedCoupons,
      icon: AppAssets.svg.baseSvg.usedCoupons.path,
      onTap: () => Go.to(const UsedCouponsScreen()),
    ),
    MoreItemEntity(
      title: LocaleKeys.settingsNotifications,
      icon: AppAssets.svg.baseSvg.notificationMore.path,
      useSwitch: true,
    ),
    MoreItemEntity(
      title: LocaleKeys.language,
      icon: AppAssets.svg.baseSvg.global.path,
      trailingText: Languages.currentLanguage.title,
      onTap: () => openLanguageSheet(context),
    ),
    MoreItemEntity(
      title: LocaleKeys.complaints,
      icon: AppAssets.svg.baseSvg.complaints.path,
      onTap: () => Go.to(const ComplaintsView()),
    ),
    MoreItemEntity(
      title: LocaleKeys.terms,
      icon: AppAssets.svg.baseSvg.bill.path,
      onTap: () => Go.to(
        WebViewScreen(
          url: ApiConstants.termsAndConditions,
          title: LocaleKeys.terms,
        ),
      ),
    ),
    MoreItemEntity(
      title: LocaleKeys.policy,
      icon: AppAssets.svg.baseSvg.securityUser.path,
      onTap: () => Go.to(
        WebViewScreen(
          url: ApiConstants.privacyPolicy,
          title: LocaleKeys.policy,
        ),
      ),
    ),
  ];

  static MoreItemEntity get deleteAccountItem => MoreItemEntity(
    title: LocaleKeys.settingsDeleteAccount,
    icon: AppAssets.svg.baseSvg.profileDelete.path,
    onTap: () => showDefaultBottomSheet(
      child: BlocProvider(
        create: (context) =>
            injector<
              DeleteAccountCubit
            >(), // Since we refactored DeleteAccountCubit in settings
        child: const DeleteAccountBottomSheet(),
      ),
    ),
  );

  static MoreItemEntity get logoutItem => MoreItemEntity(
    title: LocaleKeys.logout,
    icon: AppAssets.svg.baseSvg.logout.path,
    onTap: () => showDefaultBottomSheet(
      child: BlocProvider(
        create: (context) => injector<LogoutCubit>(),
        child: const LogoutBottomSheet(),
      ),
    ),
  );
}
