import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mazaya/src/config/language/locale_keys.g.dart';
import 'package:mazaya/src/config/res/config_imports.dart';
import 'package:mazaya/src/core/widgets/scaffolds/default_scaffold.dart';
import 'package:mazaya/src/core/widgets/scaffolds/header_config.dart';
import 'package:mazaya/src/core/widgets/tools/bloc_builder/async_bloc_builder.dart';
import 'package:mazaya/src/core/widgets/universal_media/enums.dart';
import 'package:mazaya/src/features/categories/presentation/cubits/categories_cubit.dart';
import 'package:mazaya/src/features/categories/presentation/widgets/categories_grid.dart';
import 'package:mazaya/src/features/home/model/category_model.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => injector<CategoriesCubit>()..getCategories(),
      child: DefaultScaffold(
        header: HeaderConfig(
          showBackButton: false,
          title: LocaleKeys.categories,
          type: ScaffoldHeaderType.standard,
        ),
        slivers: [
          SliverFillRemaining(
            hasScrollBody: true,
            child: Container(
              color: AppColors.bgF7,
              child: AsyncBlocBuilder<CategoriesCubit, List<CategoryModel>>(
                skeletonBuilder: (context) => CategoriesGrid(
                  categories: List.generate(
                    7,
                    (index) => CategoryModel.initial(),
                  ),
                ),
                builder: (context, categories) {
                  return SingleChildScrollView(
                    padding: EdgeInsets.all(AppPadding.pW20),
                    child: CategoriesGrid(categories: categories),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
