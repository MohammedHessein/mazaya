# 🤖 Mazaya – Agent Context (Source of Truth)

This document is the **primary reference** for AI assistants working on the Mazaya project. It consolidates all architectural laws, coding standards, and project-wide patterns. **Always read this file first before proposing or implementing changes.**

---

## ├── Project Overview
- **Name**: Mazaya (مزايا)
- **Vision**: A premium coupon and loyalty platform for Arabic-speaking markets.
- **Platform**: Flutter (SDK `^3.9.0`), Target: Android & iOS.
- **Core Identity**: RTL-first design, premium aesthetics, modular feature-based structure.
- **Key Tech**: `flutter_bloc` (Cubit), `injectable` (DI), `dio` (Network), `easy_localization` (L10n).

---

## ├── Architecture
The project follows a **Modified Clean Architecture (Feature-First)** approach.

### 1. High-Level Layers
- **Domain**: Entities (`entity/`), Usecases (via `BaseCrudUseCase`).
- **Data**: Models (`model/`), Datasources, Repositories implementations.
- **Presentation**: Cubits (`cubit/`), Views (`view/`), Widgets (`widgets/`), Imports (`imports/`).

### 2. State Management (Async State Pattern)
- **Base Class**: All cubits MUST extend `AsyncCubit<T>` or `PaginatedCubit<T>`.
- **Handling**: Use `executeAsync()` for standard API calls.
- **States**: UI reacts to `AsyncState<T>` which includes `status` (initial, loading, success, error, loadingMore), `data`, and `errorMessage`.

### 3. Dependency Injection
- **Tool**: `get_it` + `injectable`.
- **Usage**: Access via `injector<T>()`.
- **Registration**: `@injectable` for Cubits, `@LazySingleton` for Services.

---

## ├── Coding Rules
### 1. Zero Hardcoding
- **Strings**: Use `LocaleKeys.key.tr()` from `easy_localization`. Supported locales: Arabic (Primary), English, Swedish.
- **Sizes**: Use `AppPadding`, `AppSize`, `AppMargin`. Apply `.h`, `.w`, `.r`, `.sp` from `flutter_screenutil`.
- **Spacing**: Use `SizedBoxHelper` extensions (e.g., `10.szH`, `15.szW`).

### 2. Navigation
- **Utility**: Use the `Go` class exclusively.
- **Methods**: `Go.to()`, `Go.off()`, `Go.offAll()`, `Go.back()`.
- **Named**: `Go.toNamed()`, `Go.offNamed()`.

### 3. UI Consistency
- **Scaffold**: Every screen MUST use `DefaultScaffold`.
- **Headers**: Choose `ScaffoldHeaderType` (`home`, `auth`, `standard`, `profile`).
- **Icons**: Use `IconWidget` or `UniversalMediaWidget`.
- **Images**: Use `CachedImage` for network images.
- **Typography**: Exclusive use of **Madani Arabic** font via `TextStyleEx` (e.g., `context.textStyle.s16.bold.setPrimaryColor`).

---

## ├── Patterns
### 1. Logic Patterns
- **Standard API Call**:
  ```dart
  await executeAsync(operation: () => baseCrudUseCase.call(params));
  ```
- **Pagination**: Extend `PaginatedCubit`, override `fetchPageData`, `parseItems`, and `parsePagination`. Use `PaginatedListWidget` in UI.

### 2. Specialized Logic Patterns
- **Location Sync**: Sync user coordinates to backend only if distance > 5km from last sync.
- **Conditional Navigation**: Evaluate data availability to decide destination (e.g., OSM for coordinates vs. WebView for links).
- **Manual Input Scanner**: Allow manual invoice/price entry before initiating camera scanning.

### 2. UI Rendering Patterns
- **AsyncBlocBuilder**: Handles skeletons, success, and error states automatically.
- **StatusBuilder**: Manual state handling via `state.status.when()`.
- **Form Handling**: Use `FormMixin` and `Validators` helper.

### 3. Feature Structure
Each feature in `lib/src/features/` must follow:
- `entity/`: Business logic objects.
- `presentation/`:
    - `cubits/`: State management.
    - `view/`: Screen and Body widgets.
    - `widgets/`: Local UI components.
    - `imports/`: `view_imports.dart` for consolidated exports.

---

## ├── Do / Don't
### ✅ Do
- Use `start`/`end` for RTL compatibility (never `left`/`right`).
- Use `SizedBoxHelper` for all spacing (`10.szH`).
- Consolidate imports in `imports/` folder for features.
- Run `build_runner` after any DI or Model changes.
- Wrap feature views with `BlocStatelessWidget` or `BlocStatefulWidget`.

### ❌ Don't
- **Don't** use `Navigator.push` or standard `Scaffold`.
- **Don't** hardcode colors (use `AppColors`).
- **Don't** hardcode pixel values without responsive suffixes (`.h`, `.w`).
- **Don't** use `print()` (use `AppLogs` or logger).
- **Don't** put business logic inside the UI layer.

---

