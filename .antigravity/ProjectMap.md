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
| 8 | **Coupons** | `features/coupons/` | Coupons list with search bar + filter bottom sheet |
| 9 | **Notifications** | `features/notifications/` | Notification list, cards, delete, empty state |
| 10 | **User Profile** | `features/user_profile/` | Profile view with avatar and account settings |
| 11 | **QR Scanner** | `features/scan/` | QR scanning for coupons and merchant verification |
| 12 | **More** | `features/more/` | Consolidated menu with Profile, Password, Language, and Settings |
| 13 | **Favourite** | `features/favourite/` | User's list of favourited coupons |
| 14 | **Used Coupons** | `features/used_coupons/` | History of successfully redeemed coupons |
| 15 | **FAQs** | `features/faqs/` | Frequently asked questions list |
| 16 | **Contact Us** | `features/contact_us/` | Help/support message form |
| 17 | **Complains** | `features/complains/` | Complaint submission and tracking |
| 18 | **Location** | `features/location/` | Location-based features with geolocation |
| 19 | **Static Pages** | `features/static_pages/` | About, Terms, Privacy pages |

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
| **General** | `intro`, `countries`, `cities`, `uploadFiles`, `registerContent` |
