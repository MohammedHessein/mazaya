import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../config/language/locale_keys.g.dart';
import '../../../../core/extensions/context_extension.dart';
import '../../../../core/extensions/text_style_extensions.dart';
import '../../../../core/extensions/widgets/sized_box_helper.dart';
import 'nearby_chip_widget.dart';

class FilterNearbySection extends StatelessWidget {
  final bool isNearbyEnabled;
  final String? selectedNearby;
  final Function(String) onNearbyChanged;

  const FilterNearbySection({
    super.key,
    required this.isNearbyEnabled,
    required this.selectedNearby,
    required this.onNearbyChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          LocaleKeys.nearby,
          style: context.textStyle.s14.regular.setMainTextColor,
        ),
        8.szH,
        Opacity(
          opacity: isNearbyEnabled ? 1.0 : 0.5,
          child: Wrap(
            spacing: 8.w,
            runSpacing: 10.h,
            children: [
              NearbyChipWidget(
                label: LocaleKeys.nearbyAll,
                value: 'all',
                isSelected: selectedNearby == 'all',
                onTap: isNearbyEnabled ? () => onNearbyChanged('all') : null,
              ),
              ...['10', '20', '30', '40'].map((km) => NearbyChipWidget(
                    label: LocaleKeys.nearbyKm(distance: km),
                    value: km,
                    isSelected: selectedNearby == km,
                    onTap: isNearbyEnabled ? () => onNearbyChanged(km) : null,
                  )),
            ],
          ),
        ),
        if (!isNearbyEnabled) ...[
          8.szH,
          Text(
            LocaleKeys.nearbyDisabledHint,
            style: context.textStyle.s12.regular.setPrimaryColor,
          ),
        ],
      ],
    );
  }
}
