# 🏛️ Hattrick App – Project Constitution
# The immutable laws of this codebase.

## 1. Architecture Law: Separation of Concerns
- All source code MUST live under `lib/src`.
- Use `lib/src/core/` for global shared infrastructure.
- Use `lib/src/features/` for feature-specific modules.
- Features MUST be organized by type (e.g., `logic/`, `settings/`).

## 2. State Management Law: AsyncCubit Standard
- All feature-level state management MUST extend `AsyncCubit<T>` or `PaginatedCubit<T>`.
- Use `executeAsync()` to handle loading, data, and error states automatically.
- Use `BaseStatus.when()` for exhaustive state handling in the UI layer.
- State updates for CRUD operations should be done locally where possible.

## 3. Navigation Law: Go Utility Only
- Always use the `Go` class for navigation (e.g., `Go.to(context, Screen())`).
- Do not use `Navigator.push` directly.

## 4. UI Law: Component Reuse & Styling
- Always check `lib/src/core/widgets/` for reusable components before building new ones.
- Access sizes and colors via `AppSizes` and `ColorManager`.
- Use `IconWidget` and `CachedImage` for all icon and image needs.

## 5. Dependency Injection Law: Injectable
- Register all Cubits using `@injectable`.
- Register core services using `@LazySingleton`.
- Always run `build_runner` after adding/modifying injectable components.

## 6. Localization Law: Zero Hardcoding
- Use `easy_localization` and generated `LocaleKeys` for all user-facing strings.
- Arabic is the primary locale; ensure RTL compatibility (use `start`/`end`).
