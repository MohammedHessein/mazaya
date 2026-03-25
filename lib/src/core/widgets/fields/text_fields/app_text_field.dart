import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../config/language/locale_keys.g.dart';
import '../../../../config/res/config_imports.dart';
import '../../../extensions/context_extension.dart';
import '../../../extensions/text_style_extensions.dart';
import '../../../helpers/arabic_numbers_formatter.dart';

class AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}

class AppTextField extends StatefulWidget {
  const AppTextField({
    super.key,
    this.suffixIcon,
    this.subTitle,
    this.prefixIcon,
    this.suffix,
    this.prefix,
    this.hint,
    this.errorText,
    this.hintStyle,
    this.labelStyle,
    this.labelFF,
    this.style,
    this.isMandatory = false,
    this.isOptionalOrHasSubTitle = false,
    this.isBordered = true,
    this.obscureText = false,
    this.controller,
    this.focusNode,
    this.fillColor,
    this.keyboardType,
    this.borderRadius,
    this.debounceOnChanged = true,
    this.textInputAction = TextInputAction.next,
    this.inputFormatters = const [],
    this.contentPadding,
    this.readOnly = false,
    this.textAlign,
    this.hintTextDirection,
    this.textDirection,
    this.autovalidateMode = AutovalidateMode.onUserInteraction,
    this.validator,
    this.onChanged,
    this.onSaved,
    this.onTap,
    this.onSubmitted, // ← Added
    this.decoration,
    this.maxLines = 1,
    this.minLines = 1,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.suffixIconMaxHeight,
    this.labelFontWeight,
  }) : label = null;

  const AppTextField.withoutBorder({
    super.key,
    this.suffixIcon,
    this.prefixIcon,
    this.suffix,
    this.subTitle,
    this.prefix,
    this.hint,
    this.errorText,
    this.hintStyle,
    this.style,
    this.labelStyle,
    this.labelFF,
    this.isMandatory = false,
    this.isOptionalOrHasSubTitle = false,
    this.obscureText = false,
    this.controller,
    this.focusNode,
    this.fillColor,
    this.keyboardType,
    this.borderRadius,
    this.debounceOnChanged = true,
    this.textInputAction = TextInputAction.next,
    this.inputFormatters = const [],
    this.contentPadding,
    this.readOnly = false,
    this.textAlign,
    this.hintTextDirection,
    this.textDirection,
    this.autovalidateMode = AutovalidateMode.onUserInteraction,
    this.validator,
    this.onChanged,
    this.onSaved,
    this.onTap,
    this.onSubmitted, // ← Added
    this.decoration,
    this.label,
    this.maxLines = 1,
    this.minLines = 1,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.suffixIconMaxHeight,
    this.labelFontWeight,
  }) : isBordered = false;

  const AppTextField.withLabel({
    super.key,
    this.suffixIcon,
    this.prefixIcon,
    this.suffix,
    this.prefix,
    this.subTitle,
    this.hint,
    this.errorText,
    this.hintStyle,
    this.style,
    this.labelStyle,
    this.decoration,
    this.labelFF,
    this.isOptionalOrHasSubTitle = false,
    this.isMandatory = false,
    this.isBordered = true,
    required this.label,
    this.fillColor,
    this.controller,
    this.focusNode,
    this.keyboardType,
    this.textAlign,
    this.hintTextDirection,
    this.textInputAction = TextInputAction.next,
    this.readOnly = false,
    this.autovalidateMode = AutovalidateMode.onUserInteraction,
    this.inputFormatters = const [],
    this.contentPadding,
    this.textDirection,
    this.validator,
    this.debounceOnChanged = true,
    this.obscureText = false,
    this.onChanged,
    this.borderRadius,
    this.onSaved,
    this.onTap,
    this.onSubmitted, // ← Added
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.maxLines = 1,
    this.minLines = 1,
    this.suffixIconMaxHeight,
    this.labelFontWeight,
  }) : assert(label != null, 'Label must not be null');

