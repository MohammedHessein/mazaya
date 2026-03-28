# 🗺️ Mazaya App – Implementation Plan

This plan outlines the strategic direction for the Mazaya project's development and infrastructure improvements.

## 🟢 Phase 1: Core UI & Architecture ✅ (Completed)
- [x] Implement Clean Architecture feature-first structure.
- [x] Build `DefaultScaffold` with 4 header types (home, auth, standard, profile).
- [x] Build `MainScreen` with `CustomNavigationBar` (4 tabs).
- [x] Complete auth flow (Login, Forget Password, OTP, Reset Password).
- [x] Implement intro/onboarding carousel.
- [x] Build all core widgets (AppCard, LoadingButton, AppTextField, AppDropdown, etc.).
- [x] Implement NotificationService with FCM integration.
- [x] Build 14 feature modules (Home, Coupons, Notifications, Profile, FAQs, Settings, etc.).
- [x] Consolidate project documentation (Spec Kit + .antigravity).

## 🟡 Phase 2: API Integration & Feature Completion (Current)
- [ ] Connect auth endpoints to live backend.
- [ ] Implement QR Scanner (tab 2) with camera and barcode scanning.
- [ ] Connect Coupons feature to live API with real data.
- [ ] Implement coupon detail screen with share/copy functionality.
- [ ] Connect Notifications to live FCM + API.
- [ ] Connect User Profile to update/change password APIs.
- [ ] Implement coupon favorites (localStorage or API-backed).
- [ ] Fix remaining Figma pixel-perfect discrepancies.

## 🔴 Phase 3: Scaling & Optimization
- [ ] Add unit tests for core utilities (`baseCrudUseCase`, `Validators`, `CacheService`).
- [ ] Performance audit for complex lists and transitions.
- [ ] Implement dark mode theme via `AppColorsWithDarkMode`.
- [ ] Implement CI/CD pipelines for automated builds.
- [ ] Multi-flavor support (Development, Staging, Production).
- [ ] Implement search and filter with API-backed pagination.
- [ ] Advanced routing (deep links, notification-triggered navigation).

---

## Active Initiatives
- **API Integration**: Transitioning from mock data to live API endpoints across all features.
- **QR Scanner**: Implementing barcode/QR scanning functionality for coupon redemption.
- **Documentation Maintenance**: Keeping Spec Kit and .antigravity docs in sync with codebase evolution.
