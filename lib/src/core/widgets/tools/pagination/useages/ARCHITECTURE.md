# Pagination System Architecture

## System Overview

```
┌─────────────────────────────────────────────────────────────┐
│                    Your Screen Widget                         │
│  (Provides BlocProvider and calls fetchInitialData())        │
└──────────────────────┬──────────────────────────────────────┘
                       │
                       ▼
┌─────────────────────────────────────────────────────────────┐
│              PaginatedListWidget<C, T>                        │
│  - Manages ScrollController                                  │
│  - Triggers load more on scroll threshold                    │
│  - Delegates to AsyncBlocBuilder                             │
└──────────────────────┬──────────────────────────────────────┘
                       │
                       ▼
┌─────────────────────────────────────────────────────────────┐
│              AsyncBlocBuilder<C, PaginatedData<T>>           │
│  - Shows skeleton on loading                                 │
│  - Shows error on error                                      │
│  - Shows items on success                                    │
└──────────────────────┬──────────────────────────────────────┘
                       │
                       ▼
┌─────────────────────────────────────────────────────────────┐
│              Your Custom Cubit extends PaginatedCubit<T>     │
│  - Implements fetchPageData(page)                            │
│  - Implements parseItems(json)                               │
└──────────────────────┬──────────────────────────────────────┘
                       │
                       ▼
┌─────────────────────────────────────────────────────────────┐
│              PaginatedCubit<T> (Base Class)                   │
│  - Manages current page number                               │
│  - Handles load more logic                                   │
│  - Emits AsyncState<PaginatedData<T>>                        │
└──────────────────────┬──────────────────────────────────────┘
                       │
                       ▼
┌─────────────────────────────────────────────────────────────┐
│              AsyncCubit<PaginatedData<T>>                     │
│  - Provides loading/success/error states                     │
│  - Handles async operations                                  │
└──────────────────────┬──────────────────────────────────────┘
                       │
                       ▼
┌─────────────────────────────────────────────────────────────┐
│                     API Call                                  │
│  Returns: { data: [...], pagination: {...} }                │
└─────────────────────────────────────────────────────────────┘
```

## Data Flow

### Initial Load

```
User Opens Screen
        │
        ▼
BlocProvider creates cubit
        │
        ▼
fetchInitialData() called
        │
        ▼
setLoading() → AsyncState(status: loading)
        │
        ▼
AsyncBlocBuilder shows skeleton
        │
        ▼
fetchPageData(1) → API call to page 1
        │
        ▼
parseItems(json) → Convert to List<T>
        │
        ▼
PaginationMeta.fromJson(pagination) → Extract metadata
        │
        ▼
setSuccess(PaginatedData(items, meta))
        │
        ▼
AsyncBlocBuilder shows items using itemBuilder
```

### Load More

```
User scrolls to 80% of list
        │
        ▼
ScrollController detects threshold
        │
        ▼
Check canLoadMore (hasNextPage && !isLoading)
        │
        ▼
loadMore() called
        │
        ▼
currentPage++ (e.g., 1 → 2)
        │
        ▼
setLoadingMore() → AsyncState(status: loadingMore)
        │
        ▼
Shows load more indicator at bottom
        │
        ▼
fetchPageData(2) → API call to page 2
        │
        ▼
parseItems(json) → Convert to List<T>
        │
        ▼
addItems(newItems, newMeta) → Append to existing items
        │
        ▼
setSuccess(PaginatedData(oldItems + newItems, newMeta))
        │
        ▼
AsyncBlocBuilder re-renders with all items
```

### Refresh

```
User pulls to refresh
        │
        ▼
refresh() called
        │
        ▼
Reset currentPage to 1
        │
        ▼
fetchInitialData()
        │
        ▼
Replace all items with new data
```

## Class Relationships

```
PaginatedListWidget
    │
    ├── Uses: ScrollController
    │
    ├── Contains: AsyncBlocBuilder
    │
    ├── Uses: PaginatedListConfig
    │       ├── viewType (list/grid)
    │       ├── scrollDirection (horizontal/vertical)
    │       ├── physics
    │       ├── padding
    │       ├── itemMargin
    │       ├── useSeparator
    │       └── gridDelegate
    │
    └── Reads from: PaginatedCubit<T>
            ├── extends: AsyncCubit<PaginatedData<T>>
            │       ├── BaseStatus (initial/loading/loadingMore/success/error)
            │       └── PaginatedData<T>
            │               ├── items: List<T>
            │               └── meta: PaginationMeta
            │                       ├── totalItems
            │                       ├── currentPage
            │                       ├── totalPages
            │                       ├── hasNextPage
            │                       └── nextPageUrl
            │
            └── Methods:
                    ├── fetchInitialData()
                    ├── loadMore()
                    ├── refresh()
                    └── reset()
```

