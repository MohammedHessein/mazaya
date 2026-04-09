# Mazaya App – Logic Patterns Guide

| `profile` | User profile tab | Large avatar, name, optional subtitle badge |

## Location Tracking (UpdateLocationCubit)
1. **Goal**: Sync user coordinates to backend periodically without draining battery.
2. **Logic**:
   - Store `last_lat` and `last_lng` in `SharedPreferences`.
   - Calculate distance between current position and last synced position.
   - **Condition**: Only trigger `user/update-latlng` API if distance > 5,000 meters (5km).
3. **Trigger**: Handled in `MainScreen.initState()` or background service.

## Conditional Navigation Logic
1. **Utility**: Evaluates specific data fields before routing.
2. **Example (Coupon Location)**:
   - If `vendor.lat` / `vendor.lng` exists -> Navigate to **OSM Map Screen**.
   - Else if `vendor.website` exists -> Navigate to **WebView Screen**.
   - Else -> Show "Location information unavailable" toast.
3. **Benefit**: Prevents broken UI or empty map views.

## Infinite Lists (PaginatedCubit)
1. **Define Cubit**: Extend `PaginatedCubit<T>`.
2. **Implement Fetch**: 
   - Override `fetchPageData(int page, {String? key})`.
   - Update `PaginatedData` with `items` and `meta`.
3. **Parse Data**:
   - Override `parseItems(dynamic json)` to map JSON to entity list.
   - Override `parsePagination(dynamic json)` to extract pagination meta.
4. **Usage in UI**:
   - `PaginatedListWidget<T>` automatically handles:
     - Pull-to-refresh.
     - Scroll threshold for load-more.
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
4. **Usage in UI**:
   - `BlocBuilder<GetBaseEntityCubit<T>, GetBaseEntityState<T>>`.
   - Populated `AppDropdown<T>` with `state.dataState.data`.

## Complex States (AsyncCubit)
- Extend `AsyncCubit<T>`.
- Use `executeAsync` helper for standard API calls.
- States are `AsyncState<T>` providing `status`, `data`, and `errorMessage`.

## UI State Rendering
Two approaches for handling async states in UI:

### Approach 1: AsyncBlocBuilder (Preferred)
```dart
AsyncBlocBuilder<MyCubit, MyData>(
  skeletonBuilder: (context) => MySkeletonWidget(),
  builder: (context, data) => MyDataWidget(data),
)
```

### Approach 2: StatusBuilder
```dart
StatusBuilder(
  status: state.status,
  loading: () => CircularProgressIndicator(),
  success: () => MyDataWidget(state.data),
  error: () => ErrorView(state.errorMessage),
)
```

## Screen Scaffolding (DefaultScaffold)
Every screen MUST use `DefaultScaffold` with the appropriate header type:

| Header Type | Use Case | Shows |
| :--- | :--- | :--- |
| `home` | Main home tab | User avatar, welcome text, username, notification bell |
| `auth` | Login/Register/Forgot Password | Custom header widget + spacing |
| `standard` | Feature screens (Coupons, FAQs, etc.) | Centered title, back button, optional trailing |
| `profile` | User profile tab | Large avatar, name, optional subtitle badge |

## Bottom Navigation (MainScreen)
- `MainParams` manages tab state via `ValueNotifier<int>`.
- 4 tabs: Home, Coupons, QR Scanner, My Account.
- `CustomNavigationBar` with animated circular indicator.
- Tab icons defined via `NavigationBarEntity` (SVG active/inactive icons).
- Scanner tab (index 2) uses raw `Scaffold` without curved header.

## Authentication Flow
```
IntroScreen → LoginScreen → [ForgetPassword → OTP → ResetPassword] → MainScreen
```
- Login uses `CustomAnimatedButton` with `LoadingButton` wrapper.
- OTP uses `pinput` (4-digit pin code).
- Forget password flow: Send Code → Verify Code → Reset Password.
- Success actions use `SuccessDialog` or custom bottom sheets.

## Notification Flow
1. `NotificationService.setupNotifications()` called in `MainScreen.initState()`.
2. FCM handles foreground, background, and terminated state messages.
3. `NotificationNavigator` dispatches to correct screen based on `NotificationType`.
4. Three specialized cubits: `NotificationsCubit`, `UnreadNotificationCountCubit`, `DeleteNotificationCubit`.

## Coupon Flow
1. `CouponsCubit` fetches coupon data with search/filter support.
2. `CouponsBody` displays list using `AppCard` widgets.
3. `CouponsSearchBar` provides debounced search input.
4. **Advanced Filtering**: `CouponsFilterBottomSheet` handles:
   - Proximity (Nearest/Distance).
   - Sorting (Newest, Expiration Date).
   - Localized category chips.
5. **Modular Decomposition**: Extracted UI sections into public standalone widgets (`FilterHeader`, `FilterLocationSelectors`, etc.) to keep the bottom sheet logic readable and testable.
6. **Detail Map**: Integrated OpenStreetMap (OSM) via `MapWidget` in coupon details for vendor discovery.

## Component/Feature Creation Rules
- **Naming**: Use `_view.dart`, `_body.dart`, `_cubit.dart`, `_screen.dart`.
- **Structure**: Group by feature, follow `entity/` + `presentation/` (`cubits/`, `view/`, `widgets/`, `imports/`) pattern.
- **Rules**: 
  - Never hardcode strings, use `LocaleKeys`.
  - Never hardcode sizes, use `AppPadding`/`AppSize` (plus `.h`/`.w`).
  - Use `injector` for BLOC and Service injection.
  - Use `SizedBoxHelper` for spacing (`10.szH`, `15.szW`).
  - Use `TextStyleEx` for text styling (`context.textStyle.s16.bold.setWhiteColor`).

## Modular UI Decomposition
When a feature "Body" or "BottomSheet" exceeds ~200 lines, follow this pattern:
1. **Logic Extraction**: Move non-UI logic (camera controllers, complex validations) to a dedicated `Controller` or the `Cubit`.
2. **Componentization**: Identify logical UI sections (Header, Controls, Forms, Overlays).
3. **Public Widgets**: Create separate files for each section using **Public Widgets** (no `_` prefix).
4. **Coordination**: The main "Body" file acts as a thin coordinator that imports and arranges these sub-components.
5. **Benefit**: Smaller file sizes, improved readability, and reusability of sub-components.
