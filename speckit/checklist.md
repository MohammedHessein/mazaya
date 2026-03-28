# ✅ Mazaya App – Development Checklist

### 1. Structure & Scaffolding
- [ ] Module created in `lib/src/features/<feature_name>/`.
- [ ] Feature follows structure: `entity/`, `presentation/` (`cubits/`, `view/`, `widgets/`, `imports/`).
- [ ] Cubit extends `AsyncCubit<T>` or `PaginatedCubit<T>`.
- [ ] Feature imports consolidated in `presentation/imports/view_imports.dart`.

### 2. Logic & Data
- [ ] Cubit uses `@injectable`.
- [ ] API calls triggered via `executeAsync()`.
- [ ] `baseCrudUseCase.call()` used with correct `CrudBaseParams`.
- [ ] Data mapper correctly transforms JSON to entity.
- [ ] API endpoint added to `ApiConstants`.

### 3. UI & Styling
- [ ] Screen uses `DefaultScaffold` with correct `ScaffoldHeaderType`.
- [ ] Navigation uses `Go` utility (not `Navigator.push`).
- [ ] Icons use `IconWidget` or `UniversalMediaWidget`.
- [ ] Network images use `CachedImage`.
- [ ] Colors accessed via `AppColors` tokens.
- [ ] Sizes use `AppPadding`, `AppSize`, `AppMargin`, `AppCircular` with `.h`/`.w`/`.r`.
- [ ] Spacing uses `SizedBoxHelper` (`10.szH`, `15.szW`).
- [ ] Text styles use `TextStyleEx` chain (`context.textStyle.s16.bold.setWhiteColor`).
- [ ] RTL compatibility verified (`start`/`end` used, not `left`/`right`).

### 4. Localization
- [ ] Strings added to translation JSON files (`assets/translations/`).
- [ ] `LocaleKeys` regenerated via `dart run generate/strings/main.dart`.
- [ ] All user-facing strings use `.tr()` extension.

### 5. State Handling UI
- [ ] Loading state handled (skeleton builder or loading indicator).
- [ ] Error state handled (error view or message).
- [ ] Empty state handled (`EmptyWidget` or custom).
- [ ] `AsyncBlocBuilder` or `BaseStatus.when()` used for exhaustive state handling.

### 6. Final Polish
- [ ] `flutter analyze` passes.
- [ ] No hardcoded strings or print statements.
- [ ] Code formatted with `dart format`.
- [ ] `build_runner` executed after DI changes.
- [ ] Feature accessible from navigation (route registered or button linked).
