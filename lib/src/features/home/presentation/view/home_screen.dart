import 'package:flutter/material.dart';
import 'package:mazaya/src/core/extensions/widgets/sized_box_helper.dart';
import '../widgets/categories_section.dart';
import '../widgets/coupons_section.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [const CategoriesSection(), const CouponsSection()],
      ),
    );
  }
}
