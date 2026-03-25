part of '../imports/view_imports.dart';

class _MoreSectionWidget extends StatelessWidget {
  final String titleKey;
  final List<MoreItemEntity> items;

  const _MoreSectionWidget({required this.titleKey, required this.items});

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
