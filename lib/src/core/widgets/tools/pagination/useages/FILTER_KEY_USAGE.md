# Using Filter Key in PaginatedCubit

The PaginatedCubit now supports an optional `key` parameter that you can use to filter paginated data (e.g., by order type, status, stage, etc.).

## How It Works

1. **Add key parameter to fetchPageData override**
2. **Pass key when calling fetchInitialData**
3. **The key persists across pagination and refresh**

## Example Usage

### Step 1: Update Your Cubit

```dart
class OrdersCubit extends PaginatedCubit<OrderEntity> {
  @override
  Future<Result<Map<String, dynamic>, Failure>> fetchPageData(
    int page, {
    String? key,
  }) async {
    // Build query parameters with pagination and optional filter key
    final queryParams = {
      ...?ConstantManager.paginateJson(page),
      if (key != null) 'type': key, // Add key to URL if provided
      // Or use different parameter names:
      // if (key != null) 'status': key,
      // if (key != null) 'stage': key,
    };

    return await baseCrudUseCase.call(
      CrudBaseParams(
        api: '${ApiConstants.myOrders}',
        httpRequestType: HttpRequestType.get,
        queryParameters: queryParams,
        mapper: (json) => json,
      ),
    );
  }

  @override
  List<OrderEntity> parseItems(json) =>
      (json['data'] as List).map((e) => OrderEntity.fromJson(e)).toList();
}
```

### Step 2: Use in Your UI

```dart
// Without filter key (get all data)
ordersCubit.fetchInitialData();

// With filter key (e.g., filter by order type)
ordersCubit.fetchInitialData(key: 'pending');
ordersCubit.fetchInitialData(key: 'completed');
ordersCubit.fetchInitialData(key: 'cancelled');

// When user changes filter
onTabChanged(String orderType) {
  ordersCubit.fetchInitialData(key: orderType);
}
```

### Step 3: Pagination & Refresh

```dart
// Load more pages - automatically uses the same filter key
ordersCubit.loadMore();

// Refresh - automatically uses the same filter key
ordersCubit.refresh();

// Access current filter key
String? currentFilter = ordersCubit.filterKey;
```

## Complete Example with Tabs

```dart
class OrdersScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ordersCubit = context.read<OrdersCubit>();

    return DefaultTabController(
      length: 3,
      child: Column(
        children: [
          TabBar(
            onTap: (index) {
              // Change filter based on selected tab
              final orderType = ['pending', 'completed', 'cancelled'][index];
              ordersCubit.fetchInitialData(key: orderType);
            },
            tabs: [
              Tab(text: 'Pending'),
              Tab(text: 'Completed'),
              Tab(text: 'Cancelled'),
            ],
          ),
          Expanded(
            child: PaginatedListWidget<OrderEntity>(
              cubit: ordersCubit,
              itemBuilder: (context, order) => OrderCard(order: order),
            ),
          ),
        ],
      ),
    );
  }
}
```

## API URL Examples

When you use the filter key, it will be added to your API URL:

- Without key: `GET /api/my-orders?page=1&limit=10`
- With key: `GET /api/my-orders?page=1&limit=10&type=pending`

You can customize the parameter name in your `fetchPageData` implementation:

- `'type': key` → `?type=pending`
- `'status': key` → `?status=pending`
- `'stage': key` → `?stage=pending`