## ├── UI Component Library
### 1. Scaffolds & Navigation
- **DefaultScaffold**: Use for ALL screens. Props: `title`, `body`, `headerType` (`home`, `auth`, `standard`, `profile`), `trailing`, `userName`, `imageUrl`.
- **CustomNavigationBar**: Bottom nav in `MainScreen` with animated indicators and RTL support.
- **Go Utility**: Always navigate via `Go.to()`, `Go.off()`, `Go.back()`.

### 2. Buttons & Inputs
- **LoadingButton**: Primary async action button with built-in loading state.
- **CustomAnimatedButton**: Advanced morphing loading button.
- **AppTextField**: Standard input with validation logic.
- **AppDropdown**: Generic dropdown (connect with `GetBaseEntityCubit`).

### 3. Media & Cards
- **UniversalMediaWidget**: Handles SVG, PNG, Lottie, and Network images intelligently.
- **CachedImage**: Optimized network image loading.
- **AppCard**: Standardized coupon/item card with favorite toggle, "Unavailable" badges, and status indicators.
- **IconWidget**: Primary icon renderer for all formats.
- **MapWidget**: Integrated OpenStreetMap (OSM) for location-based features.

### 4. State & Data Handling
- **AsyncBlocBuilder**: Auto-renders loading (skeletons), success, and error UIs.
- **StatusBuilder**: Manual switching based on `BaseStatus`.
- **PaginatedListWidget**: Integrated infinite scroll with pull-to-refresh and empty states.
- **EmptyWidget / ErrorView**: Standardized state-handling views.

---

## ├── Design Tokens (System)
### 1. Spacing & Radius
- **Spacing Helpers**: Always use vertical (`10.szH`) and horizontal (`15.szW`) extensions.
- **Padding/Margin**: Use `AppPadding` and `AppMargin` tokens (responsive).
- **Radius**: Use `AppCircular.r8`, `.r16`, `.r50` (responsive).

### 2. Colors (`AppColors`)
- **Primary**: `#315EA1` (Blue) | **Secondary**: `#0E1317` (Dark) | **Orange**: `#F98B45`.
- **Status**: `.success` (Green), `.error` (Red).
- **Gradients**: `.gradient` (Primary action backgrounds).

### 3. Typography
- **Font**: Madani Arabic (9 weights).
- **Styles**: Chain `TextStyleEx` (e.g., `context.textStyle.s16.bold.setPrimaryColor`).
- **Sizes**: `FontSizeManager.s6` to `s22`.

---

## ├── Implementation Workflows
### 1. Feature Lifecycle
1.  **Scaffold**: `mason make feature --name <name>`.
2.  **Define**: Entity in `entity/`.
3.  **Logic**: Extend `AsyncCubit` or `PaginatedCubit`.
4.  **Inject**: Run `build_runner`.
5.  **Build**: Use `BlocStatelessWidget` + `DefaultScaffold` + `AsyncBlocBuilder`.

### 2. Data & API
- **Endpoint**: Add to `ApiConstants`.
- **Call**: Use `executeAsync` + `baseCrudUseCase.call(CrudBaseParams(...))`.
- **Auth**: `UnAuthenticatedInterceptor` handles 401s automatically via global bottom sheet.

### 3. Infinite Scrolling (Pagination)
- **Cubit**: Extend `PaginatedCubit<T>`, implement `fetchPageData` and `parseItems`.
- **UI**: Wrap with `PaginatedListWidget<T>`.

### 4. Localization
- **Add**: Update `assets/translations/lang.json` (Source of Truth).
- **Format**: `key #$ English Text #$ Swedish Text`: `Arabic Text`.
- **English/Arabic/Swedish files**: NEVER edit `en.json`, `ar.json`, or `sv.json` directly. They are generated.
- **Gen**: Run `dart run generate/strings/main.dart` after ANY change to `lang.json`.
- **Use**: `LocaleKeys.key.tr()` (Zero hardcoding rule).

---

## ├── Do / Don't
### ✅ Do
- Use **`start`** and **`end`** for RTL layouts (never `left`/`right`).
- Use **`UniversalMediaWidget`** for all assets/media.
- Use **`10.szH`** shortcuts for spacing.
- Always check **`core/widgets/`** before creating a new component.
- Ensure exhaustive state handling using **`.when()`** on statuses.

### ❌ Don't
- **Don't** use standard `Scaffold` or `Navigator`.
- **Don't** hardcode hex colors or pixel sizes.
- **Don't** use `print()` statements; use `AppLogs`.
- **Don't** write business logic or API calls inside UI files.
- **Don't** forget to run `build_runner` after adding `@injectable`.

---

## ├── Folder Structure & Scaffolding
- **`lib/src/config/`**: Themes, Design Tokens, L10n Assets.
- **`lib/src/core/`**: 44+ Reusable Widgets, Go Navigation, Network, DI.
- **`lib/src/features/`**: 15+ Modularized Features (Auth, Home, Coupons, QR Scanner, etc.).
- **Scaffolding**: Always use `mason make feature --name <feature_name>` to maintain architecture.
- **Post-Scaffold**: Always run `dart run build_runner build --delete-conflicting-outputs`.

---

## 🛠️ Essential Commands (Run as needed)
```bash
# Register dependencies (Injection/JSON)
dart run build_runner build --delete-conflicting-outputs

# Synchronize translation keys
dart run generate/strings/main.dart

# Create new feature module
mason make feature --name <name>
```
