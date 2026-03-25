import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../../../config/res/config_imports.dart';
import '../../extensions/context_extension.dart';
import '../../extensions/widgets/sized_box_helper.dart';
import '../../extensions/text_style_extensions.dart';
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
        gradient: isDissabled
            ? AppColors.disableGradient
            : color != null
                ? LinearGradient(colors: [color!, color!])
                : AppColors.gradient,
        onTap: isDissabled ? () async {} : onTap,
        elevation: 0,
        padding: EdgeInsets.zero,
        width: width ?? MediaQuery.sizeOf(context).width,
        minWidth: 46.h,
        height: height ?? 46.h,
        // color:gradient != null ? null:  isDissabled ? AppColors.grey2 : color ?? AppColors.primaryColor,
        borderRadius: borderRadius ?? AppSize.sH12,
        disabledColor: color ?? AppColors.primary,
        borderSide: borderSide,
        loader: onSendProgress == null
            ? Center(
                child: CupertinoActivityIndicator(
                  color: (color ?? AppColors.primary).isDark
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
                      // SizedBox(
                      //   width: 24.w,
                      //   height: 24.w,
                      //   child: CircularProgressIndicator(
                      //     // color: (color ?? AppColors.primaryColor).isDark
                      //     //     ? AppColors.white
                      //     //     : AppColors.black,
                      //     strokeWidth: 3,
                      //     value: value > 1 ? 1 : value,
                      //     valueColor: AlwaysStoppedAnimation<Color>(
                      //       (color ?? AppColors.primaryColor).isDark
                      //           ? AppColors.white
                      //           : AppColors.black,
                      //     ),
                      //   ),
                      // ),
                      // 8.w.szW,
                      SizedBox(
                        width: 60.w,
                        child: Text(
                          "${(value * 100).toStringAsFixed(1)} %",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: (color ?? AppColors.primary).isDark
                                ? AppColors.white
                                : AppColors.black,
                            fontSize: fontSize ?? FontSizeManager.s14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
        child: titleAsWidget ??
            Text(
              title,
              style: TextStyle(
                color:
                    isDissabled ? AppColors.black : textColor ?? Colors.white,
                fontSize: fontSize ?? FontSizeManager.s14,
                fontWeight: FontWeight.w600,
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
  });
  final Future<void> Function() onTap;
  final String title;
  final String icon;
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
      onTap: () async {
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
          gradient: AppColors.gradient,
          borderRadius: BorderRadius.circular(12.r),
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
                    style: context.textStyle.s16.semiBold.setWhiteColor,
                  ),
                ],
              ),
      ),
    );
  }
}
