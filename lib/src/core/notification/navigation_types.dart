part of 'notification_service.dart';

/// This enum unifies both modern numeric (1-6) and legacy string-based notifications.
enum NotificationType {
  // --- Modern numeric mapping (notification_type: 1-6) ---

  /// 1: Account activation → Profile (More tab)
  accountActivation(code: 1, action: ProfileAction()),

  /// 2: Expiry reminder (3 days) → Home
  nearExpiry(code: 2, action: HomeAction()),

  /// 3: Expiry reminder (Today) → Home
  expired(code: 3, action: HomeAction()),

  /// 4: Coupon used confirmation → Used Coupons
  couponUsed(code: 4, action: UsedCouponsAction()),

  /// 5: Smart recommendation → Coupons (Filtered by category)
  recommendation(code: 5, action: CategoryRecommendationAction()),

  /// 6: Dashboard/Inactivity → Home
  dashboard(code: 6, action: HomeAction()),

  // --- Legacy/Admin string mapping (type: string) ---

  adminNotify(key: "admin_notify", action: NoAction()),
  adminUserBlocked(key: "admin_user_blocked", action: NoAction()),
  block(key: "block", action: NoAction()),
  blockNotify(key: "block_notify", action: NoAction()),
  deleteNotify(key: "delete_notify", action: NoAction()),
  userBlocked(key: "user_blocked", action: NoAction());

  final int? code;
  final String? key;
  final NotificationNavigation action;

  const NotificationType({this.code, this.key, required this.action});

  static NotificationType? fromCode(int code) {
    return NotificationType.values.where((e) => e.code == code).firstOrNull;
  }
}

extension NotificationTypeExtension on String {
  NotificationType? get toNotification => NotificationType.values
      .where((element) => element.key == this)
      .firstOrNull;
}

abstract interface class NotificationNavigation {
  const NotificationNavigation();
  void navigate({required Map<String, dynamic> data});
}

class NoAction implements NotificationNavigation {
  const NoAction();
  @override
  void navigate({required Map<String, dynamic> data}) {}
}

class HomeAction implements NotificationNavigation {
  const HomeAction();
  @override
  void navigate({required Map<String, dynamic> data}) {
    Go.offAll(const MainScreen(initialTabIndex: 0));
  }
}

class CouponsAction implements NotificationNavigation {
  const CouponsAction();
  @override
  void navigate({required Map<String, dynamic> data}) {
    Go.offAll(const MainScreen(initialTabIndex: 1));
  }
}

class ProfileAction implements NotificationNavigation {
  const ProfileAction();
  @override
  void navigate({required Map<String, dynamic> data}) {
    Go.offAll(const MainScreen(initialTabIndex: 3));
  }
}

class UsedCouponsAction implements NotificationNavigation {
  const UsedCouponsAction();
  @override
  void navigate({required Map<String, dynamic> data}) {
    Go.to(const UsedCouponsScreen());
  }
}

class CategoryRecommendationAction implements NotificationNavigation {
  const CategoryRecommendationAction();
  @override
  void navigate({required Map<String, dynamic> data}) {
    final nestedData = data['data'];
    final categoryId = NotificationRoutes._extractCategoryId(nestedData, data);

    if (categoryId != null) {
      log('🎯 Filtering coupons by category ID: $categoryId');

      // Attempt to resolve category name from HomeCubit cache
      String resolvedName = '';
      final homeState = injector<HomeCubit>().state;
      if (homeState.isSuccess) {
        final category = homeState.data?.categories.firstWhereOrNull(
          (c) => c.id == categoryId,
        );
        if (category != null) {
          resolvedName = category.name;
          log('✅ Resolved category name: $resolvedName');
        }
      }

      injector<CouponsCubit>().applyFilters(
        category: CategoryEntity(id: categoryId, name: resolvedName),
      );
    } else {
      log('⚠️ WARNING: Category recommendation action triggered, but categoryId was not found.');
      log('   Check NotificationRoutes logs for details on searched fields.');
    }

    // Always navigate to coupons tab
    Go.offAll(const MainScreen(initialTabIndex: 1));
  }
}
