# Mazaya App – UI Components Guide

## Core Widgets

### Scaffolds & Layout
1. **DefaultScaffold**:
   - `lib/src/core/widgets/scaffolds/default_scaffold.dart`
   - Use for: ALL screens.
   - Props: `title`, `body`, `headerType`, `headerWidget`, `headLineWidget`, `trailing`, `showBackButton`, `userName`, `imageUrl`, `subTitle`, `bottomNavigationBar`, `extendBody`.
   - Header Types: `ScaffoldHeaderType.home`, `auth`, `standard`, `profile`.
2. **ArrowWidget**:
   - `lib/src/core/widgets/scaffolds/arrow_widget.dart`
   - Use for: Custom back button implementations.

### Navigation
3. **CustomNavigationBar**:
   - `lib/src/core/widgets/navigation_bar/custom_navigation_bar.dart`
   - Use for: Bottom navigation in `MainScreen`.
   - Props: `tabs` (List of `NavigationBarEntity`), `selectedIndex`, `onTabChange`.
   - Features: Animated circular indicator, SVG icon support, RTL-aware positioning.
4. **NavigationBarEntity**:
   - Data model: `text`, `icon`, `activeIcon`.

### Buttons
5. **LoadingButton**:
   - `lib/src/core/widgets/buttons/loading_button.dart`
   - Use for: Primary async actions (login, submit, etc.).
   - Props: `title`, `onTap`, `color`, `textColor`, `borderRadius`, `width`, `height`, `isDissabled`, `onSendProgress`, `titleAsWidget`.
   - Named constructor: `LoadingButton.withWidget()` for custom child content.
6. **LoadingButtonWithIcon**:
   - Same file as above.
   - Use for: Buttons with a leading SVG icon.
7. **CustomAnimatedButton**:
   - `lib/src/core/widgets/buttons/custom_animated_button.dart`
   - Use for: Advanced animated buttons with morphing loading state.
   - Props: `width`, `height`, `onTap`, `color`, `gradient`, `borderRadius`, `loader`, `child`.
8. **DefaultButton**:
   - `lib/src/core/widgets/buttons/default_button.dart`
   - Use for: Simple styled buttons.
9. **ButtonClose**:
   - `lib/src/core/widgets/buttons/button_close.dart`
   - Use for: Close/dismiss actions in dialogs/sheets.

### Cards
10. **AppCard**:
    - `lib/src/core/widgets/cards/app_card.dart`
    - Use for: Coupon items, list items, deal displays.
    - Props: `title`, `description`, `imageUrl`, `status`, `onTap`, `isFavorite`, `onFavoriteTap`.
    - Features: Status badge, favorite heart toggle, shadow decoration.

### Form Fields
11. **AppTextField**:
    - `lib/src/core/widgets/fields/text_fields/`
    - Use for: All user text inputs with validation.
12. **AppDropdown**:
    - `lib/src/core/widgets/fields/drop_downs/app_drop_down/`
    - Use for: City, Category, Country selection.
    - Integration: Connect with `GetBaseEntityCubit` via `BlocBuilder`.

### Media & Images
13. **UniversalMediaWidget**:
    - `lib/src/core/widgets/universal_media/universal_media_widget.dart`
    - Use for: Displaying SVGs, PNGs, Lottie, network images in a single call.
    - Props: `path`, `width`, `height`.
14. **CachedImage**:
    - `lib/src/core/widgets/image_widgets/cached_image.dart`
    - Use for: All network images with caching.
15. **CustomAvatar**:
    - `lib/src/core/widgets/image_widgets/custom_avatar.dart`
    - Use for: User avatars.
16. **CustomImageSlider**:
    - `lib/src/core/widgets/image_widgets/custom_image_slider.dart`
    - Use for: Image carousels in detail screens.
17. **ImageView**:
    - `lib/src/core/widgets/image_widgets/image_view.dart`
    - Use for: Full-screen image viewing.
18. **UploadImage**:
    - `lib/src/core/widgets/image_widgets/upload_image.dart`
    - Use for: Selecting and uploading images.
19. **IconWidget**:
    - `lib/src/core/widgets/icon_widget.dart`
    - Use for: All icon rendering (SVG, asset, Material).

