import 'package:flutter/material.dart';
import 'package:mazaya/src/core/extensions/widgets/sized_box_helper.dart';
import '../widgets/categories_section.dart';
import '../widgets/coupons_section.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CategoriesSection(),
          20.szH,
          const CouponsSection(),
          100.szH, // Spacing for bottom nav
        ],
      ),
    );
  }
}
