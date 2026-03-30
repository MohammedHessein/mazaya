import 'package:mazaya/src/core/navigation/navigator.dart';
import 'package:mazaya/src/config/language/locale_keys.g.dart';
import 'package:mazaya/src/config/res/assets.gen.dart';
import 'package:mazaya/src/features/more/entity/more_menu_item_entity.dart';
import 'package:mazaya/src/features/settings/presentation/imports/view_imports.dart';
import 'package:mazaya/src/features/change_password/imports/change_password_imports.dart';

class SettingsItemEntity {
  static List<MoreItemEntity> get generalItems => [
    MoreItemEntity(
      title: LocaleKeys.settingsEditProfile,
      icon: AppAssets.svg.baseSvg.profile.path,
      // onTap: () => Go.to(const ProfileScreen(ProfileEnum.updateProfile)),
      onTap: () {},
    ),
    MoreItemEntity(
      title: LocaleKeys.settingsChangeEmail,
      icon: AppAssets.svg.baseSvg.changeEmail.path,
      // onTap: () => Go.to(const VerifyPasswordScreen()),
      onTap: () {},
    ),
    MoreItemEntity(
      title: LocaleKeys.settingsChangePassword,
      icon: AppAssets.svg.baseSvg.changePass.path,
      onTap: () => Go.to(const ChangePasswordScreen()),
    ),
    MoreItemEntity(
      title: LocaleKeys.settingsNotifications,
      icon: AppAssets.svg.baseSvg.notify.path,
      useSwitch: true,
      onTap: () {},
    ),
    // MoreItemEntity(
    //   title: LocaleKeys.settingsLanguages,
    //   icon: AppAssets.svg.selectLang.path,
    //   onTap: () async => await languageModelSheet(),
    // ),
    MoreItemEntity(
      title: LocaleKeys.settingsDeleteAccount,
      icon: AppAssets.svg.baseSvg.deleteAll.path,
      onTap: () async => await deleteAccountModelSheet(),
    ),
  ];
}
