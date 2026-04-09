import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../config/language/locale_keys.g.dart';
import '../../../../core/widgets/scaffolds/default_scaffold.dart';
import '../../../../core/widgets/scaffolds/header_config.dart';
import 'discount_calculator_form.dart';

class ScannerManualForm extends StatelessWidget {
  final Function(double, double?) onContinue;

  const ScannerManualForm({super.key, required this.onContinue});

  @override
  Widget build(BuildContext context) {
    return DefaultScaffold(
      header: HeaderConfig(title: LocaleKeys.scan, showBackButton: false),
      slivers: [
        SliverPadding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
          sliver: SliverToBoxAdapter(
            child: DiscountCalculatorForm(
              showTitle: false,
              onContinue: onContinue,
            ),
          ),
        ),
      ],
    );
  }
}
