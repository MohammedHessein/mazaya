import 'package:flutter/material.dart';

import 'package:mazaya/src/config/language/languages.dart';
import 'package:mazaya/src/config/res/config_imports.dart';
import 'package:mazaya/src/core/extensions/context_extension.dart';
import 'package:mazaya/src/core/extensions/text_style_extensions.dart';

class LanguageOption extends StatelessWidget {
  final Languages language;
  final bool isSelected;
  final VoidCallback onTap;

  const LanguageOption({
    super.key,
    required this.language,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final String label = language == Languages.arabic
        ? ConstantManager.arabic
        : ConstantManager.english;

    final Color bg = isSelected ? AppColors.blue50 : AppColors.white;
    final Color borderColor = isSelected
        ? AppColors.primary
        : AppColors.lightGray;
    final Color textColor = isSelected
        ? AppColors.primary
        : AppColors.placeholder;
    final IconData iconData = isSelected
        ? Icons.radio_button_checked
        : Icons.radio_button_unchecked;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppCircular.r50),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(
          horizontal: AppPadding.pW12,
          vertical: AppPadding.pH14,
        ),
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(AppCircular.r50),
          border: Border.all(color: borderColor, width: 1),
        ),
        child: Row(
          textDirection: TextDirection.ltr,
          children: [
            Expanded(
              child: Text(
                label,
                textAlign: TextAlign.right,
                style: context.textStyle.s14.medium.setColor(textColor),
              ),
            ),
            SizedBox(width: AppPadding.pW8),
            Icon(
              iconData,
              size: AppSize.sH20,
              color: isSelected ? AppColors.primary : AppColors.placeholder,
            ),
          ],
        ),
      ),
    );
  }
}
