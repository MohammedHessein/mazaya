import 'package:flutter/material.dart';
import '../../../../config/language/locale_keys.g.dart';
import '../../../../core/extensions/context_extension.dart';
import '../../../../core/extensions/text_style_extensions.dart';

class FilterHeader extends StatelessWidget {
  final VoidCallback onReset;

  const FilterHeader({super.key, required this.onReset});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        TextButton(
          onPressed: onReset,
          child: Text(
            LocaleKeys.reset,
            style: context.textStyle.s14.medium.setPrimaryColor,
          ),
        ),
        Text(
          LocaleKeys.searchFor,
          style: context.textStyle.s18.bold.setMainTextColor,
        ),
        const SizedBox(width: 50),
      ],
    );
  }
}
