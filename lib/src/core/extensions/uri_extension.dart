extension UriExtension on Uri {
  bool get isCouponLink =>
      path.toLowerCase().contains('coupon') ||
      host.toLowerCase().contains('coupon');

  int? extractId() {
    // ✅ أولًا: جرب الـ Query Param `?id=`
    final id = queryParameters['id'];
    if (id != null) return int.tryParse(id);

    // ✅ ثانيًا: جرب آخر جزء في الـ Path (لو مش كلمة 'coupon')
    final segments = pathSegments;
    if (segments.isNotEmpty && segments.last.toLowerCase() != 'coupon') {
      return int.tryParse(segments.last);
    }
    return null;
  }
}
