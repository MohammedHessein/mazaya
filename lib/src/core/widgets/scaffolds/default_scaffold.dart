import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../config/res/config_imports.dart';
import '../../extensions/text_style_extensions.dart';
import 'arrow_widget.dart';

class DefaultScaffold extends StatelessWidget {
  final String title;
  final Widget body;
  final void Function()? onTap;
  final Widget? trailing;
  final Widget? headLineWidget;
  final bool showArrow;

  const DefaultScaffold({
    super.key,
    required this.title,
    required this.body,
    this.showArrow = true,
    this.onTap,
    this.headLineWidget,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    context.locale;
    return PopScope(
      canPop: false,
      child: Scaffold(
        backgroundColor: AppColors.scaffoldBackground,
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.symmetric(
                  vertical: AppPadding.pH12,
                  horizontal: AppPadding.pH12,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    if (showArrow) ...[
                      ArrowWidget(onTap: onTap),
                    ] else ...[
                      const SizedBox.shrink(),
                    ],
                    if (headLineWidget == null) ...[
                      Text(
                        title,
                        style: const TextStyle().setMainTextColor.s13.medium,
                      ),
                    ] else ...[
                      headLineWidget!,
                    ],
                    if (trailing != null) ...[
                      trailing!,
                    ] else ...[
                      SizedBox(height: AppSize.sH30, width: AppSize.sH30),
                    ],
                  ],
                ),
              ),
              Expanded(child: body),
            ],
          ),
        ),
      ),
    );
  }
}
