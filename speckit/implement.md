# 🚀 Mazaya App – Implementation Workflows

## Workflow 1: Create a New Feature

1. **Scaffold**: Run `mason make feature --name <feature_name>`.
2. **Entity**: Define your data entity in `lib/src/features/<feature_name>/entity/`.
3. **Cubit**: Implement logic in `presentation/cubits/<name>_cubit.dart` using `AsyncCubit`.
4. **DI**: Run `dart run build_runner build --delete-conflicting-outputs`.
5. **UI**: Build your screen in `presentation/view/`. **Recommendation**: Use `BlocStatelessWidget<C>` or `BlocStatefulWidget<C>` to simplify `BlocProvider` injection.
6. **State Handling**: Use the `BaseStatus.when()` extension or `AsyncBlocBuilder` in your UI widgets to handle Loading, Success, and Error states exhaustively.
7. **Navigation**: Navigate via `Go.to(NewScreen())`.

## Workflow 2: Add an API Endpoint

1. **Constants**: Add endpoint to `ApiConstants` (`lib/src/core/network/api_endpoints.dart`).
2. **Params**: Create a `CrudBaseParams` object defining the endpoint and HTTP method.
3. **Implementation**: Call `baseCrudUseCase.call(params)` within `executeAsync` in your Cubit.
4. **Mapper**: Provide a mapper function to transform JSON into your entity.

## Workflow 3: Implementing a Screen with DefaultScaffold

1. **Choose Header Type**: Select the appropriate `ScaffoldHeaderType`:
   - `home` – Shows user avatar, welcome text, username, and notification bell icon.
   - `auth` – Shows custom header widget (e.g., logo/illustration) with spacing.
   - `standard` – Shows centered title with back button and optional trailing widget.
   - `profile` – Shows avatar, user name, and optional subtitle badge.
2. **Build**: Wrap your screen body with `DefaultScaffold(title: ..., body: ..., headerType: ...)`.
3. **Curved Background**: All header types automatically display the curved primary background via `curveBackground` asset.

```dart
DefaultScaffold(
  title: LocaleKeys.couponsTitle,
  headerType: ScaffoldHeaderType.standard,
  body: const CouponsBody(),
)
```

## Workflow 4: Implementing a Paginated List

1. **Cubit**: Create a class extending `PaginatedCubit<T>`.
2. **Override**: Implement `fetchPageData(page, {key})` (call your API) and `parseItems(json)` (map to your entity).
3. **UI**: Use the `PaginatedListWidget<T>` in your screen. Pass the cubit and an `itemBuilder`.
4. **Initial Load**: Call `context.read<YourPaginatedCubit>().fetchInitialData()` in `initState`.

## Workflow 5: Global Loading Overlay

1. **Show**: Call `FullScreenLoadingManager.show()` to display a blocking loading indicator.
2. **Hide**: Call `FullScreenLoadingManager.hide()` to remove it.
3. **Usage**: Ideal for non-UI-specific operations like "Deleting Account" or "Uploading File".
4. **Auto-integration**: Already wired globally in `MazayaApp` widget's builder.

## Workflow 6: Handling Session Expiry (Auth)

1. **Auto-handling**: The `UnAuthenticatedInterceptor` automatically detects 401 errors or `unauthenticated/blocked` keys.
2. **Global UI**: It triggers an `UnAuthenticatedBottomSheet` automatically (configured in `MazayaApp` widget).
3. **Manual Trigger**: You can manually notify listeners via `UnAuthenticatedInterceptor.instance.notifyListeners(true/false)`.

## Workflow 7: Advanced Navigation Transitions

1. **Standard Push**: `Go.to(Page())` – default transition.
2. **Replace**: `Go.off(Page())` – pushReplacement.
3. **Clear Stack**: `Go.offAll(Page())` – push and remove all previous routes.
4. **Navigate Back**: `Go.back()` – pop current route.
5. **Back to Root**: `Go.backToInitial()` – pop to first route.
6. **Custom Transitions**:
   ```dart
   Go.to(
     NewPage(),
     transition: TransitionType.fade,
     options: FadeAnimationOption(duration: Duration(milliseconds: 300)),
   );
   ```
7. **Named Routes**: `Go.toNamed(NamedRoutes.routeName)`, `Go.offNamed()`, `Go.offAllNamed()`.

## Workflow 8: Bottom Navigation (MainScreen)

1. **Navigation Tabs**: Defined in `MainParams.navTabs` (Home, Coupons, QR Scanner, My Account).
2. **Tab Index**: Managed via `ValueNotifier<int>` in `MainParams`.
3. **Custom NavBar**: Uses `CustomNavigationBar` with animated position indicator.
4. **Scaffold per Tab**: Each tab applies the appropriate `ScaffoldHeaderType`:
   - Tab 0 (Home) → `ScaffoldHeaderType.home`
   - Tab 1 (Coupons) → `ScaffoldHeaderType.standard`
   - Tab 2 (Scanner) → Raw `Scaffold` (no curved header)
   - Tab 3 (My Account) → `ScaffoldHeaderType.profile`

## Workflow 9: Authentication Flow

1. **Intro Screen** → User sees onboarding carousel (`IntroScreen`).
2. **Login Screen** → Phone/Email login with `CustomAnimatedButton`.
3. **Forget Password** → Send code → OTP verification (`pinput`) → Reset password.
4. **OTP Verification** → `verifyAccount` API with 4-field pin code.
5. **After Login** → Navigate to `MainScreen` via `Go.offAll(MainScreen())`.

## Workflow 10: Notifications

