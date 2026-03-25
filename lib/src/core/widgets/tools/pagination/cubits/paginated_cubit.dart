part of '../imports/pagination_imports.dart';

/// Abstract base cubit for paginated data
abstract class PaginatedCubit<T> extends AsyncCubit<PaginatedData<T>> {
  PaginatedCubit() : super(PaginatedData.initial());

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
  /// [key] - Optional filter key (e.g., order type, stage, status)
  Future<Result<Map<String, dynamic>, Failure>> fetchPageData(
    int page, {
    String? key,
  });

  /// Override this method to parse items from JSON
  List<T> parseItems(dynamic json);

  PaginationMeta parsePagination(dynamic json);

  /// Initial fetch - loads first page
  /// [key] - Optional filter key (e.g., order type, stage, status)
  Future<void> fetchInitialData({String? key}) async {
    _currentPage = 1;
    _isLoadingMore = false;
    _filterKey = key;

    setLoading();
    final result = await fetchPageData(_currentPage, key: _filterKey);

    result.when(
      (success) {
        final items = parseItems(success['data']);
        final meta = parsePagination(success['data']);

        setSuccess(
          data: PaginatedData(items: items, meta: meta),
        );
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
    final result = await fetchPageData(_currentPage, key: _filterKey);

    result.when(
      (success) {
        final newItems = parseItems(success['data']);
        final newMeta = parsePagination(success['data']);
        final updatedData = state.data.addItems(newItems, newMeta);
        setSuccess(data: updatedData);
        _isLoadingMore = false;
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
    super.reset();
  }
}
