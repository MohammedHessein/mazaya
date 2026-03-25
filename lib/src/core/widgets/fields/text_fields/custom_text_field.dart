
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../config/res/config_imports.dart';
import '../../../extensions/text_style_extensions.dart';
import 'default_text_field.dart';

class CustomTextFiled extends StatelessWidget {
  final String hint;
  final String? title;
  final TextEditingController? controller;
  final TextInputType textInputType;
  final TextInputAction textInputAction;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final Color? borderColor;
  final String? Function(String?)? validator;
  final int? maxLines;
  final void Function()? onTap;
  final Color? fillColor;
  final bool hasBorder;
  final List<TextInputFormatter>? inputFormatters;
  final dynamic Function(String?)? onSubmitted;
  final void Function(String?)? onChanged;
  final bool readOnly;
  final FocusNode? focusNode;
  final bool? isPassword;
  final bool isOptional;
  final BorderRadius? borderRadius;

  const CustomTextFiled({
    super.key,
    this.title,
    this.borderRadius,
    required this.hint,
    required this.textInputType,
    required this.textInputAction,
    required this.validator,
    this.onTap,
    this.focusNode,
    this.borderColor,
    this.prefixIcon,
    this.suffixIcon,
    required this.controller,
    this.onSubmitted,
    this.onChanged,
    this.maxLines,
    this.fillColor,
    this.inputFormatters,
    this.hasBorder = true,
    this.readOnly = false,
    this.isPassword = false,
    this.isOptional = false,
  });

  @override
  Widget build(BuildContext context) {
    context.locale;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: AppMargin.mH6,
      children: [
        if (title != null) ...[
          if (isOptional) ...[
            Text(title!, style: const TextStyle().setMainTextColor.s13.regular),
          ] else ...[
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              spacing: AppMargin.mW2,
              children: [
                Text(
                  "*",
                  style: const TextStyle()
                      .setColor(const Color(0xffD92D20))
                      .s13
                      .regular,
                ),
                Text(
                  title!,
                  style: const TextStyle().setMainTextColor.s13.regular,
                ),
              ],
            ),
          ],
        ],
        DefaultTextField(
          focusNode: focusNode,
          borderRadius: borderRadius,
          inputFormatters: inputFormatters,
          maxLines: maxLines,
          controller: controller,
          borderColor: readOnly && fillColor == null
              ? AppColors.grey1
              : AppColors.border,
          hasBorderColor: hasBorder,
          isPassword: isPassword,
          inputType: textInputType,
          title: hint,
          filled: true,
          closeWhenTapOutSide: true,
          readOnly: readOnly,
          onSubmitted: onSubmitted,
          onTap: onTap,
          fillColor: readOnly && fillColor == null
              ? AppColors.border
              : (fillColor ?? AppColors.border),
          action: textInputAction,
          onChanged: onChanged,
          validator: validator,
          contentPadding: EdgeInsets.symmetric(
            horizontal: AppPadding.pW8,
            vertical: AppPadding.pH14,
          ),
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
          style: const TextStyle().setMainTextColor.s12.regular,
        ),
      ],
    );
  }
}
