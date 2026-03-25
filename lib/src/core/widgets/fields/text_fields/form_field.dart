import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../config/res/config_imports.dart';
import '../../../extensions/context_extension.dart';
import '../../../extensions/text_style_extensions.dart';
import '../../../navigation/navigator.dart';
 

class FormFieldWrapper<T> extends StatelessWidget {
  final FormFieldValidator<T>? validator;
  final T? initialValue;
  final CrossAxisAlignment crossAxisAlignment;
  final AutovalidateMode autovalidateMode;
  final bool enabled;
  final double? borderRadius;
  final FormFieldSetter<T>? onSaved;
  final bool isBordered;
  final GlobalKey<FormFieldState<T>>? fieldKey;
  final Widget Function(FormFieldState<T>) builder;

  const FormFieldWrapper({
    super.key,
    required this.validator,
    required this.builder,
    this.initialValue,
    this.borderRadius,
    this.isBordered = false,
    this.crossAxisAlignment = CrossAxisAlignment.start,
    this.autovalidateMode = AutovalidateMode.onUserInteraction,
    this.enabled = true,
    this.onSaved,
    this.fieldKey,
  });

  @override
  Widget build(BuildContext context) {
    return FormField<T>(
      key: fieldKey,
      validator: validator,
      initialValue: initialValue,
      autovalidateMode: autovalidateMode,
      enabled: enabled,
      onSaved: onSaved,
      builder: (FormFieldState<T> state) {
        return Column(
          crossAxisAlignment: crossAxisAlignment,
          children: [
            if (isBordered)
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(borderRadius ?? 12.r),
                  border: state.hasError
                      ? Border.all(
                    width: .5,
                    color: AppColors.error.withValues(alpha: 0.65),
                  )
                      : null,
                ),
                child: builder(state),
              )
            else
              builder(state),
            if (state.errorText != null)
              Padding(
                padding: EdgeInsetsDirectional.only(top: 4.0.h, start: 16.w),
                child: Text(
                  state.errorText!,
                  style: context.textStyle.s12.regular.setErrorColor,
                ),
              ),
          ],
        );
      },
    );
  }
}

extension FormFieldExtension on Widget {
  Widget asFormField<T>({
    required FormFieldValidator<T>? validator,
    T? initialValue,
    CrossAxisAlignment crossAxisAlignment = CrossAxisAlignment.start,
    AutovalidateMode autovalidateMode = AutovalidateMode.onUserInteraction,
    bool enabled = true,
    FormFieldSetter<T>? onSaved,
    FormFieldBuilder<T>? builder,
    GlobalKey<FormState>? fieldKey,
  }) {
    return StatefulBuilder(
      builder: (context, setState) => FormField<T>(
        key: fieldKey,
        validator: (value) {
          setState(() {});
          return validator?.call(value);
        },
        initialValue: initialValue,
        autovalidateMode: autovalidateMode,
        enabled: enabled,
        onSaved: onSaved,
        builder: (FormFieldState<T> state) {
          return Column(
            crossAxisAlignment: crossAxisAlignment,
            children: [
              this,
              if (state.errorText != null)
                Padding(
                  padding: EdgeInsetsDirectional.only(top: 4.0.h, start: 16.w),
                  child: Text(
                    state.errorText!,
                    style: context.textStyle.s12.regular.setErrorColor,
                  ),
                ),
            ],
          );
        },
      ),
    );
  }

  FormField<T> asBorderFormField<T>({
    required FormFieldValidator<T>? validator,
    T? initialValue,
    AutovalidateMode autovalidateMode = AutovalidateMode.onUserInteraction,
    bool enabled = true,
    required BorderRadius borderRadius,
    double? height,
    FormFieldSetter<T>? onSaved,
    FormFieldBuilder<T>? builder,
  }) {
    return FormField<T>(
      validator: validator,
      initialValue: initialValue,
      autovalidateMode: autovalidateMode,
      enabled: enabled,
      onSaved: onSaved,
      builder: (FormFieldState<T> state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: height,
              decoration: BoxDecoration(
                borderRadius: borderRadius,
                border: state.hasError
                    ? Border.all(color: AppColors.error.withValues(alpha: 0.65))
                    : null,
              ),
              child: this,
            ),
            if (state.errorText != null)
              Padding(
                padding: EdgeInsetsDirectional.only(top: 6.0.h, start: 16.w),
                child: Text(
                  state.errorText!,
                  style: Go.context.textStyle.s12.regular.setErrorColor,
                ),
              ),
          ],
        );
      },
    );
  }
}