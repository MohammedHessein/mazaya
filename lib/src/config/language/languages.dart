import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'package:mazaya/src/core/navigation/navigator.dart';

enum Languages {
  english(Locale('en'), 'English', "en"),
  arabic(Locale('ar'), 'العربية', "ar"),
  swedish(Locale('sv'), 'Svenska', "sv");

  final String title;
  final Locale locale;
  final String languageCode;

  const Languages(this.locale, this.title, this.languageCode);

  static List<Locale> get supportLocales =>
      Languages.values.map((e) => e.locale).toList();

  static List<String> get titles =>
      Languages.values.map((e) => e.title).toList();

  static void setLocale(Languages lang) {
    Go.navigatorKey.currentContext!.setLocale(lang.locale);
  }

  static void setLocaleWithContext(BuildContext context, Languages lang) {
    context.setLocale(lang.locale);
  }

  static String getLanguageCode(Languages language) {
    return language.locale.languageCode;
  }

  static Languages get currentLanguage {
    try {
      final context = Go.navigatorKey.currentContext;
      if (context == null) return Languages.arabic;
      final easyLocale = EasyLocalization.of(context);
      if (easyLocale == null) return Languages.arabic;
      final currentLocale = easyLocale.locale;
      return Languages.values.firstWhere(
        (element) => element.locale == currentLocale,
        orElse: () => Languages.arabic,
      );
    } catch (_) {
      return Languages.arabic;
    }
  }
}
