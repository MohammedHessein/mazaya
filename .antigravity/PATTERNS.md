# Logic Patterns Guide

## Infinite Lists (PaginatedCubit)
1. **Define Cubit**: Extend `PaginatedCubit<T>`.
2. **Implement Fetch**: 
   - Override `fetchPageData(int page, {String? key})`.
   - Update `PaginatedData` with `items` and `meta`.
3. **Usage in UI**:
   - `PaginatedListWidget<Cubit, Entity>` automatically handles:
     - Pull-to-refresh.
     - Scroll threshold.
     - Empty/Error/Loading states (via `skeletonBuilder`).

## Generic Dropdowns (GetBaseEntityCubit)
1. **Define Entity**: Extend `BaseIdAndNameEntity`.
2. **Register Entity**:
   - In `lib/src/core/base_crud/code/domain/entities/base_name_and_id_entity.dart`:
     - Add to `apiPaths` in `getBaseIdAndNameEntityApi`.
     - Add to `_fromJsonFactories` in `BaseEntity`.
   - In `lib/src/core/base_crud/code/domain/base_domain_imports.dart`:
     - Add an `export 'entities/your_entity.dart';` statement.
3. **Setup Cubit**: 
   - Provide `GetBaseEntityCubit<T>()` in the screen `BlocProvider`.
   - Initialize with `..fGetBaseNameAndId()`.
3. **Usage in UI**:
   - `BlocBuilder<GetBaseEntityCubit<T>, GetBaseEntityState<T>>`.
   - Populated `AppDropdown<T>` with `state.dataState.data`.

## Complex States (AsyncCubit)
- Extend `AsyncCubit<T>`.
- Use `executeAsync` helper for standard API calls.
- States are `AsyncState<T>` providing `status`, `data`, and `errorMessage`.

## Component/Feature Creation Rules
- **Naming**: Use `_view.dart`, `_body.dart`, `_cubit.dart`.
- **Structure**: Group by feature, follow the `presentation/widgets/` pattern.
- **Rules**: 
  - Never hardcode strings, use `LocaleKeys`.
  - Never hardcode sizes, use `AppPadding`/`AppSize` (plus `.h`/`.w`).
  - Use `injector` for BLOC and Service injection.
