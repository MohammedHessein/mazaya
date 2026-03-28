# Mazaya App – Architecture Guide

## High-Level Vision
The Mazaya project follows a **Modified Clean Architecture** pattern tailored for Flutter development with BLoC/Cubit.

## Core Layers
1. **Domain Layer**:
   - `entities/`: Plain Dart objects.
   - `usecases/`: Business logic units (usually via `BaseCrudUseCase`).
   - `repositories/`: Abstract interface definitions.
2. **Data Layer**:
   - `models/`: DTOs with `fromJson`/`toJson`.
   - `datasources/`: API/Local database interactions.
   - `repositories/`: Concrete implementations.
3. **Presentation Layer**:
   - `cubits/`: State management (extends `AsyncCubit` or `PaginatedCubit`).
   - `view/`: Screens/Views.
   - `widgets/`: Feature-specific UI components.
   - `imports/`: Consolidated import/export files.

## State Management (Async State Pattern)
All features use `AsyncState<T>` which includes:
- `BaseStatus`: `initial`, `loading`, `success`, `error`, `loadingMore`.
- `data`: The actual data payload.
- `errorMessage`: For error handling.

## Dependency Injection
- Uses `get_it` and `injectable`.
- Standard global access point: `injector<T>()`.
- Cubits: `@injectable`, Services: `@LazySingleton`.

## Navigation
- Centralized `Go` utility class with typed methods: `to()`, `off()`, `offAll()`, `back()`, `backToInitial()`.
- Named routes via `Go.toNamed()`, `Go.offNamed()`, `Go.offAllNamed()`.
- Custom transitions via `TransitionType` + `AnimationOption`.
- Global navigator key: `Go.navigatorKey`.

## App Initialization Flow
```
main.dart → MazayaApp → IntroScreen → LoginScreen → MainScreen
```

## MainScreen Architecture
- Uses `ValueNotifier<int>` for tab state (via `MainParams`).
- 4 tabs: Home (0), Coupons (1), Scanner (2), My Account (3).
- Each tab maps to different `ScaffoldHeaderType` in `DefaultScaffold`.
- `CustomNavigationBar` with animated position indicator.

## Directory Structure
- `lib/src/config/`: App configuration (themes, assets, localization, constants, fonts).
  - `res/`: `AppColors`, `AppSizes`, `ConstantManager`, `assets.gen.dart`, `fonts.gen.dart`.
  - `themes/`: `AppTheme` (Material 3).
  - `language/`: `locale_keys.g.dart`.
- `lib/src/core/`: Common/Shared code (widgets, utilities, base classes).
  - `base_crud/`: Generic CRUD architecture module.
  - `network/`: Dio service, interceptors, API endpoints.
  - `navigation/`: `Go` utility, transitions, page router.
  - `notification/`: FCM service, notification navigator.
  - `shared/`: `UserCubit`, `UserModel`, service locators, observers.
  - `helpers/`: Cache, validators, image, location, loading, launcher helpers.
  - `extensions/`: TextStyle, context, sized box, string, form extensions.
  - `widgets/`: 15+ widget categories (see UIComponents.md).
  - `error/`: Failure and Exception classes.
- `lib/src/features/`: Modularized features (14 features).
- `assets/translations/`: Localization files.
- `assets/svg/`: SVG assets (`base_svg/` for core, `app_svg/` for app-specific).
- `assets/lottie/`: Animation files.
- `assets/fonts/`: Madani Arabic font files.
