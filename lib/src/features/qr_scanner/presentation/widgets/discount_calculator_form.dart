import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mazaya/src/config/language/locale_keys.g.dart';
import 'package:mazaya/src/config/res/config_imports.dart';
import 'package:mazaya/src/core/extensions/context_extension.dart';
import 'package:mazaya/src/core/extensions/string_extension.dart';
import 'package:mazaya/src/core/extensions/text_style_extensions.dart';
import 'package:mazaya/src/core/extensions/widgets/sized_box_helper.dart';
import 'package:mazaya/src/core/widgets/buttons/loading_button.dart';
import 'package:mazaya/src/core/widgets/fields/text_fields/app_text_field.dart';
import 'package:mazaya/src/features/coupons/entity/coupon_entity.dart';

class DiscountCalculatorForm extends StatefulWidget {
  final CouponEntity? coupon;
  final Function(double originalPrice, double? discountAmount) onContinue;
  final String? title;
  final String? subtitle;
  final bool showTitle;

  const DiscountCalculatorForm({
    super.key,
    this.coupon,
    required this.onContinue,
    this.title,
    this.subtitle,
    this.showTitle = true,
  });

  @override
  State<DiscountCalculatorForm> createState() => _DiscountCalculatorFormState();
}

enum _DiscountType { percentage, amount }

class _DiscountCalculatorFormState extends State<DiscountCalculatorForm> {
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _manualDiscountController =
      TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  _DiscountType _selectedType = _DiscountType.percentage;
  bool _isCalculated = false;
  double _originalPrice = 0;
  double _discountAmount = 0;
  double _finalPrice = 0;

  @override
  void initState() {
    super.initState();
    if (widget.coupon != null) {
      // Logic for specific coupon is already handled in _calculate
    }
  }

  void _calculate() {
    if (!_formKey.currentState!.validate()) return;

    final priceStr = _priceController.text;
    final price = double.tryParse(priceStr);

    if (price == null || price <= 0) return;

    _originalPrice = price;

    if (widget.coupon != null) {
      // Specific Coupon Logic
      final discount = double.tryParse(widget.coupon!.discount.toString()) ?? 0;
      final type = widget.coupon!.discountType?.toLowerCase();
      if (type == 'percentage' || type == 'percent') {
        _discountAmount = _originalPrice * (discount / 100);
      } else {
        _discountAmount = discount;
      }
    } else {
      // Manual/Generic Logic
      final manualDiscountValue =
          double.tryParse(_manualDiscountController.text) ?? 0;
      if (_selectedType == _DiscountType.percentage) {
        _discountAmount = _originalPrice * (manualDiscountValue / 100);
      } else {
        _discountAmount = manualDiscountValue;
      }
    }

    _finalPrice = _originalPrice - _discountAmount;
    if (_finalPrice < 0) _finalPrice = 0;

    setState(() {
      _isCalculated = true;
    });
  }

