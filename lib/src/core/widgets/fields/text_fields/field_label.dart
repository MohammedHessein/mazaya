import 'package:flutter/material.dart';
import 'package:mazaya/src/core/extensions/context_extension.dart';
import 'package:mazaya/src/core/extensions/text_style_extensions.dart';

class FieldLabel extends StatelessWidget {
  final String label;
  final TextStyle? style;

  const FieldLabel({super.key, required this.label, this.style});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: AlignmentDirectional.centerStart,
      child: Text(
        label,
        style: style ?? context.textStyle.s16.bold.setMainTextColor,
      ),
    );
  }
}
