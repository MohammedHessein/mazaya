# 🏛️ Mazaya App – Project Constitution
# The immutable laws of this codebase.

## 1. Architecture Law: Separation of Concerns
- All source code MUST live under `lib/src`.
- Use `lib/src/config/` for app configuration (themes, assets, localization, constants).
- Use `lib/src/core/` for global shared infrastructure.
- Use `lib/src/features/` for feature-specific modules.
- Features MUST follow a consistent structure: `entity/`, `presentation/` (with `cubits/`, `view/`, `widgets/`, `imports/`).

## 2. State Management Law: AsyncCubit Standard
- All feature-level state management MUST extend `AsyncCubit<T>` or `PaginatedCubit<T>`.
- Use `executeAsync()` to handle loading, data, and error states automatically.
- Use `BaseStatus.when()` for exhaustive state handling in the UI layer.
- State updates for CRUD operations should be done locally where possible.

## 3. Navigation Law: Go Utility Only
- Always use the `Go` class for navigation (e.g., `Go.to(Screen())`, `Go.off(Screen())`, `Go.offAll(Screen())`).
- `Go.back()` for popping, `Go.backToInitial()` to pop to root.
- Custom transitions via `TransitionType` parameter: `Go.to(Page(), transition: TransitionType.fade)`.
- Named routes supported via `Go.toNamed()`, `Go.offNamed()`, `Go.offAllNamed()`.
- Do NOT use `Navigator.push` directly.

## 4. UI Law: Component Reuse & Styling
- Always check `lib/src/core/widgets/` for reusable components before building new ones.
- Use `DefaultScaffold` for ALL screens with its `headerType` parameter (`home`, `auth`, `standard`, `profile`).
- Access sizes via `AppPadding`, `AppSize`, `AppMargin`, `AppCircular`, `FontSizeManager`.
- Access colors via `AppColors` (light mode) or `AppColorsWithDarkMode`.
- Use `IconWidget` for all icons, `CachedImage` for network images, `UniversalMediaWidget` for mixed media.
- Use `SizedBoxHelper` extension (e.g., `10.szH`, `15.szW`) for spacing.
- Use `TextStyleEx` extensions for text styling (e.g., `context.textStyle.s16.bold.setWhiteColor`).

## 5. Dependency Injection Law: Injectable
- Register all Cubits using `@injectable`.
- Register core services using `@LazySingleton`.
- Access dependencies via `injector<T>()` (global `GetIt` instance).
- Always run `build_runner` after adding/modifying injectable components.

## 6. Localization Law: Zero Hardcoding
- Use `easy_localization` and generated `LocaleKeys` for all user-facing strings.
- Arabic is the primary locale; ensure RTL compatibility (use `start`/`end` instead of `left`/`right`).
- Translation files in `assets/translations/`, keys generated to `lib/src/config/language/locale_keys.g.dart`.

## 7. Typography Law: Madani Font Family
- The app uses the **Madani Arabic** font family exclusively.
- Weights: Thin (100), Extra Light (200), Light (300), Regular (400), Medium (500), Semi Bold (600), Bold (700), Extra Bold (800), Black (900).
- Always use `ConstantManager.fontFamily` or the theme defaults.

## 8. Responsive Design Law: ScreenUtil
- Use `flutter_screenutil` for all sizing (`.h`, `.w`, `.sp`, `.r`).
- Design size: **375 × 911** (set in `ScreenSizes`).
- Never hardcode pixel values without responsive suffixes.