  factory AppTextField.mediumLabel({
    Key? key,
    Widget? suffixIcon,
    String? subTitle,
    Widget? prefixIcon,
    Widget? suffix,
    Widget? prefix,
    String? hint,
    String? errorText,
    TextStyle? hintStyle,
    TextStyle? style,
    TextStyle? labelStyle,
    BoxDecoration? decoration,
    String? labelFF,
    bool isOptionalOrHasSubTitle = false,
    bool isMandatory = false,
    bool isBordered = true,
    required String label,
    Color? fillColor,
    TextEditingController? controller,
    FocusNode? focusNode,
    TextInputType? keyboardType,
    TextAlign? textAlign,
    TextDirection? hintTextDirection,
    TextInputAction textInputAction = TextInputAction.next,
    bool readOnly = false,
    AutovalidateMode autovalidateMode = AutovalidateMode.onUserInteraction,
    List<TextInputFormatter> inputFormatters = const [],
    EdgeInsetsGeometry? contentPadding,
    TextDirection? textDirection,
    String? Function(String?)? validator,
    bool debounceOnChanged = true,
    bool obscureText = false,
    void Function(String?)? onChanged,
    double? borderRadius,
    void Function(String?)? onSaved,
    void Function()? onTap,
    void Function(String)? onSubmitted, // ← Added
    MainAxisAlignment mainAxisAlignment = MainAxisAlignment.start,
    int maxLines = 1,
    int minLines = 1,
    double? suffixIconMaxHeight,
  }) {
    return AppTextField.withLabel(
      key: key,
      suffixIcon: suffixIcon,
      subTitle: subTitle,
      prefixIcon: prefixIcon,
      suffix: suffix,
      prefix: prefix,
      hint: hint,
      errorText: errorText,
      hintStyle: hintStyle,
      style: style,
      labelStyle: labelStyle,
      decoration: decoration,
      labelFF: labelFF,
      isOptionalOrHasSubTitle: isOptionalOrHasSubTitle,
      isMandatory: isMandatory,
      isBordered: isBordered,
      label: label,
      fillColor: fillColor,
      controller: controller,
      focusNode: focusNode,
      keyboardType: keyboardType,
      textAlign: textAlign,
      hintTextDirection: hintTextDirection,
      textInputAction: textInputAction,
      readOnly: readOnly,
      autovalidateMode: autovalidateMode,
      inputFormatters: inputFormatters,
      contentPadding: contentPadding,
      textDirection: textDirection,
      validator: validator,
      debounceOnChanged: debounceOnChanged,
      obscureText: obscureText,
      onChanged: onChanged,
      borderRadius: borderRadius,
      onSaved: onSaved,
      onTap: onTap,
      onSubmitted: onSubmitted,
      // ← Added
      mainAxisAlignment: mainAxisAlignment,
      maxLines: maxLines,
      minLines: minLines,
      suffixIconMaxHeight: suffixIconMaxHeight,
      labelFontWeight: FontWeight.w500,
    );
  }

