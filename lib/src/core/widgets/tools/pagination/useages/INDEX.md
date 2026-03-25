# Pagination Widget System - Documentation Index

Welcome to the Pagination Widget System! This folder contains everything you need to implement paginated lists in your Flutter app.

## 📚 Documentation Files

### 1. [QUICK_START.md](QUICK_START.md) - **START HERE!** ⭐

Quick step-by-step guide to get you up and running in 5 minutes.

- Simple copy-paste examples
- Common use cases
- Troubleshooting tips

### 2. [README.md](README.md) - Complete Documentation

Full documentation with all features and options.

- All configuration options
- Detailed examples
- API response structure
- Tips and best practices

### 3. [ARCHITECTURE.md](ARCHITECTURE.md) - System Design

Understand how everything works together.

- Architecture diagrams
- Data flow
- State management
- Extension points

### 4. [example_usage.dart](example_usage.dart) - Live Examples

Complete working code examples you can copy and modify.

- Vertical lists
- Horizontal lists
- Grid views
- Custom configurations

## 🚀 Quick Links

**I want to...**

- ✅ Get started quickly → [QUICK_START.md](QUICK_START.md)
- ✅ See all options → [README.md](README.md#configuration-options)
- ✅ See code examples → [example_usage.dart](example_usage.dart)
- ✅ Understand the architecture → [ARCHITECTURE.md](ARCHITECTURE.md)
- ✅ Import the package → Use: `import 'pagination_exports.dart';`

## 📦 What's Inside

### Core Files (Use These)

1. **paginated_cubit.dart** - Base cubit class to extend
2. **paginated_list_widget.dart** - Main widget to use in UI
3. **paginated_list_config.dart** - Configuration options
4. **pagination_exports.dart** - Single import file ⭐

### Supporting Files

5. **pagination_meta.dart** - API metadata parser
6. **paginated_data.dart** - Data wrapper

## 🎯 Quick Example

```dart
// 1. Import
import 'pagination_exports.dart';

// 2. Create Cubit
class ProductsCubit extends PaginatedCubit<ProductEntity> {
  @override
  Future<Result<Map, Failure>> fetchPageData(int page) async {
    return await baseCrudUseCase.call(
      CrudBaseParams(
        api: '/products?page=$page',
        httpRequestType: HttpRequestType.get,
        mapper: (json) => json,
      ),
    );
  }

  @override
  List<ProductEntity> parseItems(json) {
    return (json as List).map((e) => ProductEntity.fromJson(e)).toList();
  }
}

// 3. Use in UI
BlocProvider(
  create: (context) => ProductsCubit()..fetchInitialData(),
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

## ✨ Features

✅ List View & Grid View support
✅ Horizontal & Vertical scrolling
✅ Automatic pagination on scroll
✅ Custom scroll physics
✅ Separated lists with dividers
✅ Skeleton loading states
✅ Error handling
✅ Pull to refresh support
✅ Custom padding & margins
✅ Load more indicators
✅ Empty state widgets

## 🔧 Configuration Options

| Feature          | Config Property                             |
| ---------------- | ------------------------------------------- |
| View Type        | `viewType: ListViewType.list/grid`          |
| Scroll Direction | `scrollDirection: Axis.vertical/horizontal` |
| Stop Scroll      | `physics: NeverScrollableScrollPhysics()`   |
| Add Padding      | `padding: EdgeInsets.all(16)`               |
| Item Margins     | `itemMargin: EdgeInsets.symmetric(...)`     |
| Add Separators   | `useSeparator: true`                        |
| Grid Layout      | `gridDelegate: SliverGridDelegate...`       |

## 📋 Required API Response Format

```json
{
  "data": [
    /* your items */
  ],
  "pagination": {
    "total_items": 100,
    "count_items": 10,
    "per_page": 30,
    "total_pages": 4,
    "current_page": 1,
    "next_page_url": "...",
    "perv_page_url": ""
  }
}
```

## 🆘 Need Help?

1. **Quick Start** → [QUICK_START.md](QUICK_START.md)
2. **Full Docs** → [README.md](README.md)
3. **Examples** → [example_usage.dart](example_usage.dart)
4. **How it Works** → [ARCHITECTURE.md](ARCHITECTURE.md)

---

**Created for:** Flutter apps using AsyncBlocBuilder pattern
**Location:** `/lib/src/core/widgets/pagination/`
**Import:** `import 'pagination_exports.dart';`
