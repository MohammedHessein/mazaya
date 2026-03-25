# 📚 Project Glossary

Common terms and concepts used within the codebase.

| **AppTheme** | Centralized configuration for light and dark modes using Material 3 and custom color tokens. |
| **Async** | A domain-level wrapper for data that tracks loading, success, and failure states independently of UI cubits. |
| **Base CRUD** | A generic Clean Architecture module within `core` that standardizes repository and usecase logic for any API model. |
| **ConstantManager** | A single source of truth for global app configuration like `bundleId`, `timeout`, and `pagination` sizes. |
| **DefaultScaffold** | A standardized layout widget that initializes `SafeArea`, `PopScope`, and a reusable `ArrowWidget` header. |
| **Failure** | A set of domain-layer classes representing categorized errors (e.g., `ServerFailure`, `CacheFailure`). |
| **HandlingViews** | A collection of UI components for conveying empty, error, offline, or loading states to the user. |
| **LoadingButton** | A specialized button supporting async operations with built-in loading indicators or progress tracking. |
| **LocaleKeys** | Generated localization keys from `easy_localization` (stored in `locale_keys.g.dart`). |
| **NotificationService** | Handles FCM tokens, background/foreground messages, and local notifications. |
| **NotificationNavigator** | A dispatcher that routes the app to specific screens based on notification payload data. |
| **NotificationType** | An enum defining all supported notification intents (e.g., `adminNotify`, `chat`, `block`). |
| **PaginatedListWidget** | A high-level widget that integrates with `PaginatedCubit` to provide infinite scrolling and refresh logic. |
| **RTL-First** | A design approach prioritizing Right-to-Left languages (Arabic), using `start`/`end` instead of `left`/`right`. |
| **SecureStorage** | A wrapper for `FlutterSecureStorage` used for storing sensitive encrypted data like auth tokens. |
| **Spec Kit** | The documentation system used to define specifications, rules, and plans for the project. |
| **TextStyleEx** | An extension allowing chainable styling of `TextStyle` (e.g., `.bold.s14.setPrimaryColor`). |
| **UnAuthenticatedInterceptor** | A networking interceptor that triggers a global UI bottomsheet when the session expires or the user is blocked. |
| **UniversalMediaWidget** | A versatile widget that displays images (SVG, PNG, JPG) or videos from various sources. |
| **UploadImage** | A specialized UI component for selecting and uploading one or more images. |
| **UserCubit** | A centralized cubit for managing the current user's profile and authentication status (Session Management). |
| **UserModel** | The standard data structure representing the logged-in user, including profile details and auth token. |
| **Validators** | Form field validation logic with security guards against script injection. |