  factory AppTextField.regularLabel({
    Key? key,
    Widget? suffixIcon,
    String? subTitle,
    Widget? prefixIcon,
    Widget? suffix,
    Widget? prefix,
    String? hint,
    String? errorText,
    TextStyle? hintStyle,
    TextStyle? style,
    TextStyle? labelStyle,
    BoxDecoration? decoration,
    String? labelFF,
    bool isOptionalOrHasSubTitle = false,
    bool isMandatory = false,
    bool isBordered = true,
    required String label,
    Color? fillColor,
    TextEditingController? controller,
    FocusNode? focusNode,
    TextInputType? keyboardType,
    TextAlign? textAlign,
    TextDirection? hintTextDirection,
    TextInputAction textInputAction = TextInputAction.next,
    bool readOnly = false,
    AutovalidateMode autovalidateMode = AutovalidateMode.onUserInteraction,
    List<TextInputFormatter> inputFormatters = const [],
    EdgeInsetsGeometry? contentPadding,
    TextDirection? textDirection,
    String? Function(String?)? validator,
    bool debounceOnChanged = true,
    bool obscureText = false,
    void Function(String?)? onChanged,
    double? borderRadius,
    void Function(String?)? onSaved,
    void Function()? onTap,
    void Function(String)? onSubmitted, // ← Added
    MainAxisAlignment mainAxisAlignment = MainAxisAlignment.start,
    int maxLines = 1,
    int minLines = 1,
    double? suffixIconMaxHeight,
  }) {
    return AppTextField.withLabel(
      key: key,
      suffixIcon: suffixIcon,
      subTitle: subTitle,
      prefixIcon: prefixIcon,
      suffix: suffix,
      prefix: prefix,
      hint: hint,
      errorText: errorText,
      hintStyle: hintStyle,
      style: style,
      labelStyle: labelStyle,
      decoration: decoration,
      labelFF: labelFF,
      isOptionalOrHasSubTitle: isOptionalOrHasSubTitle,
      isMandatory: isMandatory,
      isBordered: isBordered,
      label: label,
      fillColor: fillColor,
      controller: controller,
      focusNode: focusNode,
      keyboardType: keyboardType,
      textAlign: textAlign,
      hintTextDirection: hintTextDirection,
      textInputAction: textInputAction,
      readOnly: readOnly,
      autovalidateMode: autovalidateMode,
      inputFormatters: inputFormatters,
      contentPadding: contentPadding,
      textDirection: textDirection,
      validator: validator,
      debounceOnChanged: debounceOnChanged,
      obscureText: obscureText,
      onChanged: onChanged,
      borderRadius: borderRadius,
      onSaved: onSaved,
      onTap: onTap,
      onSubmitted: onSubmitted,
      // ← Added
      mainAxisAlignment: mainAxisAlignment,
      maxLines: maxLines,
      minLines: minLines,
      suffixIconMaxHeight: suffixIconMaxHeight,
      labelFontWeight: FontWeight.w400,
    );
  }

  factory AppTextField.optionalLabel({
    Key? key,
    Widget? suffixIcon,
    Widget? prefixIcon,
    Widget? suffix,
    Widget? prefix,
    String? hint,
    String? errorText,
    TextStyle? hintStyle,
    TextStyle? style,
    TextStyle? labelStyle,
    BoxDecoration? decoration,
    String? labelFF,
    bool isMandatory = false,
    bool isBordered = true,
    required String label,
    Color? fillColor,
    TextEditingController? controller,
    FocusNode? focusNode,
    TextInputType? keyboardType,
    TextAlign? textAlign,
    TextDirection? hintTextDirection,
    TextInputAction textInputAction = TextInputAction.next,
    bool readOnly = false,
    AutovalidateMode autovalidateMode = AutovalidateMode.onUserInteraction,
    List<TextInputFormatter> inputFormatters = const [],
    EdgeInsetsGeometry? contentPadding,
    TextDirection? textDirection,
    String? Function(String?)? validator,
    bool debounceOnChanged = true,
    bool obscureText = false,
    void Function(String?)? onChanged,
    double? borderRadius,
    void Function(String?)? onSaved,
    void Function()? onTap,
    void Function(String)? onSubmitted, // ← Added
    MainAxisAlignment mainAxisAlignment = MainAxisAlignment.start,
    int maxLines = 1,
    int minLines = 1,
    double? suffixIconMaxHeight,
  }) {
    return AppTextField.withLabel(
      key: key,
      suffixIcon: suffixIcon,
      prefixIcon: prefixIcon,
      suffix: suffix,
      prefix: prefix,
      hint: hint,
      errorText: errorText,
      hintStyle: hintStyle,
      style: style,
      labelStyle: labelStyle,
      decoration: decoration,
      labelFF: labelFF,
      isOptionalOrHasSubTitle: true,
      isMandatory: isMandatory,
      isBordered: isBordered,
      label: label,
      fillColor: fillColor,
      controller: controller,
      focusNode: focusNode,
      keyboardType: keyboardType,
      textAlign: textAlign,
      hintTextDirection: hintTextDirection,
      textInputAction: textInputAction,
      readOnly: readOnly,
      autovalidateMode: autovalidateMode,
      inputFormatters: inputFormatters,
      contentPadding: contentPadding,
      textDirection: textDirection,
      validator: validator,
      debounceOnChanged: debounceOnChanged,
      obscureText: obscureText,
      onChanged: onChanged,
      borderRadius: borderRadius,
      onSaved: onSaved,
      onTap: onTap,
      onSubmitted: onSubmitted,
      // ← Added
      mainAxisAlignment: mainAxisAlignment,
      maxLines: maxLines,
      minLines: minLines,
      suffixIconMaxHeight: suffixIconMaxHeight,
    );
  }

