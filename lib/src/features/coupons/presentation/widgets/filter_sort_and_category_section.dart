import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../config/language/locale_keys.g.dart';
import '../../../../core/base_crud/code/domain/base_domain_imports.dart';
import '../../../../core/base_crud/code/presentation/cubit/get_base_name_and_id/get_base_name_and_id_cubit.dart';
import '../../../../core/extensions/widgets/sized_box_helper.dart';
import '../../../../core/widgets/fields/drop_downs/app_drop_down/app_dropdown.dart';

class FilterSortAndCategorySection extends StatelessWidget {
  final CategoryEntity? selectedCategory;
  final String? selectedSort;
  final Function(CategoryEntity?) onCategoryChanged;
  final Function(String?) onSortChanged;

  const FilterSortAndCategorySection({
    super.key,
    required this.selectedCategory,
    required this.selectedSort,
    required this.onCategoryChanged,
    required this.onSortChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BlocBuilder<GetBaseEntityCubit<CategoryEntity>,
            GetBaseEntityState<CategoryEntity>>(
          builder: (context, state) {
            return AppDropdown<CategoryEntity>(
              items: state.dataState.data ?? [],
              value: selectedCategory,
              onChanged: onCategoryChanged,
              itemAsString: (cat) => cat.name,
              hint: LocaleKeys.section,
              isLoading: state.dataState.isLoading,
            );
          },
        ),
        16.szH,
        AppDropdown<String>(
          items: const ['asc', 'desc'],
          value: selectedSort,
          itemAsString: (val) =>
              val == 'asc' ? LocaleKeys.sortAsc : LocaleKeys.sortDesc,
          onChanged: onSortChanged,
          hint: LocaleKeys.sortBy,
        ),
      ],
    );
  }
}
