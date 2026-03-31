import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mazaya/src/config/res/config_imports.dart';
import 'package:mazaya/src/core/extensions/widgets/sized_box_helper.dart';

import '../cubits/home_cubit.dart';
import '../widgets/categories_section.dart';
import '../widgets/coupons_section.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => injector<HomeCubit>()..getHomeData(),
      child: SliverToBoxAdapter(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [const CategoriesSection(), 20.szH, const CouponsSection()],
        ),
      ),
    );
  }
}
