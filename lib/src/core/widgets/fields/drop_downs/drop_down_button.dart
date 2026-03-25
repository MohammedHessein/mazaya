import 'package:dropdown_search/dropdown_search.dart';
 import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
 import '../../../../config/language/locale_keys.g.dart';
import '../../../../config/res/assets.gen.dart';
import '../../../../config/res/config_imports.dart';
import '../../../extensions/context_extension.dart';
import '../../../extensions/text_style_extensions.dart';
import '../../../extensions/widgets/padding_extension.dart';
import '../../../helpers/validators.dart';
import '../../../navigation/navigator.dart';
import 'dialog_title_with_close_icon_widget.dart';
import 'drop_down_item_card_widget.dart';
import '../../handling_views/not_contain_data.dart';

/// A mixin that provides reusable dropdown helpers for custom dropdown fields
mixin CustomDropdownHelpers<T> {
  /// Function to convert item to string representation
  String Function(T?) get itemToString;

  /// Optional function to get image URL for item
  String Function(T)? get itemImageUrl;

  /// Builds a dropdown item widget
  Widget Function(BuildContext, T, bool, bool) get buildDropdownItem =>
      (context, item, isFocused, isSelected) {
        return DropDownItemCardWidget(
          title: itemToString(item),
          flag: itemImageUrl?.call(item) ?? "",
          imageFromNetwork: true,
          isSelected: isSelected,
        ).paddingSymmetric(horizontal: AppPadding.pH10);
      };

  /// Builds a loading indicator for async dropdown operations
  Widget _buildLoadingIndicator() =>
      const Center(child: CupertinoActivityIndicator(color: AppColors.main));

  /// Builds the modal sheet header with title and close button
  Widget _buildModalHeader({
    required String title,
    required ValueNotifier<bool> showSearchNotifier,
  }) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: AppMargin.mH14,
      children: [
        // Row(
        //   children: [
        //     Flexible(
        //       child: DialogTitleWithCloseIconWidget(
        //         title: title,
        //         onTap: () {
        //           showSearchNotifier.value = false;
        //           Go.back();
        //         },
        //       ),
        //     ),
        // ValueListenableBuilder(
        //   valueListenable: showSearchNotifier,
        //   builder: (context, value, child) {
        //     if (!value) {
        //       return AppAssets.svg.search
        //           .svg(height: AppSize.sH14)
        //           .onClick(onTap: () => showSearchNotifier.value = true);
        //     } else {
        //       return const SizedBox.shrink();
        //     }
        //   },
        // ),
        //   ],
        // ),
        DialogTitleWithCloseIconWidget(
          title: title,
          onTap: () {
            showSearchNotifier.value = false;
            Go.back();
          },
        ),
        Text(
          "${LocaleKeys.please} $title",
          style: const TextStyle().setColor(const Color(0xff545454)).s12.medium,
        ),
      ],
    ).paddingAll(AppPadding.pH18);
  }

  /// Builds popup configuration for the dropdown
  PopupProps<T> buildPopupProps({
    required String title,
    required BuildContext context,
    required ValueNotifier<bool> showSearchNotifier,
    VoidCallback? onDismissed,
  }) {
    return PopupProps.modalBottomSheet(
      showSearchBox: showSearchNotifier.value,
      showSelectedItems: true,
      constraints: BoxConstraints(
        maxHeight: context.height * .6,
        maxWidth: 400.w,
        minWidth: 350.w,
      ),
      emptyBuilder: (context, _) => NotContainData(width: context.width * .4),
      itemBuilder: buildDropdownItem,
      loadingBuilder: (_, _) => _buildLoadingIndicator(),
      title: _buildModalHeader(
        title: title,
        showSearchNotifier: showSearchNotifier,
      ),
      searchFieldProps: TextFieldProps(
        decoration: _buildSearchFieldDecoration(),
      ),
      searchDelay: const Duration(milliseconds: 300),
      onDismissed: onDismissed,
      modalBottomSheetProps: ModalBottomSheetProps(
        elevation: 4,
        backgroundColor: AppColors.white,
        barrierColor: Colors.black45,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
        ),
      ),
    );
  }

  /// Builds search field decoration
  InputDecoration _buildSearchFieldDecoration() {
    return InputDecoration(
      hintText: LocaleKeys.search,
      hintStyle: const TextStyle().setHintColor.s13.regular,
      border: InputBorder.none,
      prefixIcon: AppAssets.svg.baseSvg.search
          .svg(height: AppSize.sH8)
          .paddingAll(AppPadding.pH12),
      enabledBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: AppColors.white),
      ),
    );
  }

  /// Builds input field decoration
  InputDecoration buildInputDecoration({
    required Widget? prefixIcon,
    required String? hint,
  }) {
    final borderRadius = BorderRadius.circular(AppCircular.r10);
    final defaultBorder = OutlineInputBorder(
      borderRadius: borderRadius,
      borderSide: const BorderSide(color: AppColors.border),
    );

    final errorBorder = OutlineInputBorder(
      borderRadius: borderRadius,
      borderSide: const BorderSide(color: AppColors.error),
    );

    final contentPadding = EdgeInsets.symmetric(
      horizontal: AppPadding.pW8,
      vertical: AppPadding.pH14,
    );
    return InputDecoration(
      prefixIcon: prefixIcon,
      contentPadding: contentPadding,
      hintText: hint,
      fillColor: AppColors.white,
      filled: true,
      enabledBorder: defaultBorder,
      border: defaultBorder,
      focusedBorder: defaultBorder,
      errorBorder: errorBorder,
      focusedErrorBorder: errorBorder,
      hintStyle: const TextStyle().setHintColor.s13.regular,
      errorStyle: const TextStyle().setErrorColor.s12.regular,
    );
  }
}

