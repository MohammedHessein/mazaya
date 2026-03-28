import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mazaya/src/config/language/locale_keys.g.dart';
import 'package:mazaya/src/config/res/config_imports.dart';
import 'package:mazaya/src/core/extensions/widgets/padding_extension.dart';
import 'package:mazaya/src/core/shared/cubits/user_cubit/user_cubit.dart';
import 'package:mazaya/src/features/more/entity/more_menu_item_entity.dart';

import '../imports/view_imports.dart';

class MoreTabBody extends StatelessWidget {
  const MoreTabBody({super.key});

  @override
  Widget build(BuildContext context) {
    context.locale;
    final generalItems = MoreItemEntity.generalItems;
    final otherItems = MoreItemEntity.otherItems;
    final guestItems = MoreItemEntity.guestItems;
    return Column(
      spacing: AppMargin.mH30,
      children: [
        if (UserCubit.instance.isUserLoggedIn)
          const ProfileInfoWithIconsWidget(
            profileIconAppear: ProfileIconAppearEnum.more,
          ),
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: AppMargin.mH18,
              children: [
                if (UserCubit.instance.isUserLoggedIn) ...[
                  MoreSectionWidget(
                    titleKey: LocaleKeys.moreGeneralTitle,
                    items: generalItems,
                  ),
                  MoreSectionWidget(
                    titleKey: LocaleKeys.moreOthersTitle,
                    items: otherItems,
                  ),
                ] else ...[
                  MoreSectionWidget(
                    titleKey: ConstantManager.emptyText,
                    items: guestItems,
                  ),
                ],
              ],
            ),
          ),
        ),
      ],
    ).paddingAll(AppPadding.pH14);
  }
}
