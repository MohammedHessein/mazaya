import 'dart:async';
import 'dart:developer';

import 'package:app_links/app_links.dart';
import 'package:mazaya/src/core/extensions/uri_extension.dart';
import 'package:mazaya/src/core/navigation/navigator.dart';
import 'package:mazaya/src/features/coupons/presentation/view/coupon_details_screen.dart';

class DeepLinkService {
  DeepLinkService._();
  static final instance = DeepLinkService._(); // ✅ اختصار الـ Singleton

  final _appLinks = AppLinks();
  StreamSubscription<Uri>? _linkSubscription;

  Future<void> init() async {
    try {
      final uri = await _appLinks.getInitialLink();
      if (uri != null) _handleDeepLink(uri);
    } catch (e) {
      log('❌ Initial deep link error: $e');
    }

    _linkSubscription = _appLinks.uriLinkStream.listen(
      _handleDeepLink,
      onError: (err) => log('❌ Stream error: $err'),
    );
  }

  void _handleDeepLink(Uri uri) {
    // ✅ دعم: mazaya://coupon?id=123 أو https://mazaya.com/coupon/123
    if (!uri.isCouponLink) return;

    final id = uri.extractId();
    if (id != null) {
      log('🚀 Navigate to Coupon #$id');
      Go.to(CouponDetailsScreen(id: id));
    } else {
      log('⚠️ Invalid ID in link: $uri');
    }
  }

  void dispose() => _linkSubscription?.cancel(); // ✅ اختصار الـ dispose
}
