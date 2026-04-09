# Mazaya App – Project Map

## Feature Modules (`lib/src/features/`)

| # | Feature | Path | Description |
|---|---------|------|-------------|
| 1 | **Auth – Login** | `features/auth/login/` | Phone/email login with animated button |
| 2 | **Auth – Forget Password** | `features/auth/forget_password/` | Send verification code for password reset |
| 3 | **Auth – OTP Verification** | `features/auth/otp_verification/` | 4-digit OTP pin verification (pinput) |
| 4 | **Auth – Reset Password** | `features/auth/reset_password/` | New password entry with success dialog |
| 5 | **Intro** | `features/intro/` | Onboarding carousel screens |
| 6 | **Main** | `features/main/` | Shell screen with bottom navigation (4 tabs) |
| 7 | **Home** | `features/home/` | Home tab – categories section + coupons section |
| 8 | **Coupons** | `features/coupons/` | Coupons list with advanced modular filtering (Country/City/Region/Distance), category chips, and OSM map details |
| 9 | **Notifications** | `features/notifications/` | Notification list, cards, delete, empty state |
| 10 | **Categories** | `features/categories/` | Discover coupons by category with clickable filtering |
| 11 | **User Profile** | `features/user_profile/` | Profile view with avatar, "Member Since" badge, and account settings |
| 12 | **QR Scanner** | `features/qr_scanner/` | Fully modular QR scanning with specialized components for camera, manual entry, and lifecycle control |
| 13 | **More** | `features/more/` | Menu with Profile, Password, Language, Settings, and Website Link |
| 14 | **Change Password** | `features/change_password/` | Dedicated secured password update feature |
| 15 | **Favourite** | `features/favourite/` | User's list of favourited coupons |
| 16 | **Used Coupons** | `features/used_coupons/` | History of successfully redeemed coupons |
| 17 | **FAQs** | `features/faqs/` | Frequently asked questions list |
| 18 | **Contact Us** | `features/contact_us/` | Help/support message form |
| 19 | **Complaints** | `features/complaints/` | Complaint submission and tracking |
| 20 | **Location** | `features/location/` | Distance-based coordinate syncing and map navigation |
| 21 | **Static Pages** | `features/static_pages/` | About, Terms, Privacy pages |

---

## Core Modules (`lib/src/core/`)

| Module | Path | Key Files |
|--------|------|-----------|
| **Base CRUD** | `core/base_crud/` | Generic CRUD usecase, guide document |
| **Network** | `core/network/` | `dio_service.dart`, `api_endpoints.dart`, interceptors |
| **Navigation** | `core/navigation/` | `navigator.dart` (Go class), `page_router/`, transitions |
| **Notification** | `core/notification/` | `notification_service.dart`, `notification_routes.dart`, `navigation_types.dart` |
| **Shared** | `core/shared/` | `UserCubit`, `UserModel`, `BlocObserver`, service locators |
| **Helpers** | `core/helpers/` | `cache_service`, `validators`, `loading_manager`, `location_helper`, `image_helper`, `lancher_helper` |
| **Extensions** | `core/extensions/` | `TextStyleEx`, `ContextExtension`, `SizedBoxHelper`, `StringExtension`, `FormMixin` |
| **Widgets** | `core/widgets/` | 44 reusable widgets (see UIComponents.md) |
| **Error** | `core/error/` | `failure.dart`, `exceptions.dart` |

---

## Config (`lib/src/config/`)

| Module | Path | Key Files |
|--------|------|-----------|
| **Resources** | `config/res/` | `color_manager.dart`, `app_sizes.dart`, `constants_manager.dart`, `assets.gen.dart`, `fonts.gen.dart` |
| **Themes** | `config/themes/` | `app_theme.dart` |
| **Language** | `config/language/` | `locale_keys.g.dart` |

---

## Assets

| Type | Path | Notes |
|------|------|-------|
| **SVG – Base** | `assets/svg/base_svg/` | Core icons (nav, arrows, profile, notifications) |
| **SVG – App** | `assets/svg/app_svg/` | App-specific images (splash, launcher icon) |
| **Fonts** | `assets/fonts/` | Madani Arabic (9 weights: Thin to Black) |
| **Lottie** | `assets/lottie/` | Animation files |
| **Translations** | `assets/translations/` | Arabic + English JSON files |

---

## API Endpoints (`ApiConstants`)

| Category | Endpoints |
|----------|-----------|
| **Auth** | `login`, `register`, `verifyAccount`, `verifyAccountResendCode`, `forgetSendCode`, `forgetReSendCode`, `forgetCheckCode`, `resetPassword` |
| **Notifications** | `notifications`, `unReadNotifications`, `deleteNotification`, `deleteAllNotifications` |
| **Settings** | `switchNotification`, `updateProfile`, `changePassword`, `changeLang`, `deleteAccount`, `updateCountry` |
| **Change Email** | `changeEmailCheckPassword`, `changeEmailSendCode`, `changeEmailReSendCode`, `changeEmailVerifyCode` |
| **More** | `faqs`, `about`, `terms`, `privacy`, `contactUs`, `complain`, `addComplain`, `complainDetails`, `logOut` |
| **Location** | `user/update-latlng` |
| **General** | `intro`, `countries`, `cities`, `uploadFiles`, `registerContent` |
