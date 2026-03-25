# Paginated List Widget

A customizable Flutter widget for handling paginated lists with automatic load more functionality using `AsyncBlocBuilder`.

## Features

- ✅ **List View Types**: Support for both ListView and GridView
- ✅ **Scroll Directions**: Horizontal and Vertical scrolling
- ✅ **Custom Physics**: Control scroll behavior (bouncing, never scrollable, etc.)
- ✅ **Separated Lists**: Built-in separator support for list views
- ✅ **Custom Styling**: Configurable padding and margins
- ✅ **Automatic Pagination**: Auto-loads more items on scroll
- ✅ **AsyncBlocBuilder**: Integrated with your existing async state management
- ✅ **Loading States**: Skeleton loading and load more indicators
- ✅ **Pull to Refresh**: Easy integration with RefreshIndicator
- ✅ **Empty States**: Custom empty state widgets

## Installation

All files are located in: `/lib/src/core/widgets/pagination/`

## Quick Start

### 1. Create Your Entity Model

```dart
class ProductEntity {
  final int id;
  final String name;
  final String image;
  final double price;

  ProductEntity({
    required this.id,
    required this.name,
    required this.image,
    required this.price,
  });

  factory ProductEntity.fromJson(Map<String, dynamic> json) {
    return ProductEntity(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      image: json['image'] ?? '',
      price: (json['price'] ?? 0).toDouble(),
    );
  }
}
```

### 2. Create Your Paginated Cubit

```dart
class ProductsCubit extends PaginatedCubit<ProductEntity> {
  ProductsCubit() : super();

  @override
  Future<Result<Map<String, dynamic>, Failure>> fetchPageData(int page) async {
    return await baseCrudUseCase.call(
      CrudBaseParams(
        api: '/api/products?page=$page',
        httpRequestType: HttpRequestType.get,
        mapper: (json) => json,
      ),
    );
  }

  @override
  List<ProductEntity> parseItems(dynamic json) {
    return (json as List).map((e) => ProductEntity.fromJson(e)).toList();
  }
}
```

### 3. Use the Widget

```dart
BlocProvider(
  create: (context) => ProductsCubit()..fetchInitialData(),
  child: PaginatedListWidget<ProductsCubit, ProductEntity>(
    config: const PaginatedListConfig(
      viewType: ListViewType.list,
      scrollDirection: Axis.vertical,
      padding: EdgeInsets.all(16),
    ),
    itemBuilder: (context, product, index) {
      return ProductCard(product: product);
    },
  ),
)
```

## API Response Structure

Your API should return data in this format:

```json
{
  "data": [
    { "id": 1, "name": "Product 1", "image": "url", "price": 99.99 },
    { "id": 2, "name": "Product 2", "image": "url", "price": 149.99 }
  ],
  "pagination": {
    "total_items": 100,
    "count_items": 10,
    "per_page": 30,
    "total_pages": 4,
    "current_page": 1,
    "next_page_url": "https://api.example.com/products?page=2",
    "perv_page_url": ""
  }
}
```

## Configuration Options

### PaginatedListConfig

| Parameter         | Type                  | Default             | Description                |
| ----------------- | --------------------- | ------------------- | -------------------------- |
| `viewType`        | `ListViewType`        | `ListViewType.list` | List or Grid view          |
| `scrollDirection` | `Axis`                | `Axis.vertical`     | Scroll direction           |
| `physics`         | `ScrollPhysics?`      | `null`              | Scroll physics             |
| `padding`         | `EdgeInsetsGeometry?` | `null`              | List padding               |
| `itemMargin`      | `EdgeInsetsGeometry?` | `null`              | Individual item margin     |
| `useSeparator`    | `bool`                | `false`             | Use separator in list view |
| `separator`       | `Widget?`             | `Divider()`         | Custom separator widget    |
| `gridDelegate`    | `SliverGridDelegate?` | 2 columns           | Grid configuration         |
| `shrinkWrap`      | `bool`                | `false`             | Shrink wrap the list       |
| `reverse`         | `bool`                | `false`             | Reverse list order         |
| `primary`         | `bool?`               | `null`              | Primary scroll             |
| `controller`      | `ScrollController?`   | `null`              | Custom scroll controller   |

## Usage Examples

### Vertical List with Separator

