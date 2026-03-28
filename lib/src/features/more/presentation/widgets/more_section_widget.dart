import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mazaya/src/config/res/config_imports.dart';
import 'package:mazaya/src/core/extensions/text_style_extensions.dart';
import 'package:mazaya/src/features/more/entity/more_menu_item_entity.dart';

import '../imports/view_imports.dart';

class MoreSectionWidget extends StatelessWidget {
  final String titleKey;
  final List<MoreItemEntity> items;

  const MoreSectionWidget({
    super.key,
    required this.titleKey,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    context.locale;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: AppMargin.mH6,
      children: [
        Text(titleKey, style: const TextStyle().setGreyColor.s13.regular),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: items.length,
          itemBuilder: (context, index) {
            return MoreMenuCardWidget(menuItem: items[index]);
          },
        ),
      ],
    );
  }
}
