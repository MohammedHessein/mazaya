import 'package:flutter/material.dart';
import '../../../../config/language/locale_keys.g.dart';
import '../../../../core/widgets/buttons/loading_button.dart';

class FilterApplyButton extends StatelessWidget {
  final VoidCallback onTap;

  const FilterApplyButton({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return LoadingButton(
      title: LocaleKeys.search,
      onTap: () async => onTap(),
    );
  }
}
