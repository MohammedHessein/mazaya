import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mazaya/src/config/res/config_imports.dart';
import 'package:mazaya/src/core/extensions/context_extension.dart';
import 'package:mazaya/src/core/extensions/text_style_extensions.dart';
import 'package:mazaya/src/core/extensions/widgets/sized_box_helper.dart';

import 'custom_animated_button.dart';

class LoadingButton extends StatelessWidget {
  final String title;
  final Future<void> Function() onTap;
  final Color? textColor;
  final Color? color;
  final BorderSide borderSide;
  final double? borderRadius;
  final EdgeInsets? margin;
  final double? width;
  final double? height;
  final double? fontSize;
  final String? fontFamily;
  final FontWeight? fontWeight;
  final ValueNotifier<double>? onSendProgress;
  final bool isDissabled;
  const LoadingButton({
    super.key,
    required this.title,
    required this.onTap,
    this.color,
    this.isDissabled = false,
    this.textColor,
    this.borderRadius,
    this.margin,
    this.borderSide = BorderSide.none,
    this.fontFamily,
    this.fontSize,
    this.width,
    this.height,
    this.fontWeight,
    this.onSendProgress,
    this.titleAsWidget,
  });
  final Widget? titleAsWidget;
  const LoadingButton.withWidget({
    super.key,
    this.title = "",
    required this.onTap,
    required this.titleAsWidget,
    this.isDissabled = false,
    this.color,
    this.textColor,
    this.borderRadius,
    this.margin,
    this.borderSide = BorderSide.none,
    this.fontFamily,
    this.fontSize,
    this.width,
    this.height,
    this.fontWeight,
    this.onSendProgress,
  });
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: margin ?? EdgeInsets.zero,
      child: CustomAnimatedButton(
        color: isDissabled ? null : (color ?? AppColors.buttonColor),
        gradient: isDissabled ? AppColors.disableGradient : null,
        onTap: isDissabled ? () async {} : onTap,
        elevation: 0,
        padding: EdgeInsets.zero,
        width: width ?? MediaQuery.sizeOf(context).width,
        minWidth: 46.h,
        height: height ?? AppSize.sH50,
        borderRadius: borderRadius ?? AppCircular.r50,
        disabledColor: AppColors.grey2,
        borderSide: borderSide,
        loader: onSendProgress == null
            ? Center(
                child: CupertinoActivityIndicator(
                  color: (color ?? AppColors.buttonColor).isDark
                      ? AppColors.white
                      : AppColors.black,
                ),
              )
            : ValueListenableBuilder(
                valueListenable: onSendProgress!,
                builder: (context, value, child) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 60.w,
                        child: Text(
                          "${(value * 100).toStringAsFixed(1)} %",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: (color ?? AppColors.buttonColor).isDark
                                ? AppColors.white
                                : AppColors.black,
                            fontSize: fontSize ?? FontSizeManager.s13,
                            fontWeight: FontWeightManager.medium,
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
        child:
            titleAsWidget ??
            Text(
              title,
              style: TextStyle(
                color: isDissabled
                    ? AppColors.black
                    : textColor ?? AppColors.buttonText,
                fontSize: fontSize ?? FontSizeManager.s16,
                fontWeight: fontWeight ?? FontWeightManager.bold,
                fontFamily: fontFamily,
              ),
            ),
      ),
    );
  }
}

class LoadingButtonWithIcon extends StatefulWidget {
  const LoadingButtonWithIcon({
    super.key,
    required this.onTap,
    required this.title,
    required this.icon,
    this.isDissabled = false,
    this.color,
  });
  final Future<void> Function() onTap;
  final String title;
  final String icon;
  final bool isDissabled;
  final Color? color;
  @override
  State<LoadingButtonWithIcon> createState() => _LoadingButtonWithIconState();
}

class _LoadingButtonWithIconState extends State<LoadingButtonWithIcon> {
  bool isLoading = false;

  void toggleIsLoading() {
    setState(() {
      isLoading = !isLoading;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.isDissabled
          ? null
          : () async {
              try {
                toggleIsLoading();
                await widget.onTap();
              } finally {
                toggleIsLoading();
              }
            },
      child: Container(
        padding: EdgeInsets.all(12.h),
        decoration: BoxDecoration(
          color: widget.isDissabled
              ? null
              : (widget.color ?? AppColors.primary),
          gradient: widget.isDissabled ? AppColors.disableGradient : null,
          borderRadius: BorderRadius.circular(20.r),
        ),
        child: isLoading
            ? SizedBox(
                height: 23.h,
                child: const Center(
                  child: CupertinoActivityIndicator(color: AppColors.white),
                ),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(widget.icon),
                  8.w.szW,
                  Text(
                    widget.title,
                    style: context.textStyle.s16.semiBold.copyWith(
                      color: widget.isDissabled
                          ? AppColors.black
                          : AppColors.white,
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
