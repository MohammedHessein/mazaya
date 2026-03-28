# 📚 Mazaya App – Project Glossary

Common terms and concepts used within the codebase.

| Term | Definition |
| :--- | :--- |
| **AppCard** | A reusable card widget for displaying coupon/item entries with image, title, description, status badge, and favorite toggle. Located at `lib/src/core/widgets/cards/app_card.dart`. |
| **AppColors** | Centralized color palette for the light theme. Primary: `#315EA1` (blue), Secondary: `#0E1317`. Located at `lib/src/config/res/color_manager.dart`. |
| **AppColorsWithDarkMode** | Mirror of `AppColors` prepared for dark mode support. |
| **AppDropdown** | A generic dropdown widget that integrates with `GetBaseEntityCubit` for dynamic data loading. Located at `lib/src/core/widgets/fields/drop_downs/`. |
| **AppPadding / AppSize / AppMargin / AppCircular** | Centralized responsive sizing tokens using `flutter_screenutil`. Located at `lib/src/config/res/app_sizes.dart`. |
| **AppTextField** | A standardized text input field with built-in validation support. Located at `lib/src/core/widgets/fields/text_fields/`. |
| **AppTheme** | Material 3 theme configuration for light mode. Located at `lib/src/config/themes/app_theme.dart`. |
| **ArrowWidget** | A styled back-button widget used inside `DefaultScaffold`. Located at `lib/src/core/widgets/scaffolds/arrow_widget.dart`. |
| **AsyncBlocBuilder** | A builder widget that automatically handles loading (skeleton), success, and error states for `AsyncCubit`. Located at `lib/src/core/widgets/tools/bloc_builder/async_bloc_builder.dart`. |
| **AsyncCubit** | A domain-level Cubit wrapper that tracks loading, success, and failure states via `AsyncState<T>` and `BaseStatus`. |
| **BadgeIconWidget** | A widget that shows an icon with a badge indicator (e.g., notification count). Located at `lib/src/core/widgets/badge_icon_widget.dart`. |
| **Base CRUD** | A generic Clean Architecture module within `core` that standardizes repository and usecase logic for any API model. Located at `lib/src/core/base_crud/`. |
| **BlocStatelessWidget / BlocStatefulWidget** | Helper widgets that reduce BlocProvider boilerplate by auto-creating and providing cubits. |
| **ButtonClose** | A styled close/dismiss button widget. Located at `lib/src/core/widgets/buttons/button_close.dart`. |
| **CachedImage** | A wrapper for `cached_network_image` with placeholder and error handling. Located at `lib/src/core/widgets/image_widgets/cached_image.dart`. |
| **CacheService** | Helper for `shared_preferences` read/write operations. Located at `lib/src/core/helpers/cache_service.dart`. |
| **ConstantManager** | A single source of truth for global app configuration like `bundleId`, `appName`, `timeout`, and `pagination` sizes. Located at `lib/src/config/res/constants_manager.dart`. |
| **CustomAnimatedButton** | An animated button that morphs between idle and loading states with configurable animations. Supports both `color` and `gradient`. Located at `lib/src/core/widgets/buttons/custom_animated_button.dart`. |
| **CustomImageCarousel** | An image carousel/slider widget using `carousel_slider`. Located at `lib/src/core/widgets/carousel/`. |
| **CustomNavigationBar** | The app's bottom navigation bar with animated position indicator and SVG icon support. Located at `lib/src/core/widgets/navigation_bar/custom_navigation_bar.dart`. |
| **DefaultBottomSheet** | A standardized bottom sheet presenter. Located at `lib/src/core/widgets/pickers/default_bottom_sheet.dart`. |
| **DefaultButton** | A simple styled button for general use. Located at `lib/src/core/widgets/buttons/default_button.dart`. |
| **DefaultScaffold** | The app's standardized screen layout widget with curved header background, back button, and 4 header types: `home`, `auth`, `standard`, `profile`. Located at `lib/src/core/widgets/scaffolds/default_scaffold.dart`. |
| **EmptyWidget** | A widget shown when a list or data set has no items. Located at `lib/src/core/widgets/handling_views/empty_widget.dart`. |
| **Failure** | A set of domain-layer classes representing categorized errors (e.g., `ServerFailure`, `CacheFailure`). Located at `lib/src/core/error/failure.dart`. |
| **FontSizeManager** | Responsive font size tokens (s6 to s22) using `.sp`. |
| **FontWeightManager** | Standardized font weights (bold, medium, regular, light). |
| **FullScreenLoadingManager** | A global overlay for blocking loading indicators during critical operations. Located at `lib/src/core/helpers/loading_manager.dart`. |
| **Go** | Centralized navigation utility providing `to()`, `off()`, `offAll()`, `back()`, `toNamed()`, etc. Located at `lib/src/core/navigation/navigator.dart`. |
| **HandlingViews** | A collection of UI components for conveying empty, error, offline, or loading states. Located at `lib/src/core/widgets/handling_views/`. |
| **IconWidget** | A versatile icon renderer supporting SVG, image assets, and Material icons. Located at `lib/src/core/widgets/icon_widget.dart`. |
| **ImageHelper** | Utility for picking, cropping, and processing images. Located at `lib/src/core/helpers/image_helper.dart`. |
| **IntroCarouselWidget** | The onboarding/intro animated carousel with page indicators. Located at `lib/src/core/widgets/custom_animated_intro/`. |
| **LanguageBottomSheet** | A bottom sheet for switching between Arabic and English. Located at `lib/src/core/widgets/language/`. |
| **LauncherHelper** | Utility for launching URLs, phone calls, and emails. Located at `lib/src/core/helpers/lancher_helper.dart`. |
| **LoadingButton** | A specialized button supporting async operations with built-in loading spinner or progress tracking. Located at `lib/src/core/widgets/buttons/loading_button.dart`. |
| **LoadingButtonWithIcon** | Variant of LoadingButton with a leading SVG icon. |
| **LocaleKeys** | Generated localization keys from `easy_localization` (stored in `locale_keys.g.dart`). |
| **LocationHelper** | Utility for getting device location using `geolocator` + `geocoding`. Located at `lib/src/core/helpers/location_helper.dart`. |
| **MainParams** | Configuration object for `MainScreen` managing tab state, navigation tabs, and visitor logic. Located at `lib/src/features/main/entity/main_params.dart`. |
| **MainScreen** | The app's shell screen with bottom navigation (Home, Coupons, Scanner, My Account). Located at `lib/src/features/main/presentation/view/main_screen.dart`. |
| **MazayaApp** | The root `MaterialApp` widget that initializes theming, localization, ScreenUtil, UserCubit, and global interceptors. Located at `lib/src/app.dart`. |
| **NavigationBarEntity** | Data model for a bottom navigation tab (text, icon, activeIcon). |
| **NotificationNavigator** | A dispatcher that routes the app to specific screens based on notification payload data. Located at `lib/src/core/notification/notification_routes.dart`. |
| **NotificationService** | Handles FCM tokens, background/foreground messages, and local notifications. Located at `lib/src/core/notification/notification_service.dart`. |
| **NotificationType** | An enum defining all supported notification intents (e.g., `adminNotify`, `chat`, `block`). Located at `lib/src/core/notification/navigation_types.dart`. |
| **OfflineWidget** | A connectivity-aware wrapper using `flutter_offline` that shows offline state. Located at `lib/src/core/widgets/handling_views/offline_widget.dart`. |
| **PaginatedCubit** | Base cubit for paginated data loads with built-in page tracking and load-more support. |
| **PaginatedListWidget** | A high-level widget that integrates with `PaginatedCubit` to provide infinite scrolling, pull-to-refresh, and empty/error/loading states. Located at `lib/src/core/widgets/tools/pagination/`. |
| **RiyalPriceText** | A widget for displaying prices with Riyal currency formatting. Located at `lib/src/core/widgets/riyal_price_text.dart`. |
| **RTL-First** | A design approach prioritizing Right-to-Left languages (Arabic), using `start`/`end` instead of `left`/`right`. |
| **ScaffoldHeaderType** | An enum defining header layouts: `home`, `auth`, `standard`, `profile`. Used by `DefaultScaffold`. |
| **SecureStorage** | A wrapper for `FlutterSecureStorage` used for storing sensitive encrypted data like auth tokens. |
| **SizedBoxHelper** | Extension on `num` providing `.szH` (vertical) and `.szW` (horizontal) SizedBox shortcuts. |
| **SkeltonizerManager** | Predefined placeholder text strings for skeleton loading states. |
| **Spec Kit** | The documentation system used to define specifications, rules, and plans for the project. |
| **StatusBuilder** | A widget for switching UI based on `BaseStatus` enum values. Located at `lib/src/core/widgets/tools/bloc_builder/status_builder.dart`. |
| **SuccessDialog** | A pre-built dialog for showing success messages. Located at `lib/src/core/widgets/dialogs/success_dialog.dart`. |
| **TextStyleEx** | An extension allowing chainable styling of `TextStyle` (e.g., `.bold.s14.setPrimaryColor`, `.setWhiteColor`, `.setMainTextColor`). Located at `lib/src/core/extensions/text_style_extensions.dart`. |
| **UnAuthenticatedBottomSheet** | A global bottom sheet triggered when the user's session expires or is blocked. Located at `lib/src/core/widgets/un_autheticated/`. |
| **UnAuthenticatedInterceptor** | A networking interceptor that triggers session expiry UI when detecting 401 or blocked status. Located at `lib/src/core/network/un_authenticated_interceptor.dart`. |
| **UniversalMediaWidget** | A versatile widget that displays images (SVG, PNG, JPG), Lottie animations, or videos from various sources. Located at `lib/src/core/widgets/universal_media/`. |
| **UploadImage** | A specialized UI component for selecting and uploading one or more images. Located at `lib/src/core/widgets/image_widgets/upload_image.dart`. |
| **UserCubit** | A centralized cubit for managing the current user's profile and authentication status. Located at `lib/src/core/shared/cubits/`. |
| **UserModel** | The standard data structure representing the logged-in user, including profile details and auth token. Located at `lib/src/core/shared/models/`. |
| **Validators** | Form field validation logic with security guards against script injection. Located at `lib/src/core/helpers/validators.dart`. |
| **VisitorPopUp** | A dialog shown to non-authenticated users when they try to access restricted features. Located at `lib/src/core/widgets/dialogs/visitor_pop_up.dart`. |
