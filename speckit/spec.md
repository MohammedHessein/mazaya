# 📋 Project Specification - Flutter_Base

This document serves as the authoritative "Source of Truth" for the `Flutter_Base` project, defining its identity, technical foundation, and core architectural pillars.

## 🏛️ Project Identity
- **Name**: Flutter_Base
- **Core Vision**: A premium, high-performance modular baseline for scalable Flutter applications.
- **Primary Locale**: Arabic (RTL-first) with full secondary English support.
- **Target OS**: Android, iOS, Windows.
- **Typography**: Expo (Light, Book, Medium, SemiBold, Bold).

---

## 🛠️ Tech Stack (100% Verified)

### Core Framework
- **Flutter SDK**: `^3.8.0`
- **Language**: Dart

### State Management & Persistence
- **State Logic**: `flutter_bloc` (v9.1.1) - Cubit-weighted architecture.
- **Status-Handling**: `AsyncCubit<T>` and `PaginatedCubit<T>` base classes.
- **Persistence**: `hydrated_bloc` (v10.1.1) for reactive state caching.

### Dependency Injection & Modularization
- **Locator**: `get_it` (v8.0.3).
- **Generation**: `injectable` (v2.5.1) with automated discovery.
- **Scaffolding**: `Mason` for feature-first generation.

### Networking & Data Handling
- **Client**: `dio` (v5.7.0).
- **Functional Logic**: `multiple_result` (v5.1.0) for predictive error handling (`Result<T, Failure>`).
- **Interceptors**: `UnAuthenticatedInterceptor` (Session/Block management).

### Storage & Caching
- **Sensitive Data**: `flutter_secure_storage` (v9.2.2) for encrypted tokens.
- **Global Config**: `shared_preferences` (v2.2.3) for simple key-value pairs.

### UI/UX & Localization
- **Localization**: `easy_localization` (v3.0.7) with RTL-first priority.
- **Scaling**: `flutter_screenutil` (v5.9.3) for pixel-perfect responsiveness.
- **Interactions**: `skeletonizer`, `flutter_animate`, `lottie`.
- **Media**: `video_player`, `flutter_svg`, `cached_network_image`.

---

## 🏗️ Architectural Foundations

### 1. Feature-First Structure
The project lives in `lib/src/`, split into three high-level domains:
- **`config/`**: Styling tokens, Material 3 themes, and localization assets.
- **`core/`**: Shared infrastructure:
  - `network/`: Dio service, interceptors, and Base CRUD.
  - `navigation/`: Centralized `Go` utility and transition builders.
  - `shared/`: App-wide `UserModel`, `UserCubit`, and DI locators.
  - `widgets/`: Base library (`AppTextField`, `UniversalMediaWidget`).
- **`features/`**: Modular, self-contained business logic (Logic/Settings pattern).

### 2. Networking Resilience
- **Base CRUD**: All standard API operations are piped through a generic `BaseCrudUseCase`.
- **Error Mapping**: Automated mapping of HTTP codes (PHP/ASP) to domain `Failure` objects.

### 3. Session & Security
- **Global Access**: Auth state is managed by a lazy-singleton `UserCubit`.
- **Session Protection**: `UnAuthenticatedInterceptor` automatically triggers a global UI bottomsheet on 401/Blocked responses.
