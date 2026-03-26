import 'package:flutter/material.dart';
import 'package:mazaya/src/core/navigation/navigator.dart';

import '../../../config/language/languages.dart';
import 'language_bottom_sheet.dart';

Future<void> openLanguageSheet(BuildContext context) async {
  await showModalBottomSheet<Languages>(
    context: context,
    backgroundColor: Colors.transparent,
    builder: (sheetContext) {
      return LanguageBottomSheet(
        onArabicTap: () {
          Languages.setLocaleWithContext(sheetContext, Languages.arabic);
          Go.back();
        },
        onEnglishTap: () {
          Languages.setLocaleWithContext(sheetContext, Languages.english);
          Go.back();
        },
      );
    },
  );
}