/// Reusable custom dropdown field
class CustomDropdownField<T> extends StatefulWidget
    with CustomDropdownHelpers<T> {
  @override
  final String Function(T?) itemToString;
  @override
  final String Function(T)? itemImageUrl;
  final String? Function(T?)? validator;
  final void Function(T?)? onChanged;
  final T? selectedItem;
  final String? hint;
  final String? title;
  final Future<List<T>> Function(String, LoadProps?)? asyncItems;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool isOptional;
  final Widget Function(BuildContext, T?)? customSelectedItemBuilder;

  const CustomDropdownField({
    super.key,
    required this.itemToString,
    this.asyncItems,
    this.validator,
    this.onChanged,
    this.hint,
    this.selectedItem,
    this.title,
    this.prefixIcon,
    this.isOptional = false,
    this.customSelectedItemBuilder,
    this.itemImageUrl,
    this.suffixIcon,
  });

  @override
  State<CustomDropdownField<T>> createState() => _CustomDropdownFieldState<T>();
}

class _CustomDropdownFieldState<T> extends State<CustomDropdownField<T>> {
  final ValueNotifier<bool> showSearchNotifier = ValueNotifier<bool>(false);

  @override
  void dispose() {
    showSearchNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: AppMargin.mH6,
      children: [
        if (widget.title != null) ...[
          if (widget.isOptional) ...[
            Text(
              widget.title!,
              style: const TextStyle().setMainTextColor.s13.regular,
            ),
          ] else ...[
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              spacing: AppMargin.mW2,
              children: [
                Text(
                  "*",
                  style: const TextStyle()
                      .setColor(const Color(0xffD92D20))
                      .s13
                      .regular,
                ),
                Text(
                  widget.title!,
                  style: const TextStyle().setMainTextColor.s13.regular,
                ),
              ],
            ),
          ],
        ],
        DropdownSearch<T>(
          onChanged: widget.onChanged,
          selectedItem: widget.selectedItem,
          items: widget.asyncItems,
          suffixProps: suffixProps,
          dropdownBuilder: widget.customSelectedItemBuilder,
          compareFn: (item, selected) => item == selected,
          autoValidateMode: AutovalidateMode.onUserInteraction,
          itemAsString: widget.itemToString,
          decoratorProps: DropDownDecoratorProps(
            decoration: widget.buildInputDecoration(
              prefixIcon: widget.prefixIcon,
              hint: widget.hint,
            ),
          ),
          validator:
              widget.validator ??
              (value) =>
                  Validators.validateDropDown(value, fieldTitle: widget.title),
          popupProps: widget.buildPopupProps(
            title: widget.title ?? ConstantManager.emptyText,
            context: context,
            showSearchNotifier: showSearchNotifier,
            onDismissed: () => showSearchNotifier.value = false,
          ),
        ),
      ],
    );
  }
}

final suffixProps = DropdownSuffixProps(
  clearButtonProps: ClearButtonProps(
    isVisible: true,
    icon: AppAssets.svg.baseSvg.dropDownClose.svg(height: AppSize.sH20),
    alignment: Alignment.centerLeft,
  ),
  dropdownButtonProps: DropdownButtonProps(
    padding: EdgeInsets.zero,
    iconOpened: AppAssets.svg.baseSvg.dropDownArrowDown.svg(height: AppSize.sH8),
    iconClosed: AppAssets.svg.baseSvg.dropDownArrowDown.svg(height: AppSize.sH8),
    visualDensity: const VisualDensity(horizontal: 0, vertical: 0),
  ),
);
