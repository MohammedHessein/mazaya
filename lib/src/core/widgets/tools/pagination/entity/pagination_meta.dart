part of '../imports/pagination_imports.dart';

/// Pagination metadata from API response
class PaginationMeta extends Equatable {
  final int totalItems;
  final int countItems;
  final int perPage;
  final int totalPages;
  final int currentPage;
  final String? nextPageUrl;
  final String? prevPageUrl;

  const PaginationMeta({
    required this.totalItems,
    required this.countItems,
    required this.perPage,
    required this.totalPages,
    required this.currentPage,
    this.nextPageUrl,
    this.prevPageUrl,
  });

  factory PaginationMeta.fromJson(Map<String, dynamic> json) {
    return PaginationMeta(
      totalItems: MappingHelpers.toInt(json['total'] ?? json['total_items']),
      countItems: MappingHelpers.toInt(
        json['count'] ??
            json['count_items'] ??
            ((json['to'] != null && json['from'] != null)
                ? (MappingHelpers.toInt(json['to'])) -
                        (MappingHelpers.toInt(json['from'])) +
                        1
                : 0),
      ),
      perPage: MappingHelpers.toInt(
          json['per_page'] ?? json['paginate'] ?? ConstantManager.pgSize),
      totalPages:
          MappingHelpers.toInt(json['last_page'] ?? json['total_pages'] ?? 1),
      currentPage: MappingHelpers.toInt(json['current_page'] ?? 1),
      nextPageUrl: MappingHelpers.toStringSafe(json['next_page_url']),
      prevPageUrl: MappingHelpers.toStringSafe(
          json['prev_page_url'] ?? json['perv_page_url']),
    );
  }

  bool get hasNextPage => nextPageUrl != null && nextPageUrl!.isNotEmpty;
  bool get hasPrevPage => prevPageUrl != null && prevPageUrl!.isNotEmpty;
  bool get isLastPage => currentPage >= totalPages;
  bool get isFirstPage => currentPage == 1;

  @override
  List<Object?> get props => [
    totalItems,
    countItems,
    perPage,
    totalPages,
    currentPage,
    nextPageUrl,
    prevPageUrl,
  ];
}