```dart
PaginatedListWidget<ProductsCubit, ProductEntity>(
  config: const PaginatedListConfig(
    viewType: ListViewType.list,
    scrollDirection: Axis.vertical,
    padding: EdgeInsets.all(16),
    useSeparator: true,
    separator: Divider(height: 1),
  ),
  itemBuilder: (context, product, index) {
    return ProductCard(product: product);
  },
)
```

### Horizontal List

```dart
SizedBox(
  height: 200,
  child: PaginatedListWidget<ProductsCubit, ProductEntity>(
    config: const PaginatedListConfig(
      viewType: ListViewType.list,
      scrollDirection: Axis.horizontal,
      padding: EdgeInsets.symmetric(horizontal: 16),
      itemMargin: EdgeInsets.symmetric(horizontal: 8),
    ),
    itemBuilder: (context, product, index) {
      return SizedBox(
        width: 150,
        child: ProductCard(product: product),
      );
    },
  ),
)
```

### Grid View

```dart
PaginatedListWidget<ProductsCubit, ProductEntity>(
  config: const PaginatedListConfig(
    viewType: ListViewType.grid,
    padding: EdgeInsets.all(16),
    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 2,
      childAspectRatio: 0.75,
      crossAxisSpacing: 12,
      mainAxisSpacing: 12,
    ),
  ),
  itemBuilder: (context, product, index) {
    return ProductCard(product: product);
  },
)
```

### With Custom Physics (Stop Scroll)

```dart
PaginatedListWidget<ProductsCubit, ProductEntity>(
  config: const PaginatedListConfig(
    physics: NeverScrollableScrollPhysics(),
    shrinkWrap: true,
  ),
  itemBuilder: (context, product, index) {
    return ProductCard(product: product);
  },
)
```

### With Pull to Refresh

```dart
RefreshIndicator(
  onRefresh: () async {
    await context.read<ProductsCubit>().refresh();
  },
  child: PaginatedListWidget<ProductsCubit, ProductEntity>(
    config: const PaginatedListConfig(
      padding: EdgeInsets.all(16),
    ),
    itemBuilder: (context, product, index) {
      return ProductCard(product: product);
    },
  ),
)
```

### With Custom Scroll Controller

```dart
class _MyScreenState extends State<MyScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return PaginatedListWidget<ProductsCubit, ProductEntity>(
      config: PaginatedListConfig(
        controller: _scrollController,
      ),
      itemBuilder: (context, product, index) {
        return ProductCard(product: product);
      },
    );
  }
}
```

## Cubit Methods

Your cubit (extending `PaginatedCubit`) has these methods:

- `fetchInitialData()` - Load the first page
- `loadMore()` - Load the next page (called automatically on scroll)
- `refresh()` - Reload from the first page
- `reset()` - Reset to initial state

## Widget Parameters

### PaginatedListWidget

| Parameter           | Required | Description                              |
| ------------------- | -------- | ---------------------------------------- |
| `itemBuilder`       | Yes      | Builder for each item                    |
| `config`            | No       | List configuration                       |
| `skeletonBuilder`   | No       | Loading skeleton widget                  |
| `errorBuilder`      | No       | Error state widget                       |
| `emptyWidget`       | No       | Empty state widget                       |
| `loadMoreIndicator` | No       | Custom load more indicator               |
| `loadMoreThreshold` | No       | Scroll threshold for load more (0.0-1.0) |

## Complete Example

See [example_usage.dart](example_usage.dart) for complete working examples including:

- ✅ Vertical list view
- ✅ Horizontal list view with separator
- ✅ Grid view
- ✅ Custom scroll controller
- ✅ Stop scroll (NeverScrollableScrollPhysics)
- ✅ Pull to refresh

## Files Structure

```
pagination/
├── paginated_cubit.dart          # Base cubit for pagination
├── paginated_data.dart            # Data wrapper with items and meta
├── paginated_list_config.dart     # Configuration class
├── paginated_list_widget.dart     # Main widget
├── pagination_meta.dart           # Pagination metadata
├── pagination_exports.dart        # Export file
├── example_usage.dart             # Complete examples
└── README.md                      # This file
```

## Tips

1. **Load More Threshold**: Adjust `loadMoreThreshold` (default 0.8) to control when to load more items
2. **Skeleton Loading**: Always provide a `skeletonBuilder` for better UX
3. **Empty State**: Customize the `emptyWidget` to match your app design
4. **Error Handling**: The cubit automatically handles errors and shows toast messages
5. **Memory Management**: The widget handles scroll controller disposal automatically

## License

This is part of your project's shared widgets.
