# ⚽ Flutter_Base

**Flutter_Base** is a premium management and scalability platform tailored for high-performance mobile and desktop applications. Built with Flutter, it delivers a robust, RTL-first experience for enterprise-grade projects with a focus on modularity and maintenance.

---

## 🏛️ Project Architecture
This project follows a strict **Clean Architecture (Feature-First)** approach, ensuring scalability and isolation across all business modules.

- **`lib/src/core/`**: Shared infrastructure, specialized base widgets (`UniversalMediaWidget`, `LoadingButton`), and the centralized logic for networking and navigation.
- **`lib/src/features/`**: Modular, self-contained business logic and UI for all application features.

---

## 📖 Deep-Dive Documentation
For comprehensive technical guides and architectural decisions, please refer to:

- 📋 **[Project Specification](speckit/spec.md)**: Tech stack, foundations, and identity.
- 🏛️ **[Project Constitution](speckit/constitution.md)**: Immutable architectural laws.
- 🚀 **[Implementation Workflows](speckit/implement.md)**: 10+ standard developer workflows and code examples.
- ❓ **[Clarifications & ADRs](speckit/clarify.md)**: Significant technical decisions and Q&A.
- ✅ **[Project Rules & Standards](.agents/skills/project_efficiency/rules.md)**: Coding conventions and standards.
- 🗺️ **[Glossary](speckit/glossary.md)**: 30+ core terminology definitions.

---

## 🛠️ Tech Stack
- **Framework**: Flutter (SDK `^3.8.0`)
- **State Management**: `flutter_bloc` (Cubit-first) + `hydrated_bloc` for persistence.
- **Dependency Injection**: `get_it` (Service Locator) + `injectable` (Automated discovery).
- **Network**: `dio` + `multiple_result` (Functional Error Handling).
- **Caching**: `shared_preferences` + `flutter_secure_storage` (Encrypted).
- **UI/UX**: `easy_localization` (RTL-first), `skeletonizer`, `flutter_screenutil`.

---

## 🚀 Getting Started

### 1. Install Dependencies
```bash
flutter pub get
```

### 2. Code Generation
The project relies on `build_runner` for DI and data mapping:
```bash
dart run build_runner build --delete-conflicting-outputs
```

### 3. Localization
Generate localization keys after updating translation files:
```bash
dart run generate/strings/main.dart
```

### 4. Scaffolding Features
Use Mason to generate new features following the Logic/Settings pattern:
```bash
mason make feature --name <feature_name>
```

---

## 🌍 Localization
The app is **RTL-first** with primary support for **Arabic** and secondary support for **English**. 
- **Translations Assets**: `assets/translations/`
- **Generated Keys**: `lib/src/config/language/locale_keys.g.dart`
- **Logic**: All strings must use `.tr()` extension for reactive localization.
