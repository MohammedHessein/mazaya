import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mazaya/src/config/language/locale_keys.g.dart';
import 'package:mazaya/src/config/res/config_imports.dart';
import 'package:mazaya/src/core/extensions/context_extension.dart';
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

class _DiscountCalculatorFormState extends State<DiscountCalculatorForm> {
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _manualDiscountController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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
      if (widget.coupon!.discountType?.toLowerCase() == 'percentage') {
        _discountAmount = _originalPrice * (discount / 100);
      } else {
        _discountAmount = discount;
      }
    } else {
      // Manual/Generic Logic
      final manualDiscountStr = _manualDiscountController.text;
      _discountAmount = double.tryParse(manualDiscountStr) ?? 0;
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
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  widget.title ?? (isGeneric ? LocaleKeys.manualDiscount : LocaleKeys.calculateDiscount),
                  style: context.textStyle.s16.bold.setBlackColor,
                ),
              ],
            ),
            4.szH,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  widget.subtitle ?? LocaleKeys.enterInvoiceAmountSubtitle,
                  style: context.textStyle.s14.light.setHintColor,
                ),
              ],
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
            AppTextField.regularLabel(
              controller: _manualDiscountController,
              label: LocaleKeys.discountAmount,
              hint: LocaleKeys.discountAmount,
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
          ],
          16.szH,
          if (_isCalculated) _buildSummaryBox(context),
          if (_isCalculated) 16.szH,
          LoadingButton(
            title: _isCalculated ? LocaleKeys.continueScanning : LocaleKeys.calculateBtn,
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
            value: '${_originalPrice.toStringAsFixed(2)} ${LocaleKeys.currencyKrona}',
            valueStyle: context.textStyle.s14.bold.setBlackColor,
          ),
          8.szH,
          _buildSummaryRow(
            context,
            title: (widget.coupon != null && widget.coupon!.discountType?.toLowerCase() == 'percentage')
                ? '${LocaleKeys.discountAmount} (%${widget.coupon!.discount})'
                : LocaleKeys.discountAmount,
            value: '${_discountAmount.toStringAsFixed(2)} ${LocaleKeys.currencyKrona}',
            valueStyle: context.textStyle.s14.bold.setBlackColor,
          ),
          12.szH,
          _buildSummaryRow(
            context,
            title: LocaleKeys.totalAfterDiscount,
            value: '${_finalPrice.toStringAsFixed(2)} ${LocaleKeys.currencyKrona}',
            valueStyle: context.textStyle.s14.bold.setBlackColor,
            titleStyle: context.textStyle.s16.medium.setBlackColor,
          ),
        ],
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
        Text(
          title,
          style: titleStyle ?? context.textStyle.s14.regular.setHintColor,
        ),
        Text(
          value,
          style: valueStyle,
          textDirection: TextDirection.ltr,
        ),
      ],
    );
  }
}
