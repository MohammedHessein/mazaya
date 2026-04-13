part of '../imports/pagination_imports.dart';

/// Abstract base cubit for paginated data
abstract class PaginatedCubit<T> extends AsyncCubit<PaginatedData<T>> {
  /// Optional mapper function to convert JSON to entity [T]
  final T Function(Map<String, dynamic> json)? itemMapper;

  PaginatedCubit({this.itemMapper}) : super(PaginatedData.initial());

  int _currentPage = 1;
  bool _isLoadingMore = false;
  String? _filterKey;

  int get currentPage => _currentPage;
  bool get isLoadingMore => _isLoadingMore;
  bool get hasMorePages => !state.data.meta.isLastPage;
  bool get canLoadMore => hasMorePages && !_isLoadingMore && !isLoading;

  /// Get the current filter key (e.g., order type, stage, etc.)
  String? get filterKey => _filterKey;

  /// Override this method to provide the API call
  /// Returns a Result with list of items and pagination meta
  /// [page] - The current page number
  /// [searchQuery] - Optional filter key (e.g., order type, stage, status)
  Future<Result<Map<String, dynamic>, Failure>> fetchPageData(
    int page, {
    String? searchQuery,
  });

  /// Default implementation for parsing items from JSON.
  /// Looks for json['data']['data'] or json['data'].
  /// Override this if your API uses a different structure.
  List<T> parseItems(dynamic json) {
    if (json == null || itemMapper == null) return [];

    // Check common nested paths for the list data
    final listData = json['data']?['data'] ?? json['data'] ?? json;

    if (listData is List) {
      return listData
          .map((e) => itemMapper!(Map<String, dynamic>.from(e)))
          .toList();
    }
    return [];
  }

  /// Default implementation for parsing pagination metadata.
  /// Override this if your API uses a different structure.
  PaginationMeta parsePagination(dynamic json) {
    if (json == null) {
      return const PaginationMeta(
        totalItems: 0,
        countItems: 0,
        perPage: 10,
        totalPages: 1,
        currentPage: 1,
      );
    }

    final meta = json['data']?['meta'] ?? json['meta'];

    if (meta == null) {
      dev.log('PaginatedCubit: No pagination meta found in response');
      return const PaginationMeta(
        totalItems: 0,
        countItems: 0,
        perPage: 10,
        totalPages: 1,
        currentPage: 1,
      );
    }

    return PaginationMeta.fromJson(meta);
  }

  /// Initial fetch - loads first page
  /// [key] - Optional filter key (e.g., order type, stage, status)
  Future<void> fetchInitialData({String? key}) async {
    _currentPage = 1;
    _isLoadingMore = false;
    _filterKey = key;

    setLoading();
    final result = await fetchPageData(_currentPage, searchQuery: _filterKey);

    result.when(
      (success) {
        try {
          final items = parseItems(success);
          final meta = parsePagination(success);

          setSuccess(
            data: PaginatedData(items: items, meta: meta),
          );
        } catch (e, s) {
          dev.log('PaginatedCubit: Error parsing initial data',
              error: e, stackTrace: s);
          setError(
              errorMessage: 'Error parsing data: ${e.toString()}',
              showToast: true);
        }
      },
      (failure) {
        setError(errorMessage: failure.message, showToast: true);
      },
    );
  }

  /// Load more data (next page)
  /// Uses the current filter key set by fetchInitialData
  Future<void> loadMore() async {
    if (!canLoadMore) return;

    _isLoadingMore = true;
    _currentPage++;

    setLoadingMore();
    final result = await fetchPageData(_currentPage, searchQuery: _filterKey);

    result.when(
      (success) {
        try {
          final newItems = parseItems(success);
          final newMeta = parsePagination(success);
          final updatedData = state.data.addItems(newItems, newMeta);
          setSuccess(data: updatedData);
          _isLoadingMore = false;
        } catch (e, s) {
          dev.log('PaginatedCubit: Error parsing load more data',
              error: e, stackTrace: s);
          _currentPage--; // Revert page on error
          _isLoadingMore = false;
          setError(
              errorMessage: 'Error parsing more data: ${e.toString()}',
              showToast: true);
        }
      },
      (failure) {
        _currentPage--; // Revert page on error
        _isLoadingMore = false;
        setError(errorMessage: failure.message, showToast: true);
      },
    );
  }

  /// Refresh data (reload first page and replace all data)
  /// Maintains the current filter key
  Future<void> refresh() async {
    await fetchInitialData(key: _filterKey);
  }

  @override
  void reset() {
    _currentPage = 1;
    _isLoadingMore = false;
    _filterKey = null;
    emit(AsyncState.initial(data: PaginatedData.initial()));
  }
}