  @override
  void dispose() {
    _priceController.dispose();
    _manualDiscountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool isGeneric = widget.coupon == null;

    return Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (widget.showTitle) ...[
            Text(
              widget.title ??
                  (isGeneric
                      ? LocaleKeys.manualDiscount
                      : LocaleKeys.calculateDiscount),
              style: context.textStyle.s16.bold.setBlackColor,
              textAlign: TextAlign.center,
            ),
            4.szH,
            Text(
              widget.subtitle ?? LocaleKeys.enterInvoiceAmountSubtitle,
              style: context.textStyle.s14.light.setHintColor,
              textAlign: TextAlign.center,
            ),
          ],
          24.szH,
          AppTextField.regularLabel(
            controller: _priceController,
            label: LocaleKeys.originalPrice,
            hint: LocaleKeys.enterOriginalPrice,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            validator: (val) {
              if (val == null || val.isEmpty) {
                return LocaleKeys.fillField;
              }
              if (double.tryParse(val) == null) {
                return LocaleKeys.validationInvalidNumber;
              }
              return null;
            },
            onChanged: (val) {
              if (_isCalculated) {
                setState(() => _isCalculated = false);
              }
            },
          ),
          if (isGeneric) ...[
            16.szH,
            Row(
              children: [
                Expanded(
                  child: _buildTypeButton(
                    context,
                    title: '%',
                    type: _DiscountType.percentage,
                  ),
                ),
                12.szW,
                Expanded(
                  child: _buildTypeButton(
                    context,
                    title: LocaleKeys.currencyKrona,
                    type: _DiscountType.amount,
                  ),
                ),
              ],
            ),
            16.szH,
            AppTextField.regularLabel(
              controller: _manualDiscountController,
              label: _selectedType == _DiscountType.percentage
                  ? LocaleKeys.discountLabel
                  : LocaleKeys.discountAmount,
              hint: _selectedType == _DiscountType.percentage
                  ? LocaleKeys.discountLabel
                  : LocaleKeys.discountAmount,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              validator: (val) {
                if (val == null || val.isEmpty) {
                  return LocaleKeys.fillField;
                }
                if (double.tryParse(val) == null) {
                  return LocaleKeys.validationInvalidNumber;
                }
                if (_selectedType == _DiscountType.percentage) {
                  final discount = double.tryParse(val);
                  if (discount != null && discount > 100) {
                    return LocaleKeys
                        .exceptionError; // Or a more specific key if available
                  }
                }
                return null;
              },
              onChanged: (val) {
                if (_isCalculated) {
                  setState(() => _isCalculated = false);
                }
              },
            ),
          ],
          16.szH,
          if (_isCalculated) _buildSummaryBox(context),
          if (_isCalculated) 16.szH,
          LoadingButton(
            title: _isCalculated
                ? LocaleKeys.continueScanning
                : LocaleKeys.calculateBtn,
            onTap: () async {
              if (_isCalculated) {
                widget.onContinue(_originalPrice, _discountAmount);
              } else {
                _calculate();
              }
            },
          ),
          16.szH,
        ],
      ),
    );
  }

  Widget _buildSummaryBox(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        border: Border.all(color: AppColors.gray200),
        borderRadius: BorderRadius.circular(AppCircular.r14),
      ),
      padding: EdgeInsets.all(12.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            LocaleKeys.details,
            style: context.textStyle.s16.regular.setBlackColor,
          ),
          12.szH,
          _buildSummaryRow(
            context,
            title: LocaleKeys.originalPrice,
            value:
                '${_originalPrice.toStringAsFixed(2)} ${LocaleKeys.currencyKrona}',
            valueStyle: context.textStyle.s14.bold.setBlackColor,
          ),
          8.szH,
          _buildSummaryRow(
            context,
            title: _getDiscountLabel(),
            value: _getDiscountValue(),
            valueStyle: context.textStyle.s14.bold.setBlackColor,
          ),
          12.szH,
          _buildSummaryRow(
            context,
            title: LocaleKeys.totalAfterDiscount,
            value:
                '${_finalPrice.toStringAsFixed(2)} ${LocaleKeys.currencyKrona}',
            valueStyle: context.textStyle.s14.bold.setBlackColor,
            titleStyle: context.textStyle.s16.medium.setBlackColor,
          ),
        ],
      ),
    );
  }

  String _getDiscountLabel() {
    if (widget.coupon != null) {
      return LocaleKeys.discountLabel;
    }

    if (_selectedType == _DiscountType.percentage) {
      return '${LocaleKeys.discountLabel} (%${_manualDiscountController.text})';
    }
    return LocaleKeys.discountAmount;
  }

  String _getDiscountValue() {
    if (widget.coupon != null) {
      final type = widget.coupon!.discountType?.toLowerCase();
      if (type == 'percentage' || type == 'percent') {
        return '% ${widget.coupon!.discount}';
      }
      // Falling back to Krona for 'amount' or any other type
      return '${widget.coupon!.discount} ${LocaleKeys.currencyKrona}';
    }

    return '${_discountAmount.toStringAsFixed(2)} ${LocaleKeys.currencyKrona}';
  }

  Widget _buildTypeButton(
    BuildContext context, {
    required String title,
    required _DiscountType type,
  }) {
    final isSelected = _selectedType == type;
    return GestureDetector(
      onTap: () {
        if (_selectedType != type) {
          setState(() {
            _selectedType = type;
            _isCalculated = false;
          });
        }
      },
      child: Container(
        height: 45.h,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: isSelected ? context.theme.primaryColor : AppColors.white,
          borderRadius: BorderRadius.circular(AppCircular.r8),
          border: Border.all(
            color: isSelected ? context.theme.primaryColor : AppColors.gray200,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: context.theme.primaryColor.withOpacity(0.2),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ]
              : null,
        ),
        child: Text(
          title,
          style: context.textStyle.s14.medium.copyWith(
            color: isSelected ? AppColors.white : AppColors.gray500,
          ),
        ),
      ),
    );
  }

  Widget _buildSummaryRow(
    BuildContext context, {
    required String title,
    required String value,
    required TextStyle valueStyle,
    TextStyle? titleStyle,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            title,
            style: titleStyle ?? context.textStyle.s14.regular.setHintColor,
          ),
        ),
        8.szW,
        Text(value, style: valueStyle),
      ],
    );
  }
}