### State Handling Views
20. **EmptyWidget**: `handling_views/empty_widget.dart` – No data state.
21. **ErrorView**: `handling_views/error_view.dart` – Error state.
22. **ExceptionView**: `handling_views/exeption_view.dart` – Exception display.
23. **InternetException**: `handling_views/internet_exeption.dart` – No internet state.
24. **NotContainData**: `handling_views/not_contain_data.dart` – Missing data.
25. **OfflineWidget**: `handling_views/offline_widget.dart` – Offline connectivity banner.

### Dialogs & Sheets
26. **SuccessDialog**: `dialogs/success_dialog.dart` – Success confirmation.
27. **VisitorPopUp**: `dialogs/visitor_pop_up.dart` – Guest restriction dialog.
28. **DefaultBottomSheet**: `pickers/default_bottom_sheet.dart` – Standard bottom sheet.
29. **CustomDialog**: `pickers/custom_dialog.dart` – Custom alert dialog.
30. **CustomDatePicker**: `pickers/custom_date_picker.dart` – Date picker.
31. **LanguageBottomSheet**: `language/language_bottom_sheet.dart` – Language selector.
32. **UnAuthenticatedBottomSheet**: `un_autheticated/unauthenticated_bottomsheet.dart` – Session expiry.

### Data Tools
33. **AsyncBlocBuilder**: `tools/bloc_builder/async_bloc_builder.dart` – Auto loading/success/error UI.
34. **StatusBuilder**: `tools/bloc_builder/status_builder.dart` – Manual status switching.
35. **PaginatedListWidget**: `tools/pagination/paginated_list_widget.dart` – Infinite scroll list.

### Misc Widgets
36. **BadgeIconWidget**: `badge_icon_widget.dart` – Icon with badge indicator.
37. **CustomHtmlWidget**: `custom_html_widget.dart` – HTML content renderer.
38. **CustomLoading**: `custom_loading.dart` – Loading spinner.
39. **CustomMessages**: `custom_messages.dart` – Toast/snackbar messages.
40. **CustomWidgetValidator**: `custom_widget_validator.dart` – Conditional widget rendering.
41. **RiyalPriceText**: `riyal_price_text.dart` – Price with Riyal currency.
42. **CustomImageCarousel**: `carousel/custom_image_carousel.dart` – Image carousel.
43. **IntroCarouselWidget**: `custom_animated_intro/intro_carousel_widget.dart` – Onboarding carousel.
44. **LanguagePillWidget**: `language/language_pill_widget.dart` – Inline language display.

---

## Design Tokens

### Padding & Sizing
- **Padding**: `AppPadding.pH10`, `AppPadding.pW20` (responsive via `ScreenUtil`).
- **Margins**: `AppMargin.mH10`, `AppMargin.mW20`.
- **Sizes**: `AppSize.sH50`, `AppSize.sW30`.
- **Radius**: `AppCircular.r8`, `AppCircular.r16`, `AppCircular.r50` (responsive).

### Colors
- **Primary**: `AppColors.primary` (#315EA1)
- **Secondary**: `AppColors.secondary` (#0E1317)
- **Orange**: `AppColors.orange` (#F98B45)
- **White/Black**: `AppColors.white`, `AppColors.black`
- **Grays**: `AppColors.gray100` → `AppColors.gray600`
- **Blues**: `AppColors.blue50` → `AppColors.blue600`
- **Status**: `AppColors.error`, `AppColors.success`
- **Background**: `AppColors.scaffoldBackground`, `AppColors.bgF7`
- **Gradients**: `AppColors.gradient`, `AppColors.disableGradient`

### Typography
- **Font Family**: Madani Arabic (`ConstantManager.fontFamily`)
- **Text Styles**: Use `context.textStyle.s16.bold` pattern via `TextStyleEx`.
- **Color Setters**: `.setWhiteColor`, `.setBlackColor`, `.setPrimaryColor`, `.setMainTextColor`, `.setColor(color)`.
- **Font Sizes**: `FontSizeManager.s6` → `FontSizeManager.s22`.
- **Font Weights**: `FontWeightManager.bold`, `.medium`, `.regular`, `.light`.

### Spacing Shortcuts
- **Vertical**: `10.szH` → `SizedBox(height: 10)`
- **Horizontal**: `15.szW` → `SizedBox(width: 15)`

## Guidelines
- Always use `SizedBoxHelper` (e.g., `10.szH`, `15.szW`) for spacing.
- Always use `Easy Localization` via `LocaleKeys.key.tr()` or `LocaleKeys.key`.
- Always use `DefaultScaffold` for screen structure.
- Use `TextStyleEx` chains for all text styling.
- Use `UniversalMediaWidget` for mixed media types.