  final int maxLines, minLines;

  final String? label;
  final String? subTitle;
  final String? hint, errorText;
  final TextStyle? hintStyle, style, labelStyle;
  final String? labelFF;
  final Color? fillColor;
  final TextAlign? textAlign;
  final TextDirection? hintTextDirection, textDirection;
  final bool readOnly,
      isOptionalOrHasSubTitle,
      isMandatory,
      isBordered,
      debounceOnChanged,
      obscureText;
  final FocusNode? focusNode;
  final AutovalidateMode autovalidateMode;
  final Widget? suffixIcon, prefixIcon, suffix, prefix;
  final TextInputType? keyboardType;
  final TextInputAction textInputAction;
  final TextEditingController? controller;
  final List<TextInputFormatter> inputFormatters;
  final EdgeInsetsGeometry? contentPadding;
  final String? Function(String?)? validator;
  final void Function(String?)? onChanged, onSaved;
  final void Function()? onTap;
  final void Function(String)? onSubmitted; // ← Added
  final MainAxisAlignment mainAxisAlignment;
  final BoxDecoration? decoration;
  final double? borderRadius;
  final double? suffixIconMaxHeight;
  final FontWeight? labelFontWeight;

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  final _debouncer = PublishSubject<String>();

  @override
  void initState() {
    if (widget.onChanged != null) {
      _debouncer.stream.debounceTime(const Duration(milliseconds: 300)).listen((
        value,
      ) {
        if (widget.onChanged != null) {
          widget.onChanged!(value);
        }
      });
    }
    super.initState();
  }

