import 'package:mazaya/src/core/network/log_interceptor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mazaya/src/config/res/assets.gen.dart';
import 'package:mazaya/src/config/res/config_imports.dart';
import 'package:mazaya/src/core/widgets/image_widgets/cached_image.dart';
import 'universal_media_widget.dart';
import 'controller.dart';
import 'enums.dart';

class MediaVideoPlayer extends StatelessWidget {
  final UniversalMediaController controller;
  final BoxFit fit;

  const MediaVideoPlayer({
    super.key,
    required this.controller,
    required this.fit,
  });

  @override
  Widget build(BuildContext context) {
    if (controller.isLoading) {
      return const LoadingIndicator();
    }

    return FittedBox(
      fit: fit,
      child: SizedBox(
        width: controller.videoController!.value.size.width,
        height: controller.videoController!.value.size.height * 1.1,
        child: VideoPlayer(controller.videoController!),
      ),
    );
  }
}

class MediaSvgViewer extends StatelessWidget {
  final String path;
  final MediaSource source;
  final BoxFit fit;

  const MediaSvgViewer({
    super.key,
    required this.path,
    required this.source,
    required this.fit,
  });

  @override
  Widget build(BuildContext context) {
    final String path = this.path.trim().replaceAll('\n', '').replaceAll(' ', '');
    if (source == MediaSource.network) {
      return SvgPicture.network(
        path,
        fit: fit,
        placeholderBuilder: (context) => const LoadingIndicator(),
        errorBuilder: (context, error, stackTrace) {
          logDebug(
            '⚠️ SVG parsing failed for network asset: $path\nError: $error',
            level: Level.warning,
          );
          return const _SvgErrorFallback();
        },
      );
    } else {
      return SvgPicture.asset(
        path,
        fit: fit,
        errorBuilder: (context, error, stackTrace) {
          logDebug(
            '❌ SVG asset error: $path\nError: $error',
            level: Level.error,
          );
          return const _SvgErrorFallback();
        },
      );
    }
  }
}

class _SvgErrorFallback extends StatelessWidget {
  const _SvgErrorFallback();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(2.w),
        child: Image.asset(
          AppAssets.svg.appSvg.appLauncherIcon.path,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}

class MediaImageViewer extends StatelessWidget {
  final String path;
  final MediaSource source;
  final BoxFit fit;
  final double? width;
  final double? height;

  const MediaImageViewer({
    super.key,
    required this.path,
    required this.source,
    required this.fit,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    if (source == MediaSource.network) {
      return CachedImage(url: path, fit: fit, width: width, height: height);
    } else {
      return Image.asset(path, fit: fit, width: width, height: height);
    }
  }
}

class LoadingIndicator extends StatelessWidget {
  final Color? color;
  const LoadingIndicator({super.key, this.color});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CupertinoActivityIndicator(color: color ?? AppColors.white),
    );
  }
}
