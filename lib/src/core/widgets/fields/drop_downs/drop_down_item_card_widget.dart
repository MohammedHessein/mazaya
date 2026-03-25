import 'package:flutter/material.dart';
import '../../../../config/res/assets.gen.dart';
import '../../../../config/res/config_imports.dart';
import '../../../extensions/context_extension.dart';
import '../../../extensions/text_style_extensions.dart';
import '../../image_widgets/cached_image.dart';

class DropDownItemCardWidget extends StatelessWidget {
  final bool isSelected;
  final String title;
  final String flag;
  final bool imageFromNetwork;
  final bool useMultiSelect;
  final Color? bgColor;
  final void Function(bool?)? onChanged;
  const DropDownItemCardWidget({
    super.key,
    required this.title,
    required this.flag,
    required this.isSelected,
    this.bgColor,
    this.imageFromNetwork = true,
    this.useMultiSelect = false,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.width,
      margin: EdgeInsets.symmetric(vertical: AppMargin.mH4),
      padding: EdgeInsets.symmetric(
        vertical: flag.isNotEmpty ? AppPadding.pH8 : AppPadding.pH12,
        horizontal: AppPadding.pW14,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppCircular.r2),
        color: isSelected ? AppColors.border : bgColor ?? AppColors.border,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            spacing: AppMargin.mW10,
            children: [
              if (useMultiSelect) ...[CheckBoxWidget(isSelected: isSelected)],
              _FlagWidget(flag: flag, imageFromNetwork: imageFromNetwork),
              Text(
                title,
                style: const TextStyle().setMainTextColor.s15.regular,
              ),
            ],
          ),
          if (isSelected && !useMultiSelect) ...[
            AppAssets.svg.baseSvg.correct.svg(
              width: AppSize.sH14,
              height: AppSize.sH14,
            ),
          ],
        ],
      ),
    );
  }
}

class _FlagWidget extends StatelessWidget {
  final String flag;
  final bool imageFromNetwork;
  const _FlagWidget({required this.flag, required this.imageFromNetwork});

  @override
  Widget build(BuildContext context) {
    if (flag.isNotEmpty) {
      if (imageFromNetwork) {
        return CachedImage(
          url: flag,
          width: AppSize.sW50,
          height: AppSize.sH30,

          borderRadius: BorderRadius.circular(AppCircular.r2),
        );
      } else {
        return ClipRRect(
          borderRadius: BorderRadius.circular(AppCircular.r2),
          child: Image.asset(flag, width: AppSize.sW60, height: AppSize.sH30),
        );
      }
    } else {
      return const SizedBox.shrink();
    }
  }
}

class CheckBoxWidget extends StatelessWidget {
  final bool isSelected;
  const CheckBoxWidget({required this.isSelected, super.key});

  @override
  Widget build(BuildContext context) {
    if (isSelected) {
      return AppAssets.svg.baseSvg.checkBox.svg(
        height: AppSize.sH22,
        width: AppSize.sH22,
      );
    } else {
      return AppAssets.svg.baseSvg.checkBoxEmpty.svg(
        height: AppSize.sH22,
        width: AppSize.sH22,
      );
    }
  }
}