## State Management

```
AsyncState<PaginatedData<T>>
│
├── status: BaseStatus
│   ├── initial    → Show nothing or skeleton
│   ├── loading    → Show skeleton (first load)
│   ├── loadingMore → Show items + loading indicator
│   ├── success    → Show items
│   └── error      → Show error view
│
├── data: PaginatedData<T>
│   ├── items: List<T>      → Your actual items
│   └── meta: PaginationMeta → Pagination info
│
└── errorMessage: String?
```

## Configuration Flow

```
PaginatedListConfig
│
├── viewType ─────────┐
│                     │
├── scrollDirection ──┼──→ Determines which builder to use:
│                     │    ├── ListView.builder
│                     │    ├── ListView.separated
│                     └────└── GridView.builder
│
├── physics ──────────────→ Passed to list/grid
│
├── padding ──────────────→ Passed to list/grid
│
├── itemMargin ───────────→ Wrapped around each item
│
├── useSeparator ─────────→ Chooses ListView.separated
│   └── separator ────────→ Custom divider widget
│
└── gridDelegate ─────────→ Passed to GridView
```

## File Structure

```
pagination/
│
├── Core Models
│   ├── pagination_meta.dart      → API pagination metadata
│   └── paginated_data.dart       → Wrapper for items + meta
│
├── Configuration
│   └── paginated_list_config.dart → UI configuration
│
├── State Management
│   └── paginated_cubit.dart      → Base cubit with pagination logic
│
├── UI Widget
│   └── paginated_list_widget.dart → Main widget
│
├── Exports
│   └── pagination_exports.dart   → Single import file
│
└── Documentation
    ├── README.md                  → Full documentation
    ├── QUICK_START.md             → Quick start guide
    ├── ARCHITECTURE.md            → This file
    └── example_usage.dart         → Complete examples
```

## Extension Points

### 1. Custom Cubit
```dart
class MyCubit extends PaginatedCubit<MyEntity> {
  @override
  Future<Result<Map<String, dynamic>, Failure>> fetchPageData(int page) {
    // Your API call
  }

  @override
  List<MyEntity> parseItems(dynamic json) {
    // Your parsing logic
  }

  // Add custom methods
  void filterBy(String query) { }
  void sortBy(SortOption option) { }
}
```

### 2. Custom Configuration
```dart
const myConfig = PaginatedListConfig(
  viewType: ListViewType.grid,
  gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
    maxCrossAxisExtent: 200,
    childAspectRatio: 3 / 2,
  ),
  physics: BouncingScrollPhysics(),
);
```

### 3. Custom UI
```dart
PaginatedListWidget<MyCubit, MyEntity>(
  itemBuilder: (context, item, index) {
    return MyCustomCard(item);
  },
  skeletonBuilder: (context) {
    return MyCustomSkeleton();
  },
  errorBuilder: (context, error) {
    return MyCustomError(error);
  },
  emptyWidget: MyCustomEmpty(),
  loadMoreIndicator: MyCustomLoader(),
)
```

## Performance Considerations

1. **Memory**: Old items stay in memory. Consider implementing a max items limit if needed.
2. **Scroll**: Use `shrinkWrap: false` when possible for better performance.
3. **Physics**: `AlwaysScrollableScrollPhysics()` works better with RefreshIndicator.
4. **Load Threshold**: Adjust `loadMoreThreshold` based on your item size and API speed.
5. **Skeleton**: Keep skeleton widgets simple for faster initial render.

## Best Practices

1. ✅ Always provide a `skeletonBuilder` for better UX
2. ✅ Use `const` constructors where possible
3. ✅ Implement proper error handling in your cubit
4. ✅ Test with slow network to verify loading states
5. ✅ Provide meaningful empty states
6. ✅ Handle edge cases (no internet, server errors)
7. ✅ Use proper aspect ratios for grid items
8. ✅ Clean up custom ScrollControllers in dispose()
