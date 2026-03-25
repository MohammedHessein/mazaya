part of'imports/pagination_imports.dart';
/// Enum for list view type
enum ListViewType { list, grid }

/// Configuration class for paginated list widget
class PaginatedListConfig {
  /// List view type (list or grid)
  final ListViewType viewType;

  /// Scroll direction (horizontal or vertical)
  final Axis scrollDirection;

  /// Scroll physics
  final ScrollPhysics? physics;

  /// Padding around the list
  final EdgeInsetsGeometry? padding;

  /// Margin around each item
  final EdgeInsetsGeometry? itemMargin;

  /// Whether to use separator in ListView (only for ListViewType.list)
  final bool useSeparator;

  /// Separator widget (only used if useSeparator is true)
  final Widget? separator;

  /// Grid delegate (only for ListViewType.grid)
  final SliverGridDelegate? gridDelegate;

  /// Whether to shrink wrap
  final bool shrinkWrap;

  /// Reverse the list
  final bool reverse;

  /// Primary scroll
  final bool? primary;

  /// Scroll controller
  final ScrollController? controller;

  /// Whether to enable pull-to-refresh
  final bool enableRefresh;

  /// Color of the refresh indicator
  final Color? refreshIndicatorColor;

  /// Background color of the refresh indicator
  final Color? refreshIndicatorBackgroundColor;

  /// Displacement of the refresh indicator
  final double refreshIndicatorDisplacement;

  const PaginatedListConfig({
    this.viewType = ListViewType.list,
    this.scrollDirection = Axis.vertical,
    this.physics,
    this.padding,
    this.itemMargin,
    this.useSeparator = false,
    this.separator,
    this.gridDelegate,
    this.shrinkWrap = false,
    this.reverse = false,
    this.primary,
    this.controller,
    this.enableRefresh = true,
    this.refreshIndicatorColor,
    this.refreshIndicatorBackgroundColor,
    this.refreshIndicatorDisplacement = 40.0,
  });

  /// Create a copy with modified values
  PaginatedListConfig copyWith({
    ListViewType? viewType,
    Axis? scrollDirection,
    ScrollPhysics? physics,
    EdgeInsetsGeometry? padding,
    EdgeInsetsGeometry? itemMargin,
    bool? useSeparator,
    Widget? separator,
    SliverGridDelegate? gridDelegate,
    bool? shrinkWrap,
    bool? reverse,
    bool? primary,
    ScrollController? controller,
    bool? enableRefresh,
    Color? refreshIndicatorColor,
    Color? refreshIndicatorBackgroundColor,
    double? refreshIndicatorDisplacement,
  }) {
    return PaginatedListConfig(
      viewType: viewType ?? this.viewType,
      scrollDirection: scrollDirection ?? this.scrollDirection,
      physics: physics ?? this.physics,
      padding: padding ?? this.padding,
      itemMargin: itemMargin ?? this.itemMargin,
      useSeparator: useSeparator ?? this.useSeparator,
      separator: separator ?? this.separator,
      gridDelegate: gridDelegate ?? this.gridDelegate,
      shrinkWrap: shrinkWrap ?? this.shrinkWrap,
      reverse: reverse ?? this.reverse,
      primary: primary ?? this.primary,
      controller: controller ?? this.controller,
      enableRefresh: enableRefresh ?? this.enableRefresh,
      refreshIndicatorColor: refreshIndicatorColor ?? this.refreshIndicatorColor,
      refreshIndicatorBackgroundColor: refreshIndicatorBackgroundColor ?? this.refreshIndicatorBackgroundColor,
      refreshIndicatorDisplacement: refreshIndicatorDisplacement ?? this.refreshIndicatorDisplacement,
    );
  }
}
