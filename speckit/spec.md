# 📋 Project Specification – Mazaya

This document serves as the authoritative "Source of Truth" for the **Mazaya** project, defining its identity, technical foundation, and core architectural pillars.

## 🏛️ Project Identity
- **Name**: Mazaya (مزايا)
- **Package Name**: `com.smartVision.mazaya`
- **Core Vision**: A premium coupon and loyalty platform delivering exclusive deals, offers, and merchant discovery for Arabic-speaking markets.
- **Primary Locale**: Arabic (RTL-first) with full secondary English support.
- **Target OS**: Android, iOS.
- **Typography**: Madani Arabic (Thin, Extra Light, Light, Regular, Medium, Semi Bold, Bold, Extra Bold, Black).
- **Design Size**: 375 × 911 (mobile-first).

---

## 🛠️ Tech Stack (100% Verified)

### Core Framework
- **Flutter SDK**: `^3.9.0`
- **Language**: Dart

### State Management & Persistence
- **State Logic**: `flutter_bloc` (v9.1.1) – Cubit-weighted architecture.
- **Status-Handling**: `AsyncCubit<T>` and `PaginatedCubit<T>` base classes.
- **Persistence**: `hydrated_bloc` (v10.1.1) for reactive state caching.

### Dependency Injection & Modularization
- **Locator**: `get_it` (v8.0.3).
- **Generation**: `injectable` (v2.5.1) with automated discovery.
- **Scaffolding**: `Mason` for feature-first generation.

### Networking & Data Handling
- **Client**: `dio` (v5.7.0).
- **Functional Logic**: `multiple_result` (v5.1.0) for predictive error handling (`Result<T, Failure>`).
- **Interceptors**: `UnAuthenticatedInterceptor` (Session/Block management), `ConfigurationInterceptor`, custom `LogInterceptor`.

### Storage & Caching
- **Sensitive Data**: `flutter_secure_storage` (v9.2.2) for encrypted tokens.
- **Global Config**: `shared_preferences` (v2.2.3) for simple key-value pairs.

### Firebase
- **Core**: `firebase_core` (v4.4.0).
- **Messaging**: `firebase_messaging` (v16.1.1) for push notifications.
- **Local Notifications**: `flutter_local_notifications` (v19.5.0).

### UI/UX & Localization
- **Localization**: `easy_localization` (v3.0.7+1) with RTL-first priority.
- **Scaling**: `flutter_screenutil` (v5.9.3) for pixel-perfect responsiveness.
- **Interactions**: `skeletonizer`, `flutter_animate`, `lottie`.
- **Media**: `video_player`, `flutter_svg`, `cached_network_image`, `carousel_slider`.
- **Forms**: `pinput` (v5) for OTP, `dropdown_search` (v6) for advanced dropdowns.

### Location & Maps
- **Geolocation**: `geolocator` (v14.0.2).
- **Geocoding**: `geocoding` (v4.0.0).

### Utilities
- **URL Launcher**: `url_launcher` (v6.3.0).
- **Sharing**: `share_plus` (v11.1.0).
- **Reactive Streams**: `rxdart` (v0.28.0).
- **Image Processing**: `image_picker`, `image_cropper`, `file_picker`.

---

## 🏗️ Architectural Foundations

### 1. Feature-First Structure
The project lives in `lib/src/`, split into three high-level domains:
- **`config/`**: Styling tokens (`AppColors`, `AppSizes`), Material 3 themes (`AppTheme`), localization assets, and generated code (`assets.gen.dart`, `fonts.gen.dart`, `locale_keys.g.dart`).
- **`core/`**: Shared infrastructure:
  - `base_crud/`: Generic Clean Architecture CRUD module with standard usecase logic.
  - `network/`: Dio service, interceptors (`UnAuthenticatedInterceptor`, `ConfigurationInterceptor`), and API endpoints.
  - `navigation/`: Centralized `Go` utility, `PageRouterBuilder`, and transition builders.
  - `notification/`: FCM service, navigation types, and notification routing.
  - `shared/`: App-wide `UserModel`, `UserCubit`, DI locators, and `BlocObserver`.
  - `helpers/`: Cache service, validators, loading manager, location helper, launcher helper, image helper.
  - `extensions/`: `TextStyleEx`, `ContextExtension`, `SizedBoxHelper`, `FormMixin`, `StringExtension`.
  - `widgets/`: Base library (see UIComponents.md).
  - `error/`: Failure and Exception classes.
- **`features/`**: Modular, self-contained business features (14 features – see ProjectMap.md).

### 2. Networking Resilience
- **Base CRUD**: All standard API operations are piped through a generic `BaseCrudUseCase`.
- **Error Mapping**: Automated mapping of HTTP codes to domain `Failure` objects.
- **Interceptor Stack**: Log → Configuration → UnAuthenticated.

### 3. Session & Security
- **Global Access**: Auth state is managed by a lazy-singleton `UserCubit`.
- **Session Protection**: `UnAuthenticatedInterceptor` automatically triggers a global `UnAuthenticatedBottomSheet` on 401/Blocked responses.
- **Secure Storage**: Auth tokens stored encrypted via `FlutterSecureStorage`.

### 4. App Flow
```
IntroScreen → LoginScreen → MainScreen (Bottom Nav)
                                ├── Home (tab 0)
                                ├── Coupons (tab 1)
                                ├── QR Scanner (tab 2)
                                └── My Account / More (tab 3)
```
