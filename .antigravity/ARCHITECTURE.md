# Project Architecture Guide

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

## State Management (Async State Pattern)
All features use `AsyncState<T>` which includes:
- `BaseStatus`: `initial`, `loading`, `success`, `error`, `loadingMore`.
- `data`: The actual data payload.
- `errorMessage`: For error handling.

## Dependency Injection
- Uses `get_it` and `injectable`.
- Standard global access point: `injector<T>()`.

## Directory Structure
- `lib/src/config/`: App configuration (routes, themes, assets).
- `lib/src/core/`: Common/Shared code (widgets, utilities, base classes).
- `lib/src/features/`: Modularized features.
- `assets/translations/`: Localization files (`lang.json`).
