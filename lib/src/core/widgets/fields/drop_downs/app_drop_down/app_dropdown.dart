import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../config/language/locale_keys.g.dart';
import '../../../../../config/res/assets.gen.dart';
import '../../../../../config/res/config_imports.dart';
import '../../../../extensions/context_extension.dart';
import '../../../../extensions/text_style_extensions.dart';
import '../../../../helpers/validators.dart';
import '../../text_fields/custom_text_field.dart';

class AppDropdown<T> extends StatefulWidget {
  const AppDropdown({
    super.key,
    this.suffixIconColor,
    this.validator,
    required this.onChanged,
    required List<T> items,
    this.isOptional = false,
    this.isBordered = true,
    this.label,
    this.labelTextStyle,
    this.hintTextStyle,
    this.style,
    this.value,
    this.fillColor,
    this.borderRadius,
    required this.itemAsString,
    this.hint,
    this.formKey,
    this.autovalidateMode,
    this.contentPadding,
    this.maxHeight,
    this.height,
    this.isFailer = false,
    this.isLoading = false,
    this.showSearchBox = true,
    this.showHeader = false,
    this.itemHeight = 56.0,
    this.minBottomSheetHeight = 200.0,
    this.isMultiSelect = false,
    this.selectedValues,
    this.onMultiChanged,
    this.maxSelectableItems,
    this.selectAllText = "Select All",
    this.showSelectAll = false,
    this.readonly = false,
    this.showCustomHeaderMessage = false,
    this.customHeaderMessage,
  }) : _items = items,
       assert(
         !isMultiSelect || (selectedValues != null && onMultiChanged != null),
         'selectedValues and onMultiChanged must be provided when isMultiSelect is true',
       );

  final GlobalKey<FormState>? formKey;
  final EdgeInsetsGeometry? contentPadding;
  final List<T> _items;
  final bool isOptional,
      showSearchBox,
      isBordered,
      showHeader,
      isFailer,
      isLoading,
      isMultiSelect,
      showSelectAll,
      readonly,
      showCustomHeaderMessage;
  final Color? fillColor, suffixIconColor;
  final T? value;
  final String? label, hint, selectAllText, customHeaderMessage;
  final TextStyle? labelTextStyle, hintTextStyle, style;
  final double? maxHeight, height;
  final String? Function(T?)? validator;
  final String Function(T) itemAsString;
  final BorderRadius? borderRadius;
  final Function(T?)? onChanged;
  final AutovalidateMode? autovalidateMode;
  final double itemHeight, minBottomSheetHeight;
  final List<T>? selectedValues;
  final Function(List<T>)? onMultiChanged;
  final int? maxSelectableItems;

  @override
  State<AppDropdown<T>> createState() => _AppDropdownState<T>();
}

