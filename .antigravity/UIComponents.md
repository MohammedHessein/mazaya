# UI Components Guide

## Core Widgets
1. **AppCard**:
   - `lib/src/core/widgets/cards/app_card.dart`
   - Use for: Coupon items, list items.
   - Props: `title`, `description`, `imageUrl`, `status`, `onFavoriteTap`.
2. **AppDropdown**:
   - `lib/src/core/widgets/fields/drop_downs/app_drop_down/app_dropdown.dart`
   - Use for: City, Category, Country selection.
   - Integration: Connect with `GetBaseEntityCubit` via `BlocBuilder`.
   - Pattern: Use `.asFormField<T>(...)` for validation.
3. **LoadingButton**:
   - `lib/src/core/widgets/buttons/loading_button.dart`
   - Use for: Forms, primary actions.
   - Props: `title`, `onTap`, `isLoading`, `color`.
4. **AppTextField**:
   - `lib/src/core/widgets/fields/text_fields/app_text_field.dart`
   - Use for: User inputs, search.
   - Props: `controller`, `hint`, `validator`.
5. **DefaultScaffold**:
   - `lib/src/core/widgets/scaffolds/default_scaffold.dart`
   - Use for: All screens.
   - Props: `headerType` (`ScaffoldHeaderType.home`, `auth`, `standard`, `profile`).

## Design Tokens
- **Padding**: `AppPadding.pH10`, `AppPadding.pW20` (responsive via `Sizer`).
- **Radius**: `AppCircular.r8`, `AppCircular.r50` (responsive).
- **Colors**: `AppColors.primary`, `AppColors.white`, `AppColors.black`.
- **Text Styles**: Use `context.textStyle.s16.bold` pattern.

## Guidelines
- Always use `SizedBoxHelper` (e.g., `10.szH`, `15.szW`).
- Always use `Easy Localization` via `LocaleKeys.key.tr()` or `LocaleKeys.key`.
