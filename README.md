# 🎯 Mazaya (مزايا)

**Mazaya** is a premium coupon and loyalty platform delivering exclusive deals, offers, and merchant discovery for Arabic-speaking markets. Built with Flutter, it provides an RTL-first experience with modular architecture and a rich component library.

---

## 🏛️ Project Architecture
This project follows a strict **Clean Architecture (Feature-First)** approach, ensuring scalability and isolation across all business modules.

- **`lib/src/config/`**: Styling tokens, Material 3 themes, localization assets, generated code.
- **`lib/src/core/`**: Shared infrastructure, 44+ reusable widgets, and centralized logic for networking, navigation, and notifications.
- **`lib/src/features/`**: 18 modular, self-contained features (Auth, Home, Coupons, QR Scanner, Notifications, Profile, More, and more).

---

## 📖 Deep-Dive Documentation
For comprehensive technical guides and architectural decisions, please refer to:

- 📋 **[Project Specification](speckit/spec.md)**: Tech stack, foundations, and identity.
- 🏛️ **[Project Constitution](speckit/constitution.md)**: Immutable architectural laws.
- 🚀 **[Implementation Workflows](speckit/implement.md)**: 12+ standard developer workflows and code examples.
- ❓ **[Clarifications & ADRs](speckit/clarify.md)**: Significant technical decisions and Q&A.
- ✅ **[Development Checklist](speckit/checklist.md)**: Feature development checklist.
- 📚 **[Glossary](speckit/glossary.md)**: 60+ core terminology definitions.
- 🗺️ **[Project Map](.antigravity/ProjectMap.md)**: Complete feature and module map.
- 🎨 **[UI Components](.antigravity/UIComponents.md)**: 44 reusable widget reference.
- 🧩 **[Patterns](.antigravity/PATTERNS.md)**: Logic patterns and flow guides.

---

## 🛠️ Tech Stack
- **Framework**: Flutter (SDK `^3.9.0`)
- **State Management**: `flutter_bloc` (Cubit-first) + `hydrated_bloc` for persistence.
- **Dependency Injection**: `get_it` (Service Locator) + `injectable` (Automated discovery).
- **Network**: `dio` + `multiple_result` (Functional Error Handling).
- **Caching**: `shared_preferences` + `flutter_secure_storage` (Encrypted).
- **Firebase**: `firebase_core` + `firebase_messaging` + `flutter_local_notifications`.
- **UI/UX**: `easy_localization` (RTL-first), `skeletonizer`, `flutter_screenutil`, `flutter_animate`.
- **Typography**: Madani Arabic (9 weights).

---

## 📱 App Flow
```
IntroScreen → LoginScreen → MainScreen (Bottom Nav)
                                ├── Home (tab 0) – Categories + Coupons
                                ├── Coupons (tab 1) – Search + Filter
                                ├── QR Scanner (tab 2) – QR Scanning & Verification
                                └── More (tab 3) – Profile, Password, Language, Settings
```

---

## 🚀 Getting Started

### 1. Install Dependencies
```bash
flutter pub get
```

### 2. Code Generation
The project relies on `build_runner` for DI and asset mapping:
```bash
dart run build_runner build --delete-conflicting-outputs
```

### 3. Localization
Generate localization keys after updating translation files:
```bash
dart run generate/strings/main.dart
```

### 4. Scaffolding Features
Use Mason to generate new features following the Clean Architecture pattern:
```bash
mason make feature --name <feature_name>
```

---

## 🌍 Localization
The app is **RTL-first** with primary support for **Arabic**, and secondary support for **English** and **Swedish**. 
- **Translations Assets**: `assets/translations/`
- **Generated Keys**: `lib/src/config/language/locale_keys.g.dart`
- **Logic**: All strings must use `.tr()` extension for reactive localization.

---

## 🎨 Design System
- **Design Size**: 375 × 911 (mobile-first responsive via `flutter_screenutil`)
- **Primary Color**: `#315EA1` (Blue)
- **Font**: Madani Arabic
- **Spacing**: `SizedBoxHelper` extensions (`10.szH`, `15.szW`)
- **Text Styling**: `TextStyleEx` chains (`context.textStyle.s16.bold.setWhiteColor`)