  @override
  void dispose() {
    _debouncer.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    TextStyle labelBaseStyle;

    if (widget.labelStyle != null) {
      labelBaseStyle = widget.labelStyle!;
    } else {
      labelBaseStyle = context.textStyle.s14.setBlackColor;

      if (widget.labelFontWeight != null) {
        labelBaseStyle = labelBaseStyle.copyWith(
          fontWeight: widget.labelFontWeight,
        );
      } else {
        labelBaseStyle = labelBaseStyle.regular;
      }
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.label != null)
          Padding(
            padding: EdgeInsets.only(bottom: AppSize.sH8),
            child: RichText(
              text: TextSpan(
                children: [
                  TextSpan(text: widget.label, style: labelBaseStyle),
                  if (widget.isMandatory)
                    TextSpan(
                      text: ' *',
                      style: context.textStyle.s12.medium.setErrorColor,
                    ),
                  if (widget.isOptionalOrHasSubTitle)
                    TextSpan(
                      text: ' (${LocaleKeys.optional})',
                      style: context.textStyle.s12.regular.setColor(
                        AppColors.grey1,
                      ),
                    ),
                ],
              ),
            ),
          ),
        Container(
          alignment: Alignment.center,
          decoration:
              widget.decoration ??
              BoxDecoration(
                borderRadius: BorderRadius.circular(
                  widget.borderRadius ?? 12.r,
                ),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x14000000),
                    offset: Offset(0, 4),
                    blurRadius: 124,
                    spreadRadius: 0,
                  ),
                ],
              ),
          child: TextFormField(
            obscureText: widget.obscureText,
            onTapOutside: (_) => FocusManager.instance.primaryFocus?.unfocus(),
            focusNode: widget.readOnly
                ? AlwaysDisabledFocusNode()
                : widget.focusNode,
            controller: widget.controller,
            readOnly: widget.readOnly,
            onTap: widget.onTap,
            textDirection: widget.textDirection,
            validator: widget.validator,
            onChanged: widget.onChanged != null && widget.debounceOnChanged
                ? _debouncer.add
                : widget.onChanged,
            onSaved: widget.onSaved,
            onFieldSubmitted: widget.onSubmitted,
            // ← Added
            maxLines: widget.maxLines,
            minLines: widget.minLines,
            inputFormatters: [
              ArabicNumbersFormatter(),
              ...widget.inputFormatters,
            ],
            autovalidateMode: widget.autovalidateMode,
            keyboardType: widget.keyboardType,
            textAlignVertical: TextAlignVertical.center,
            textInputAction: widget.textInputAction,
            style: widget.style ?? context.textStyle.s14.regular.setHintColor,
            textAlign: widget.textAlign ?? TextAlign.start,
            decoration: InputDecoration(
              errorMaxLines: 2,
              errorStyle: context.textStyle.s12.regular.setErrorColor,
              contentPadding:
                  widget.contentPadding ??
                  EdgeInsets.symmetric(horizontal: 12.w, vertical: 0.h),
              hintText: widget.hint,
              hintTextDirection: widget.hintTextDirection,
              hintStyle:
                  widget.hintStyle ??
                  context.textStyle.s12.regular.setHintColor,
              errorText: widget.errorText,
              fillColor: widget.fillColor ?? Colors.white,
              filled: true,
              border: widget.isBordered
                  ? OutlineInputBorder(
                      borderRadius: BorderRadius.circular(
                        widget.borderRadius ?? 12.r,
                      ),
                      borderSide: BorderSide(
                        color: widget.isBordered
                            ? AppColors.grey2
                            : Colors.transparent,
                        width: .5,
                      ),
                    )
                  : OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.r),
                      borderSide: BorderSide.none,
                    ),
              enabledBorder: widget.isBordered
                  ? OutlineInputBorder(
                      borderSide: BorderSide(
                        color: widget.isBordered
                            ? AppColors.grey2
                            : Colors.transparent,
                        width: .5,
                      ),
                      borderRadius: BorderRadius.circular(
                        widget.borderRadius ?? 12.r,
                      ),
                    )
                  : OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.r),
                      borderSide: BorderSide.none,
                    ),
              focusedBorder: widget.isBordered
                  ? OutlineInputBorder(
                      borderSide: BorderSide(
                        color: widget.isBordered
                            ? AppColors.grey2
                            : Colors.transparent,
                        width: .5,
                      ),
                      borderRadius: BorderRadius.circular(
                        widget.borderRadius ?? 12.r,
                      ),
                    )
                  : null,
              errorBorder: widget.isBordered
                  ? OutlineInputBorder(
                      borderSide: BorderSide(
                        width: .5,
                        color: AppColors.error.withValues(alpha: 0.65),
                      ),
                      borderRadius: BorderRadius.circular(
                        widget.borderRadius ?? 12.r,
                      ),
                    )
                  : OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.r),
                      borderSide: BorderSide(
                        width: .5,
                        color: AppColors.error.withValues(alpha: 0.65),
                      ),
                    ),
              suffixIcon: Padding(
                padding: EdgeInsetsDirectional.only(end: AppPadding.pW12),
                child: widget.suffixIcon,
              ),
              suffixIconConstraints: BoxConstraints(
                minHeight: 24.w,
                minWidth: 24.w,
                maxHeight: widget.suffixIconMaxHeight ?? 24.w,
              ),
              prefixIconConstraints: BoxConstraints(
                minHeight: 24.w,
                minWidth: 40.w,
                maxHeight: 24.w,
              ),
              prefixIcon: widget.prefixIcon,
              suffix: widget.suffix,
              prefix: widget.prefix,
            ),
          ),
        ),
      ],
    );
  }
}
