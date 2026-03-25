import 'package:flutter/material.dart';

import '../../../../config/res/config_imports.dart';
import '../../../extensions/text_style_extensions.dart';
import 'drop_down_close_widget.dart';

class DialogTitleWithCloseIconWidget extends StatelessWidget {
  final String title;
  final void Function()? onTap;

  const DialogTitleWithCloseIconWidget({
    super.key,
    required this.title,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      spacing: AppMargin.mH6,
      children: [
        DropDownCloseWidget(onTap: onTap),
        Text(title, style: const TextStyle().setMainTextColor.s15.medium),
      ],
    );
  }
}
