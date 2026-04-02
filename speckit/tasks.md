# 📌 Mazaya App – Active Tasks & Backlog

## ✅ Completed
- [x] Project renamed from Flutter_Base/Hattrick to **Mazaya**.
- [x] Create centralized coding rules.
- [x] Update root `README.md` to professional standard.
- [x] Complete Spec Kit suite (`spec.md`, `constitution.md`, `implement.md`, `clarify.md`, `checklist.md`, `glossary.md`, `plan.md`).
- [x] Implement `DefaultScaffold` with 4 header types (home, auth, standard, profile).
- [x] Implement `MainScreen` with bottom navigation (Home, Coupons, Scanner, My Account).
- [x] Implement `CustomNavigationBar` with animated indicator.
- [x] Implement Auth flow (Login, Forget Password, OTP Verification, Reset Password).
- [x] Implement Intro/Onboarding screen with carousel.
- [x] Implement Home screen with categories + coupons sections.
- [x] Implement Coupons screen with search bar + filter bottom sheet.
- [x] Implement Notifications screen with notification cards + empty state.
- [x] Implement FCM notification service + navigation dispatcher.
- [x] Implement FAQs, Contact Us, Complains, Static Pages, Settings, More features.
- [x] Implement User Profile feature with profile header.
- [x] Implement Location feature with geolocation support.
- [x] Implement QR Scanner tab (tab 2) functionality.
- [x] Integrate Swedish language support.
- [x] Refactor and merge Settings into More feature.
- [x] Implement Favourite and Used Coupons screens.

- [ ] Finalize Figma pixel-perfect alignment across all screens.
- [ ] Connect all features to live API endpoints.

## 📋 Infrastructure Backlog
| Priority | Task | Module |
| :--- | :--- | :--- |
| 🔴 High | Connect auth APIs to live backend | `features/auth/` |
| 🔴 High | Add unit tests for `baseCrudUseCase` | `core/base_crud/` |
| 🟡 Medium | Implement automated request retry in `DioService` | `core/network/` |
| 🟡 Medium | Add dark mode theme support | `config/themes/` |
| 🟡 Medium | Implement Coupon detail screen | `features/coupons/` |
| 🟡 Medium | Implement search/filter with API integration | `features/coupons/` |
| 🟢 Low | Performance audit for complex lists | `features/*/view/` |
| 🟢 Low | Implement CI/CD pipelines | Infrastructure |
| 🟢 Low | Multi-flavor support (Dev, Staging, Production) | Infrastructure |
