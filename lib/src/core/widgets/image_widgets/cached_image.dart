import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mazaya/src/config/res/assets.gen.dart';
import 'package:mazaya/src/config/res/config_imports.dart';
import 'package:mazaya/src/core/extensions/widgets/widget_extension.dart';
import 'package:mazaya/src/core/navigation/navigator.dart';
import 'package:mazaya/src/core/network/log_interceptor.dart';

import '../universal_media/universal_media_widget.dart';
import '../universal_media/widgets.dart';
import 'image_view.dart';

class CachedImage extends StatelessWidget {
  final String url;
  final BoxFit? fit;
  final double? height, width, borderWidth;
  final BorderRadius? borderRadius;
  final ColorFilter? colorFilter;
  final Alignment? alignment;
  final Widget? child;
  final Widget? placeHolder;
  final Color? borderColor;
  final Color? bgColor;
  final BoxShape? boxShape;
  final bool ignoreClick;
  final void Function()? onTap;
  const CachedImage({
    super.key,
    required this.url,
    this.fit,
    this.width,
    this.height,
    this.placeHolder,
    this.ignoreClick = false,
    this.borderRadius,
    this.colorFilter,
    this.alignment,
    this.child,
    this.boxShape,
    this.borderColor,
    this.borderWidth,
    this.bgColor,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final String url = this.url.trim().replaceAll('\n', '').replaceAll(' ', '');
    final devicePixelRatio = MediaQuery.of(context).devicePixelRatio;
    final bool haveRadius = BoxShape.circle != boxShape;

    if (url.isEmpty) {
      return Container(
        width: width,
        height: height,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: haveRadius
              ? borderRadius ?? BorderRadius.circular(AppCircular.r2)
              : null,
          shape: boxShape ?? BoxShape.rectangle,
          color: bgColor ?? AppColors.primary.withValues(alpha: .05),
        ),
        child: Padding(
          padding: EdgeInsets.all((width != null && width! > 40) ? 20.r : 6.r),
          child: Image.asset(
            AppAssets.svg.appSvg.appLauncherIcon.path,
            fit: BoxFit.contain,
          ),
        ),
      );
    }

    // Helper function to safely calculate cache dimensions
    int? calculateCacheDimension(double? dimension) {
      if (dimension == null) return null;
      final calculatedValue = dimension * devicePixelRatio;
      if (!calculatedValue.isFinite) return null;
      return min(calculatedValue.toInt(), 2048);
    }

    if (url.toLowerCase().endsWith('.svg')) {
      return UniversalMediaWidget(
        path: url,
        width: width,
        height: height,
        fit: fit ?? BoxFit.contain,
      ).onClick(
        onTap:
            onTap ??
            () {
              Go.to(
                ImageView(
                  minScale: 1.0,
                  mediaPath: url,
                  mediaType: MediaType.image,
                  mediaSource: MediaSource.network,
                ),
              );
            },
      );
    }

    return CachedNetworkImage(
      imageUrl: url,
      width: width,
      height: height,
      memCacheHeight: calculateCacheDimension(height),
      memCacheWidth: calculateCacheDimension(width),
      maxHeightDiskCache: calculateCacheDimension(height),
      maxWidthDiskCache: calculateCacheDimension(width),
      imageBuilder: (context, imageProvider) => Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: imageProvider,
            fit: fit ?? BoxFit.fill,
            colorFilter: colorFilter,
          ),
          borderRadius: haveRadius
              ? borderRadius ?? BorderRadius.circular(AppCircular.r2)
              : null,
          shape: boxShape ?? BoxShape.rectangle,
          border: Border.all(
            color: borderColor ?? Colors.transparent,
            width: borderWidth ?? 1,
          ),
        ),
        alignment: alignment ?? Alignment.center,
        child: child,
      ),
      placeholder: (context, url) =>
          placeHolder ??
          Container(
            width: width,
            height: height,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: haveRadius
                  ? borderRadius ?? BorderRadius.circular(AppCircular.r2)
                  : null,
              border: Border.all(
                color: borderColor ?? Colors.transparent,
                width: 1,
              ),
              shape: boxShape ?? BoxShape.rectangle,
              color: bgColor ?? AppColors.gray100.withValues(alpha: .3),
            ),
            child: const LoadingIndicator(color: AppColors.primary),
          ),
      errorWidget: (context, url, error) {
        logDebug(
          '❌ Image Decoding Error: $error\nUrl: $url',
          level: Level.error,
        );
        return Container(
          width: width,
          height: height,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: haveRadius
                ? borderRadius ?? BorderRadius.circular(AppCircular.r2)
                : null,
            shape: boxShape ?? BoxShape.rectangle,
            color: bgColor ?? AppColors.primary.withValues(alpha: .05),
          ),
          child: Padding(
            padding: EdgeInsets.all(
              (width != null && width! > 40) ? 20.r : 6.r,
            ),
            child: Image.asset(
              AppAssets.svg.appSvg.appLauncherIcon.path,
              fit: BoxFit.contain,
            ),
          ),
        );
      },
    ).onClick(
      onTap:
          onTap ??
          () {
            Go.to(
              ImageView(
                minScale: 1.0,
                mediaPath: url,
                mediaType: MediaType.image,
                mediaSource: MediaSource.network,
              ),
            );
          },
    );
  }
}
