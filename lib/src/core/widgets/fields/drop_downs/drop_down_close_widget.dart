import 'package:flutter/material.dart';
import 'package:mazaya/src/config/res/assets.gen.dart';
import 'package:mazaya/src/config/res/config_imports.dart';
import 'package:mazaya/src/core/extensions/widgets/widget_extension.dart';
import 'package:mazaya/src/core/navigation/navigator.dart';

class DropDownCloseWidget extends StatelessWidget {
  final void Function()? onTap;
  const DropDownCloseWidget({super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    return AppAssets.svg.baseSvg.dropDownClose
        .svg(width: AppSize.sH25, height: AppSize.sH25)
        .onClick(onTap: onTap ?? () => Go.back());
  }
}
