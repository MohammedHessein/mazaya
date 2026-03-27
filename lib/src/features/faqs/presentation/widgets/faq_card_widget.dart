part of '../imports/view_imports.dart';

class _FaqCardWidget extends StatefulWidget {
  final FaqEntity faqEntity;

  const _FaqCardWidget({required this.faqEntity});

  @override
  State<_FaqCardWidget> createState() => _FaqCardWidgetState();
}

class _FaqCardWidgetState extends State<_FaqCardWidget> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Text(
        widget.faqEntity.question,
        style: const TextStyle().setMainTextColor.s13.medium,
      ),
      trailing: Visibility(
        visible: isExpanded,
        replacement: AppAssets.svg.baseSvg.dropDownArrowDown.svg(
          width: AppSize.sW8,
          height: AppSize.sH8,
        ),
        child: AppAssets.svg.baseSvg.arrowDown.svg(
          width: AppSize.sW18,
          height: AppSize.sH18,
        ),
      ),
      onExpansionChanged: (value) => setState(() => isExpanded = value),
      children: [
        Padding(
          padding: EdgeInsets.only(
            left: AppPadding.pW16,
            right: AppPadding.pW16,
            bottom: AppPadding.pH16,
          ),
          child: Text(
            widget.faqEntity.answer,
            style: const TextStyle().setSecondryColor.s12.regular,
          ),
        ),
      ],
    );
  }
}
