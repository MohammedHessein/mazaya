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
      totalItems: json['total'] ?? json['total_items'] ?? 0,
      countItems: json['count'] ??
          json['count_items'] ??
          ((json['to'] != null && json['from'] != null)
              ? (json['to'] as int) - (json['from'] as int) + 1
              : 0),
      perPage: json['per_page'] ?? json['paginate'] ?? ConstantManager.pgSize,
      totalPages: json['last_page'] ?? json['total_pages'] ?? 1,
      currentPage: json['current_page'] ?? 1,
      nextPageUrl: json['next_page_url'],
      prevPageUrl: json['prev_page_url'] ?? json['perv_page_url'],
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
