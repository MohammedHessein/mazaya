import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';
import '../../../config/res/assets.gen.dart';
import '../../../config/res/config_imports.dart';
import '../../../core/extensions/context_extension.dart';
import '../../../core/extensions/text_style_extensions.dart';
import '../../extensions/widgets/margin_extention.dart';
import '../../extensions/widgets/padding_extension.dart';

class EmptyWidget extends StatelessWidget {
  final String? path;
  final String title;
  final String desc;
  const EmptyWidget({
    super.key,
    this.path,
    required this.desc,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      spacing: AppMargin.mH12,
      children: [
        SizedBox(
          width: context.width * .6,
          height: context.height * .25,
          child: FittedBox(fit: BoxFit.contain, child: _buildMedia()),
        ),
        Text(title, style: const TextStyle().setMainTextColor.s13.medium),
        Text(
          desc,
          textAlign: TextAlign.center,
          style: const TextStyle().setSecondryColor.s11.regular,
        ).paddingSymmetric(horizontal: AppPadding.pW14),
      ],
    ).paddingAll(AppPadding.pH10).marginTop(context.height * .1);
  }

  Widget _buildMedia() {
    final String effectivePath = (path == null || path!.isEmpty)
        ? AppAssets.lottie.notFound2.path
        : path!;

    final lower = effectivePath.toLowerCase();

    if (lower.endsWith('.json')) {
      // Lottie animation
      return Lottie.asset(effectivePath);
    } else if (lower.endsWith('.svg')) {
      // SVG asset
      return SvgPicture.asset(effectivePath);
    } else {
      // Fallback to normal image (png, jpg, etc.)
      return Image.asset(effectivePath);
    }
  }
}
