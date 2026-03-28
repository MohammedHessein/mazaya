# ❓ Mazaya App – Clarifications & Decisions Log

## Architecture Decisions

### ADR-001: AsyncCubit Standard
- **Decision**: All feature state management MUST extend `AsyncCubit` (or `PaginatedCubit` for lists).
- **Rationale**: Standardizes loading/error handling across the app and reduces boilerplate.

### ADR-002: Base CRUD UseCase
- **Decision**: Use `baseCrudUseCase` for all standard API interactions.
- **Rationale**: Centralizes logic for mapping, status handling, and error processing via `BaseModel`.

### ADR-003: Go Class for Navigation
- **Decision**: Centralize all routing logic in the `Go` utility.
- **Rationale**: Simplifies the navigation API and allows for future centralized routing improvements (transitions, guards, analytics).
- **API Surface**: `Go.to()`, `Go.off()`, `Go.offAll()`, `Go.back()`, `Go.backToInitial()`, `Go.toNamed()`, `Go.offNamed()`, `Go.offAllNamed()`.

### ADR-004: DefaultScaffold as Universal Screen Wrapper
- **Decision**: All screens MUST use `DefaultScaffold` with one of four `ScaffoldHeaderType` values.
- **Rationale**: Provides a consistent curved-header background pattern across the entire app. The header type system allows flexibility per screen while maintaining visual consistency.
- **Types**: `home` (user info + notification bell), `auth` (custom widget), `standard` (centered title + back), `profile` (avatar + name).

### ADR-005: MainScreen with ValueNotifier Tabs
- **Decision**: Use `ValueNotifier<int>` (via `MainParams`) instead of a Cubit for bottom navigation state.
- **Rationale**: Tab switching is a lightweight, UI-only concern. A ValueNotifier is simpler and more performant than introducing a Cubit.

### ADR-006: Madani Arabic Typography
- **Decision**: Use **Madani Arabic** as the sole font family across the app.
- **Rationale**: Madani provides excellent Arabic glyph rendering with a comprehensive weight range (100–900), ensuring visual consistency for the RTL-first interface.

### ADR-007: CustomAnimatedButton for Primary Actions
- **Decision**: Use `CustomAnimatedButton` (via `LoadingButton`) for all primary async actions.
- **Rationale**: The animated morph between idle and loading states provides clear user feedback and prevents double-taps during API calls.

### ADR-008: Notification Architecture
- **Decision**: Separate notification concerns into three cubits: `NotificationsCubit` (list), `UnreadNotificationCountCubit` (badge), `DeleteNotificationCubit` (actions).
- **Rationale**: Follows Single Responsibility Principle. Each cubit handles one concern, making them independently testable and composable.

---

## Technical Clarifications

### Q: Why RTL-first?
**A**: The Mazaya app is primarily for the Arabic market. Designing RTL-first ensures that the UI is perfectly aligned for Arabic speakers and reduces "fixing" effort for LTR (English) locales.

### Q: How do we handle specific UI widgets?
**A**: Use `IconWidget` for all icons, `CachedImage` for all network images, and `UniversalMediaWidget` for mixed media (SVGs, Lottie, network images in a single call). Use `SizedBoxHelper` extensions (`10.szH`, `15.szW`) for spacing.

### Q: Where are the core design tokens?
**A**: `lib/src/config/res/` contains:
- `AppColors` / `AppColorsWithDarkMode`: Semantically named color palettes.
- `AppPadding`, `AppSize`, `AppMargin`, `AppCircular`: Responsive sizing tokens.
- `FontSizeManager`, `FontWeightManager`: Typography sizing and weights.
- `ConstantManager`: Global UI and API constants (app name, bundle ID, pagination, timeouts).

### Q: How does the bottom navigation work?
**A**: `MainScreen` uses a `ValueListenableBuilder<int>` on `MainParams.selectedIndexNotifier`. Each tab index maps to a different body widget via `MainBody(index)` and a different `ScaffoldHeaderType`. Tab 2 (Scanner) bypasses `DefaultScaffold` entirely and uses a raw `Scaffold`.

### Q: How are notifications initialized?
**A**: In `MainScreen.initState()`, `NotificationNavigator()` is instantiated and `NotificationService.setupNotifications()` is called. This registers FCM handlers for foreground, background, and terminated states.

### Q: What happens on session expiry?
**A**: `UnAuthenticatedInterceptor` auto-detects 401 responses. It triggers `UnAuthenticatedBottomSheet.show()` globally (listener registered in `MazayaApp._addUnAuthenticatedListener()`). The user is then navigated back to login.

### Q: How do we handle offline state?
**A**: The `MazayaApp` builder wraps the app in an `OfflineWidget` (using `flutter_offline`) that displays a connectivity banner when the device is offline.

### Q: What font family does the project use?
**A**: **Madani Arabic** with weights from Thin (100) to Black (900). Set via `ConstantManager.fontFamily` and configured in `pubspec.yaml`.

### Q: What is the design reference size?
**A**: 375 × 911 (`ScreenSizes.width` × `ScreenSizes.height`), set in `ScreenUtilInit` for responsive scaling.
