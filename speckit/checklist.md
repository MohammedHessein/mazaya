# ✅ Hattrick App – Development Checklist

### 1. Structure & Scaffolding
- [ ] Module created in `lib/src/features/[type]/[feature_name]/`.
- [ ] Cubit extends `AsyncCubit<T>` or `PaginatedCubit<T>`.
- [ ] Feature imports consolidated in `presentation/imports/view_imports.dart`.

### 2. Logic & Data
- [ ] Cubit uses `@injectable`.
- [ ] API calls triggered via `executeAsync()`.
- [ ] `baseCrudUseCase.call()` used with correct `CrudBaseParams`.
- [ ] Data mapper correctly transforms JSON to entity.

### 3. UI & Styling
- [ ] Navigation uses `Go` utility.
- [ ] Icons use `IconWidget`.
- [ ] Network images use `CachedImage`.
- [ ] Colors and sizes accessed via `ColorManager` and `AppSizes`.
- [ ] RTL compatibility verified (start/end used).

### 4. Localization
- [ ] Strings added to translation JSON files.
- [ ] `LocaleKeys` regenerated.

### 5. Final Polish
- [ ] `flutter analyze` passes.
- [ ] No hardcoded strings or print statements.
- [ ] Code formatted with `dart format`.
