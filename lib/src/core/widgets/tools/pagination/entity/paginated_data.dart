part of '../imports/pagination_imports.dart';

/// Wrapper for paginated data with metadata
class PaginatedData<T> extends Equatable {
  final List<T> items;
  final PaginationMeta meta;

  const PaginatedData({
    required this.items,
    required this.meta,
  });

  factory PaginatedData.initial() {
    return const PaginatedData(
      items: [],
      meta: PaginationMeta(
        totalItems: 0,
        countItems: 0,
        perPage: 10,
        totalPages: 1,
        currentPage: 1,
      ),
    );
  }

  PaginatedData<T> copyWith({
    List<T>? items,
    PaginationMeta? meta,
  }) {
    return PaginatedData(
      items: items ?? this.items,
      meta: meta ?? this.meta,
    );
  }

  /// Add more items (for load more functionality)
  PaginatedData<T> addItems(List<T> newItems, PaginationMeta newMeta) {
    return PaginatedData(
      items: [...items, ...newItems],
      meta: newMeta,
    );
  }

  @override
  List<Object?> get props => [items, meta];
}
