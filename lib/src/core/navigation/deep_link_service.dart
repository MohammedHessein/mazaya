import 'dart:async';
import 'dart:developer';

import 'package:app_links/app_links.dart';
import 'package:mazaya/src/core/navigation/navigator.dart';
import 'package:mazaya/src/features/coupons/presentation/view/coupon_details_screen.dart';

class DeepLinkService {
  DeepLinkService._();
  static final DeepLinkService _instance = DeepLinkService._();
  factory DeepLinkService() => _instance;

  final _appLinks = AppLinks();
  StreamSubscription<Uri>? _linkSubscription;

  Future<void> init() async {
    // Check initial link if app was closed
    try {
      final initialUri = await _appLinks.getInitialLink();
      if (initialUri != null) {
        log('🔗 Initial Deep Link: $initialUri');
        _handleDeepLink(initialUri);
      }
    } catch (e) {
      log('❌ Error fetching initial deep link: $e');
    }

    // Handle links while app is running
    _linkSubscription = _appLinks.uriLinkStream.listen(
      (uri) {
        _handleDeepLink(uri);
      },
      onError: (err) {
        log('❌ Deep Link Stream Error: $err');
      },
    );
  }

  void _handleDeepLink(Uri uri) {
    log('🔗 Handling Deep Link: $uri');

    // Supported formats:
    // mazaya://coupon?id=123
    // https://mazaya.com/coupon/123
    // https://mazaya.com/coupon?id=123

    final String path = uri.path.toLowerCase();
    final String host = uri.host.toLowerCase();

    if (path.contains('coupon') || host.contains('coupon')) {
      final String? idParam = uri.queryParameters['id'];
      final String? lastSegment = uri.pathSegments.isNotEmpty ? uri.pathSegments.last : null;
      
      final String? idString = idParam ?? (lastSegment != 'coupon' ? lastSegment : null);
      final int? id = idString != null ? int.tryParse(idString) : null;

      if (id != null) {
        log('🚀 Deep Link: Navigating to Coupon Details ID: $id');
        Go.to(CouponDetailsScreen(id: id));
      } else {
        log('⚠️ Deep Link: Could not extract a valid ID from $uri');
      }
    }
  }

  void dispose() {
    _linkSubscription?.cancel();
  }
}