1. **Service**: `NotificationService` handles FCM tokens, foreground/background messages, and local notifications.
2. **Navigation**: `NotificationNavigator` dispatches to specific screens based on notification payload.
3. **Cubits**:
   - `NotificationsCubit` – Fetches notification list (paginated).
   - `UnreadNotificationCountCubit` – Fetches unread count.
   - `DeleteNotificationCubit` – Deletes individual or all notifications.
4. **Screen**: `NotificationScreen` accessible from home header notification bell icon.

## Workflow 11: Coupons Feature

1. **CouponsCubit**: Manages coupon list data with search and filter support.
2. **CouponsBody**: Displays coupon list using `AppCard` widgets.
3. **CouponsSearchBar**: Search bar widget with debounced text input.
4. **CouponsFilterBottomSheet**: Bottom sheet with filter options for categories/status.

## Workflow 12: Language Switching

1. **UI**: Use `LanguageBottomSheet` to display language options (Arabic/English).
2. **Trigger**: Call `openLanguageSheet(context)` to show the bottom sheet.
3. **Apply**: Language change applies via `easy_localization` context methods.
4. **Widgets**: `LanguagePillWidget` for inline language display, `LanguageOption` for radio-style selection.

---

## 💡 Concrete Examples

### Example 1: Standard Feature Cubit (`AsyncCubit`)
Use this for fetching a list of items or a single detail object.

```dart
@injectable
class FaqsCubit extends AsyncCubit<List<FaqEntity>> {
  FaqsCubit() : super([]);

  Future<void> fetchFaqs() async {
    await executeAsync(
      operation: () async => baseCrudUseCase.call(
        CrudBaseParams(
          api: ApiConstants.faqs,
          httpRequestType: HttpRequestType.get,
          mapper: (json) => (json['data'] as List)
              .map((e) => FaqEntity.fromJson(e))
              .toList(),
        ),
      ),
    );
  }
}
```

### Example 2: Reactive UI with `AsyncBlocBuilder`
Use this to handle loading (with skeletons), success, and error states automatically.

```dart
class FaqsBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AsyncBlocBuilder<FaqsCubit, List<FaqEntity>>(
      skeletonBuilder: (context) => _MySkeletonList(),
      builder: (context, data) {
        return ListView.builder(
          itemCount: data.length,
          itemBuilder: (context, index) => FaqCard(faq: data[index]),
        );
      },
    );
  }
}
```

### Example 3: Clean Screen with `BlocStatelessWidget`
Reduces boilerplate for providing and initializing a Cubit.

```dart
class FaqsScreen extends BlocStatelessWidget<FaqsCubit> {
  const FaqsScreen({super.key});

  @override
  FaqsCubit get create => injector<FaqsCubit>()..fetchFaqs();

  @override
  Widget buildContent(BuildContext context, FaqsCubit ref) {
    return DefaultScaffold(
      title: LocaleKeys.faqs.tr(),
      body: const FaqsBody(),
    );
  }
}
```

### Example 4: Paginated List Implementation
Use this for features requiring infinite scrolling.

```dart
@injectable
class MyItemsCubit extends PaginatedCubit<MyItemEntity> {
  @override
  Future<Result<Map<String, dynamic>, Failure>> fetchPageData(int page, {String? key}) async {
    return baseCrudUseCase.call(
      CrudBaseParams(
        api: ApiConstants.myItems,
        queryParameters: {'page': page},
        mapper: (json) => json, // Pass full JSON to PaginatedCubit logic
      ),
    );
  }

  @override
  List<MyItemEntity> parseItems(dynamic json) =>
      (json['data'] as List).map((e) => MyItemEntity.fromJson(e)).toList();

  @override
  PaginationMeta parsePagination(dynamic json) =>
      PaginationMeta.fromJson(json['meta']);
}

// In UI:
PaginatedListWidget<MyItemEntity>(
  cubit: context.read<MyItemsCubit>(),
  itemBuilder: (context, item) => MyItemCard(item: item),
);
```

### Example 5: Using LoadingButton
Async button with built-in loading state.

```dart
LoadingButton(
  title: LocaleKeys.login.tr(),
  onTap: () async {
    await context.read<LoginCubit>().login();
  },
  color: AppColors.primary,
  borderRadius: AppCircular.r50,
)
```

### Example 6: Using AppCard
Standard coupon/item card with favorite.

```dart
AppCard(
  title: 'خصم 30%',
  description: 'على جميع المنتجات',
  imageUrl: AppAssets.svg.baseSvg.couponIcon.path,
  status: 'متاح',
  isFavorite: true,
  onFavoriteTap: () => toggleFavorite(),
  onTap: () => Go.to(CouponDetailScreen(id: coupon.id)),
)
```

### Example 7: DefaultScaffold Header Types

```dart
// Home header with user info + notification icon
DefaultScaffold(
  title: '',
  headerType: ScaffoldHeaderType.home,
  userName: 'محمد حسين',
  imageUrl: AppAssets.svg.baseSvg.profile.path,
  body: HomeView(),
)

// Profile header with avatar + subtitle badge
DefaultScaffold(
  title: '',
  headerType: ScaffoldHeaderType.profile,
  userName: 'محمد حسين',
  subTitle: 'عضو ذهبي',
  body: ProfileView(),
)

// Standard header with centered title
DefaultScaffold(
  title: LocaleKeys.notifications.tr(),
  headerType: ScaffoldHeaderType.standard,
  body: NotificationBody(),
)
```

### Example 8: Responsive UI Design
- Use `.h`, `.w`, `.sp`, and `.r` for pixel-consistent design.
- Chain `TextStyleEx` for rapid styling: `context.textStyle.s16.bold.setPrimaryColor`.
- Use `UniversalMediaWidget` to intelligently handle SVGs, Lottie, and Network images in a single call.
- Use `SizedBoxHelper`: `10.szH` (vertical space), `15.szW` (horizontal space).