class _AppDropdownState<T> extends State<AppDropdown<T>> {
  late ValueNotifier<T?> _bottomSheetSelectedValueNotifier;
  late ValueNotifier<List<T>> _bottomSheetSelectedValuesNotifier;
  late ValueNotifier<List<T>> _bottomSheetFilteredItemsNotifier;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _bottomSheetSelectedValueNotifier = ValueNotifier<T?>(widget.value);
    _bottomSheetSelectedValuesNotifier = ValueNotifier<List<T>>(
      widget.selectedValues ?? [],
    );
    _bottomSheetFilteredItemsNotifier = ValueNotifier<List<T>>(widget._items);
    _searchController.addListener(_filterBottomSheetItems);
  }

  @override
  void didUpdateWidget(AppDropdown<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.value != oldWidget.value) {
      _bottomSheetSelectedValueNotifier.value = widget.value;
    }
    if (widget.selectedValues != oldWidget.selectedValues) {
      _bottomSheetSelectedValuesNotifier.value = widget.selectedValues ?? [];
    }
    if (widget._items != oldWidget._items) {
      _bottomSheetFilteredItemsNotifier.value = widget._items;
      _searchController.clear();
    }
  }

  @override
  void dispose() {
    _bottomSheetSelectedValueNotifier.dispose();
    _bottomSheetSelectedValuesNotifier.dispose();
    _bottomSheetFilteredItemsNotifier.dispose();
    _searchController.removeListener(_filterBottomSheetItems);
    _searchController.dispose();
    super.dispose();
  }

  void _filterBottomSheetItems() {
    final query = _searchController.text.toLowerCase();
    _bottomSheetFilteredItemsNotifier.value = query.isEmpty
        ? widget._items
        : widget._items
              .where(
                (element) =>
                    widget.itemAsString(element).toLowerCase().contains(query),
              )
              .toList();
  }

  /// Calculates the optimal height for the bottom sheet, ensuring it doesn't
  /// get obscured by the on-screen keyboard.
  double _calculateBottomSheetHeight(BuildContext context, int itemCount) {
    final screenHeight = MediaQuery.of(context).size.height;
    final keyboardHeight = MediaQuery.of(context).viewInsets.bottom;
    final availableHeight = screenHeight - keyboardHeight;

    const double topHandleAndPadding = 28.0;
    final double headerHeight = widget.showHeader ? 50.0 : 0.0;
    final double customHeaderHeight =
        widget.showCustomHeaderMessage && widget.customHeaderMessage != null
        ? 80.0
        : 0.0;
    final double searchBoxHeight = widget.showSearchBox ? (56.0 + 16.0) : 0.0;
    final double effectiveItemHeight = widget.itemHeight + 12.0;
    final double itemsTotalHeight = itemCount * effectiveItemHeight;
    const double confirmButtonHeight = 70.0;

    final double totalContentHeight =
        topHandleAndPadding +
        headerHeight +
        customHeaderHeight +
        searchBoxHeight +
        itemsTotalHeight +
        confirmButtonHeight;

    final double maxAllowedHeight = widget.maxHeight ?? (screenHeight * 0.75);

    final double calculatedHeight = totalContentHeight.clamp(
      widget.minBottomSheetHeight,
      maxAllowedHeight,
    );

    return calculatedHeight > availableHeight
        ? availableHeight
        : calculatedHeight;
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<dynamic>(
      valueListenable: widget.isMultiSelect
          ? _bottomSheetSelectedValuesNotifier
          : _bottomSheetSelectedValueNotifier,
      builder: (context, value, child) {
        return FormField<dynamic>(
          key: widget.formKey,
          validator: (v) {
            if (widget.validator != null) {
              if (widget.isMultiSelect) {
                final List<T> selectedValues = value as List<T>? ?? [];
                return widget.validator!(
                  selectedValues.isEmpty ? null : selectedValues.first,
                );
              } else {
                return widget.validator!(value);
              }
            }
            return null;
          },
          autovalidateMode:
              widget.autovalidateMode ?? AutovalidateMode.onUserInteraction,
          enabled: !widget.readonly,
          initialValue: value,
          builder: (FormFieldState<dynamic> state) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                if (widget.label != null) ...[
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: widget.label,
                          style:
                              widget.labelTextStyle ??
                              context.textStyle.s14.regular.setBlackColor,
                        ),
                        if (widget.isOptional) ...[
                          TextSpan(
                            text: ' (${LocaleKeys.optional})',
                            style: context.textStyle.s12.regular.setHintColor,
                          ),
                        ],
                      ],
                    ),
                  ),
                  SizedBox(height: AppSize.sH6),
                ],
                Container(
                  height: widget.height,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.r),
                    border: state.hasError
                        ? Border.all(
                            width: .5,
                            color: AppColors.error.withOpacity(0.65),
                          )
                        : null,
                  ),
                  child: GestureDetector(
                    onTap: widget.readonly
                        ? null
                        : () async {
                            if (widget.isMultiSelect) {
                              final List<T>? result =
                                  await _showMultiSelectBottomSheet(
                                    context,
                                    _bottomSheetSelectedValuesNotifier.value,
                                  );
                              if (result != null) {
                                _bottomSheetSelectedValuesNotifier.value =
                                    result;
                                widget.onMultiChanged?.call(result);
                                state.didChange(result);
                                state.validate();
                              }
                            } else {
                              final T? result = await _showBottomSheet(
                                context,
                                _bottomSheetSelectedValueNotifier.value,
                              );
                              if (result != null) {
                                _bottomSheetSelectedValueNotifier.value =
                                    result;
                                widget.onChanged?.call(result);
                                state.didChange(result);
                                state.validate();
                              }
                            }
                          },
                    child: Container(
                      padding:
                          widget.contentPadding ??
                          EdgeInsets.all(AppPadding.pH12),
                      decoration: BoxDecoration(
                        color: widget.readonly
                            ? AppColors.grey2.withOpacity(0.3)
                            : widget.fillColor ?? AppColors.white,
                        borderRadius:
                            widget.borderRadius ?? BorderRadius.circular(12.r),
                        border: Border.all(
                          color: state.hasError
                              ? AppColors.error
                              : (widget.isBordered
                                    ? AppColors.border
                                    : Colors.transparent),
                          width: state.hasError ? 1.0 : 0.5,
                        ),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              _getDisplayText(context, value),
                              style:
                                  widget.style ??
                                  (_isValueEmpty(value)
                                      ? (widget.hintTextStyle ??
                                            context
                                                .textStyle
                                                .s12
                                                .regular
                                                .setHintColor)
                                      : context.textStyle.s14.regular.setColor(
                                          widget.readonly
                                              ? AppColors.grey1
                                              : AppColors.black,
                                        )),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          _getSuffixWidget(),
                        ],
                      ),
                    ),
                  ),
                ),
                if (state.hasError && state.errorText != null)
                  Padding(
                    padding: EdgeInsetsDirectional.only(
                      top: 6.0.h,
                      start: 16.w,
                    ),
                    child: Text(
                      state.errorText!,
                      style: context.textStyle.s12.regular.setColor(
                        AppColors.error,
                      ),
                    ),
                  ),
              ],
            );
          },
        );
      },
    );
  }

  bool _isValueEmpty(dynamic value) {
    if (widget.isMultiSelect) {
      return value == null || (value as List<T>).isEmpty;
    }
    return value == null;
  }

  String _getDisplayText(BuildContext context, dynamic value) {
    if (widget.isLoading) return LocaleKeys.loading;
    if (widget.isFailer) return LocaleKeys.exceptionError;

    if (widget.isMultiSelect) {
      final List<T> selectedValues = value as List<T>? ?? [];
      if (selectedValues.isEmpty) {
        return widget.hint ?? LocaleKeys.selectAnOption;
      } else {
        return selectedValues.map(widget.itemAsString).join(', ');
      }
    } else {
      if (value == null) {
        return widget.hint ?? LocaleKeys.selectAnOption;
      }
      return widget.itemAsString.call(value);
    }
  }

  Widget _getSuffixWidget() {
    if (widget.isLoading) {
      return SizedBox(
        width: 20.w,
        height: 20.h,
        child: const CircularProgressIndicator(
          strokeWidth: 2.0,
          color: AppColors.primary,
        ),
      );
    }
    if (widget.isFailer) {
      return Icon(Icons.error_outline, color: AppColors.error, size: 20.h);
    }
    if (widget.readonly) {
      return const SizedBox.shrink();
    }
    return AppAssets.svg.baseSvg.arrowDown.svg(
      colorFilter: ColorFilter.mode(
        widget.suffixIconColor ?? AppColors.black,
        BlendMode.srcIn,
      ),
    );
  }

  Future<T?> _showBottomSheet(BuildContext context, T? currentSelection) async {
    if (widget.isLoading || widget.isFailer || widget.readonly) return null;

    _searchController.clear();
    _bottomSheetFilteredItemsNotifier.value = widget._items;
    _bottomSheetSelectedValueNotifier.value = currentSelection;

    return await showModalBottomSheet<T>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (modalContext) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(modalContext).viewInsets.bottom,
          ),
          child: ValueListenableBuilder<List<T>>(
            valueListenable: _bottomSheetFilteredItemsNotifier,
            builder: (context, filteredItems, child) {
              final double dynamicHeight = _calculateBottomSheetHeight(
                context,
                filteredItems.length,
              );

              return Container(
                height: dynamicHeight,
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(12.r),
                  ),
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12.0),
                      child: Container(
                        width: AppSize.sH85,
                        height: 4,
                        decoration: BoxDecoration(
                          color: AppColors.grey1,
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                    ),
                    if (widget.showHeader)
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: AppPadding.pH16,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              widget.label ?? LocaleKeys.selectAnOption,
                              style:
                                  widget.labelTextStyle ??
                                  context.textStyle.s16.bold.setMainTextColor,
                            ),
                            IconButton(
                              icon: const Icon(Icons.close),
                              onPressed: () => Navigator.pop(context),
                            ),
                          ],
                        ),
                      ),
                    if (widget.showSearchBox)
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: AppPadding.pH16,
                          vertical: AppPadding.pH8,
                        ),
                        child: CustomTextFiled(
                          hint: LocaleKeys.search,
                          suffixIcon: AppAssets.svg.baseSvg.search.svg(),
                          controller: _searchController,
                          textInputType: TextInputType.text,
                          textInputAction: TextInputAction.search,
                          validator: (value) => Validators.noValidate(value!),
                        ),
                      ),
                    Expanded(child: _buildItemsList(context, filteredItems)),
                    Padding(
                      padding: EdgeInsets.all(AppPadding.pH16),
                      child: SizedBox(
                        width: double.infinity,
                        child: ValueListenableBuilder<T?>(
                          valueListenable: _bottomSheetSelectedValueNotifier,
                          builder: (context, selectedValue, _) {
                            final bool isEnabled = selectedValue != null;
                            return ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: isEnabled
                                    ? AppColors.primary
                                    : AppColors.grey2,
                                padding: EdgeInsets.symmetric(vertical: 14.h),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.r),
                                ),
                              ),
                              onPressed: isEnabled
                                  ? () => Navigator.pop(context, selectedValue)
                                  : null,
                              child: Text(
                                LocaleKeys.confirm,
                                style: context.textStyle.s18.medium.setColor(
                                  isEnabled ? AppColors.white : AppColors.grey1,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }

  Future<List<T>?> _showMultiSelectBottomSheet(
    BuildContext context,
    List<T> currentSelection,
  ) async {
    if (widget.isLoading || widget.isFailer || widget.readonly) return null;

    _searchController.clear();
    _bottomSheetFilteredItemsNotifier.value = widget._items;
    _bottomSheetSelectedValuesNotifier.value = List<T>.from(currentSelection);

    return await showModalBottomSheet<List<T>>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (modalContext) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(modalContext).viewInsets.bottom,
          ),
          child: ValueListenableBuilder<List<T>>(
            valueListenable: _bottomSheetFilteredItemsNotifier,
            builder: (context, filteredItems, child) {
              final int totalItems =
                  filteredItems.length + (widget.showSelectAll ? 1 : 0);
              final double dynamicHeight = _calculateBottomSheetHeight(
                context,
                totalItems,
              );

              return Container(
                height: dynamicHeight,
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(12.r),
                  ),
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12.0),
                      child: Container(
                        width: AppSize.sH85,
                        height: 4,
                        decoration: BoxDecoration(
                          color: AppColors.grey1,
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                    ),
                    if (widget.showHeader)
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: AppPadding.pH16,
                        ),
                        child: Row(
                          children: [
                            Text(
                              widget.label ?? LocaleKeys.selectAnOption,
                              style:
                                  widget.labelTextStyle ??
                                  context.textStyle.s16.bold.setMainTextColor,
                            ),
                            const Spacer(),
                            ValueListenableBuilder<List<T>>(
                              valueListenable:
                                  _bottomSheetSelectedValuesNotifier,
                              builder: (context, selectedValues, _) {
                                return Text(
                                  "${selectedValues.length} ",
                                  style: context
                                      .textStyle
                                      .s14
                                      .regular
                                      .setHintColor,
                                );
                              },
                            ),
                            IconButton(
                              icon: const Icon(Icons.close),
                              onPressed: () => Navigator.pop(context),
                            ),
                          ],
                        ),
                      ),
                    // Custom Header Message
                    if (widget.showCustomHeaderMessage &&
                        widget.customHeaderMessage != null)
                      Container(
                        margin: EdgeInsets.symmetric(
                          horizontal: AppPadding.pH16,
                          vertical: AppPadding.pH8,
                        ),
                        padding: EdgeInsets.all(AppPadding.pH12),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        child: Column(
                          children: [
                            Text(
                              widget.hint ?? '',
                              style: context.textStyle.s16.bold.setColor(
                                AppColors.black,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: 4.h),
                            Text(
                              widget.customHeaderMessage!,
                              style: context.textStyle.s12.regular.setColor(
                                AppColors.hintText,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    if (widget.showSearchBox)
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: AppPadding.pH16,
                          vertical: AppPadding.pH8,
                        ),
                        child: CustomTextFiled(
                          hint: LocaleKeys.search,
                          suffixIcon: AppAssets.svg.baseSvg.search.svg(),
                          controller: _searchController,
                          textInputType: TextInputType.text,
                          textInputAction: TextInputAction.search,
                          validator: (value) => Validators.noValidate(value!),
                        ),
                      ),
                    Expanded(
                      child: _buildMultiSelectItemsList(context, filteredItems),
                    ),
                    Padding(
                      padding: EdgeInsets.all(AppPadding.pH16),
                      child: SizedBox(
                        width: double.infinity,
                        child: ValueListenableBuilder<List<T>>(
                          valueListenable: _bottomSheetSelectedValuesNotifier,
                          builder: (context, selectedValues, _) {
                            return ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.primary,
                                padding: EdgeInsets.symmetric(vertical: 14.h),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.r),
                                ),
                              ),
                              onPressed: () =>
                                  Navigator.pop(context, selectedValues),
                              child: Text(
                                "${LocaleKeys.confirm} (${selectedValues.length})",
                                style:
                                    context.textStyle.s18.setWhiteColor.medium,
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }

  Widget _buildItemsList(BuildContext context, List<T> items) {
    if (items.isEmpty) {
      return Center(
        child: Text(
          _searchController.text.isNotEmpty
              ? LocaleKeys.noResultFound
              : LocaleKeys.noOptionsFound,
          style: context.textStyle.s14.regular.setHintColor,
        ),
      );
    }

    return ListView.separated(
      padding: EdgeInsets.symmetric(
        horizontal: AppPadding.pH16,
        vertical: 10.h,
      ),
      itemCount: items.length,
      separatorBuilder: (context, index) => SizedBox(height: 12.h),
      itemBuilder: (context, index) {
        final item = items[index];
        return ValueListenableBuilder<T?>(
          valueListenable: _bottomSheetSelectedValueNotifier,
          builder: (context, selectedValue, _) {
            final isSelected = item == selectedValue;
            return InkWell(
              onTap: () {
                _bottomSheetSelectedValueNotifier.value = item;
              },
              borderRadius: BorderRadius.circular(12.r),
              child: Container(
                height: widget.itemHeight,
                decoration: BoxDecoration(
                  color: isSelected
                      ? AppColors.primary.withOpacity(0.08)
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(
                    color: isSelected
                        ? AppColors.primary
                        : AppColors.grey2.withOpacity(0.3),
                    width: isSelected ? 1.5 : 0.5,
                  ),
                ),
                padding: EdgeInsets.symmetric(
                  vertical: 16.0.h,
                  horizontal: 20.0.w,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        widget.itemAsString(item),
                        style: isSelected
                            ? context.textStyle.s16.medium.setColor(
                                AppColors.primary,
                              )
                            : context.textStyle.s16.regular.setMainTextColor,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    SizedBox(width: 16.w),
                    Container(
                      width: 20.w,
                      height: 20.w,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: isSelected
                              ? AppColors.primary
                              : AppColors.grey1,
                          width: 2.0,
                        ),
                      ),
                      child: isSelected
                          ? Center(
                              child: Container(
                                width: 10.w,
                                height: 10.w,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: AppColors.primary,
                                ),
                              ),
                            )
                          : null,
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildMultiSelectItemsList(BuildContext context, List<T> items) {
    if (items.isEmpty &&
        _searchController.text.isEmpty &&
        !widget.showSelectAll) {
      return Center(
        child: Text(
          LocaleKeys.noOptionsFound,
          style: context.textStyle.s14.regular.setHintColor,
        ),
      );
    }

    return ListView.separated(
      padding: EdgeInsets.symmetric(
        horizontal: AppPadding.pH16,
        vertical: 10.h,
      ),
      itemCount: items.length + (widget.showSelectAll ? 1 : 0),
      separatorBuilder: (context, index) => SizedBox(height: 12.h),
      itemBuilder: (context, index) {
        if (widget.showSelectAll && index == 0) {
          return _buildSelectAllTile(context, items);
        }

        final int itemIndex = widget.showSelectAll ? index - 1 : index;
        if (itemIndex >= items.length) return const SizedBox.shrink();

        final item = items[itemIndex];
        return _buildMultiSelectItemTile(context, item);
      },
    );
  }

  Widget _buildSelectAllTile(BuildContext context, List<T> filteredItems) {
    return ValueListenableBuilder<List<T>>(
      valueListenable: _bottomSheetSelectedValuesNotifier,
      builder: (context, selectedValues, _) {
        final bool isAllFilteredSelected =
            filteredItems.isNotEmpty &&
            filteredItems.every((item) => selectedValues.contains(item));

        return InkWell(
          onTap: () {
            final List<T> currentSelected = List.from(
              _bottomSheetSelectedValuesNotifier.value,
            );
            if (isAllFilteredSelected) {
              currentSelected.removeWhere((val) => filteredItems.contains(val));
            } else {
              for (var item in filteredItems) {
                if (!currentSelected.contains(item)) {
                  if (widget.maxSelectableItems == null ||
                      currentSelected.length < widget.maxSelectableItems!) {
                    currentSelected.add(item);
                  }
                }
              }
            }
            _bottomSheetSelectedValuesNotifier.value = currentSelected;
          },
          borderRadius: BorderRadius.circular(12.r),
          child: Container(
            height: widget.itemHeight,
            padding: EdgeInsets.symmetric(vertical: 16.0.h, horizontal: 20.0.w),
            decoration: BoxDecoration(
              color: isAllFilteredSelected
                  ? AppColors.primary.withOpacity(0.08)
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(
                color: isAllFilteredSelected
                    ? AppColors.primary
                    : AppColors.grey2.withOpacity(0.3),
                width: isAllFilteredSelected ? 1.5 : 0.5,
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    widget.selectAllText ?? '',
                    style: isAllFilteredSelected
                        ? context.textStyle.s16.medium.setColor(
                            AppColors.primary,
                          )
                        : context.textStyle.s16.regular.setMainTextColor,
                  ),
                ),
                SizedBox(width: 16.w),
                _buildCheckbox(isAllFilteredSelected),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildMultiSelectItemTile(BuildContext context, T item) {
    return ValueListenableBuilder<List<T>>(
      valueListenable: _bottomSheetSelectedValuesNotifier,
      builder: (context, selectedValues, _) {
        final isSelected = selectedValues.contains(item);
        final canSelect =
            widget.maxSelectableItems == null ||
            selectedValues.length < widget.maxSelectableItems! ||
            isSelected;

        return InkWell(
          onTap: canSelect
              ? () {
                  final List<T> newSelectedValues = List.from(selectedValues);
                  if (isSelected) {
                    newSelectedValues.remove(item);
                  } else {
                    newSelectedValues.add(item);
                  }
                  _bottomSheetSelectedValuesNotifier.value = newSelectedValues;
                }
              : null,
          borderRadius: BorderRadius.circular(12.r),
          child: Opacity(
            opacity: canSelect ? 1.0 : 0.5,
            child: Container(
              height: widget.itemHeight,
              padding: EdgeInsets.symmetric(
                vertical: 16.0.h,
                horizontal: 20.0.w,
              ),
              decoration: BoxDecoration(
                color: isSelected
                    ? AppColors.primary.withOpacity(0.08)
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(
                  color: isSelected
                      ? AppColors.primary
                      : AppColors.grey2.withOpacity(0.3),
                  width: isSelected ? 1.5 : 0.5,
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      widget.itemAsString(item),
                      style: isSelected
                          ? context.textStyle.s16.medium.setColor(
                              AppColors.primary,
                            )
                          : context.textStyle.s16.regular.setMainTextColor,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  SizedBox(width: 16.w),
                  _buildCheckbox(isSelected),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildCheckbox(bool isSelected) {
    return Container(
      width: 20.w,
      height: 20.w,
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(4.r),
        border: Border.all(
          color: isSelected ? AppColors.primary : AppColors.grey1,
          width: 2.w,
        ),
        color: isSelected ? AppColors.primary : Colors.transparent,
      ),
      child: isSelected
          ? Icon(Icons.check, size: 14.w, color: AppColors.white)
          : null,
    );
  }
}
