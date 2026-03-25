# Quick Start Guide

## Step-by-Step Implementation

### Step 1: Import the package

```dart
import 'package:rite/src/core/widgets/pagination/pagination_exports.dart';
```

### Step 2: Create your cubit (example for videos)

```dart
import 'package:rite/src/core/widgets/pagination/pagination_exports.dart';
import 'package:multiple_result/multiple_result.dart';
import '../../error/failure.dart';
import '../../base_crud/code/domain/base_domain_imports.dart';

class VideosPaginatedCubit extends PaginatedCubit<VideoEntity> {
  VideosPaginatedCubit() : super();

  @override
  Future<Result<Map<String, dynamic>, Failure>> fetchPageData(int page) async {
    return await baseCrudUseCase.call(
      CrudBaseParams(
        api: '/api/videos?page=$page',
        httpRequestType: HttpRequestType.get,
        mapper: (json) => json, // Return the full response
      ),
    );
  }

  @override
  List<VideoEntity> parseItems(dynamic json) {
    // Parse your items from the 'data' array in API response
    return (json as List)
        .map((e) => VideoEntity.fromJson(e))
        .toList();
  }
}
```

### Step 3: Use in your screen

```dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rite/src/core/widgets/pagination/pagination_exports.dart';

class VideosScreen extends StatelessWidget {
  const VideosScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => VideosPaginatedCubit()..fetchInitialData(),
      child: Scaffold(
        appBar: AppBar(title: const Text('Videos')),
        body: PaginatedListWidget<VideosPaginatedCubit, VideoEntity>(
          config: const PaginatedListConfig(
            viewType: ListViewType.list,
            scrollDirection: Axis.vertical,
            padding: EdgeInsets.all(16),
            itemMargin: EdgeInsets.symmetric(vertical: 8),
          ),
          itemBuilder: (context, video, index) {
            return VideoCard(video: video);
          },
          skeletonBuilder: (context) {
            return ListView.builder(
              itemCount: 5,
              itemBuilder: (context, index) {
                return const VideoCardSkeleton();
              },
            );
          },
        ),
      ),
    );
  }
}
```

### Step 4: Create your item widget

```dart
class VideoCard extends StatelessWidget {
  final VideoEntity video;

  const VideoCard({super.key, required this.video});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Image.network(video.thumbnail, width: 80, fit: BoxFit.cover),
        title: Text(video.title),
        subtitle: Text(video.description),
        onTap: () {
          // Handle tap
        },
      ),
    );
  }
}

class VideoCardSkeleton extends StatelessWidget {
  const VideoCardSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Container(width: 80, height: 60, color: Colors.grey[300]),
        title: Container(height: 16, color: Colors.grey[300]),
        subtitle: Container(height: 12, color: Colors.grey[300]),
      ),
    );
  }
}
```

## Common Use Cases

### 1. Horizontal Scrolling List

```dart
SizedBox(
  height: 200,
  child: PaginatedListWidget<VideosPaginatedCubit, VideoEntity>(
    config: const PaginatedListConfig(
      scrollDirection: Axis.horizontal,
      padding: EdgeInsets.symmetric(horizontal: 16),
      itemMargin: EdgeInsets.symmetric(horizontal: 8),
    ),
    itemBuilder: (context, video, index) {
      return SizedBox(width: 250, child: VideoCard(video: video));
    },
  ),
)
```

### 2. Grid View

```dart
PaginatedListWidget<VideosPaginatedCubit, VideoEntity>(
  config: const PaginatedListConfig(
    viewType: ListViewType.grid,
    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 2,
      childAspectRatio: 16/9,
      crossAxisSpacing: 12,
      mainAxisSpacing: 12,
    ),
  ),
  itemBuilder: (context, video, index) {
    return VideoCard(video: video);
  },
)
```

### 3. Inside Nested ScrollView (No Scroll)

```dart
SingleChildScrollView(
  child: Column(
    children: [
      // Other widgets
      PaginatedListWidget<VideosPaginatedCubit, VideoEntity>(
        config: const PaginatedListConfig(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
        ),
        itemBuilder: (context, video, index) {
          return VideoCard(video: video);
        },
      ),
    ],
  ),
)
```

### 4. With Pull to Refresh

```dart
BlocProvider(
  create: (context) => VideosPaginatedCubit()..fetchInitialData(),
  child: Builder(
    builder: (context) {
      return RefreshIndicator(
        onRefresh: () => context.read<VideosPaginatedCubit>().refresh(),
        child: PaginatedListWidget<VideosPaginatedCubit, VideoEntity>(
          itemBuilder: (context, video, index) {
            return VideoCard(video: video);
          },
        ),
      );
    },
  ),
)
```

## API Response Format

Your API must return this structure:

```json
{
  "data": [
    {"id": 1, "title": "Video 1", ...},
    {"id": 2, "title": "Video 2", ...}
  ],
  "pagination": {
    "total_items": 100,
    "count_items": 10,
    "per_page": 30,
    "total_pages": 4,
    "current_page": 1,
    "next_page_url": "https://api.example.com/videos?page=2",
    "perv_page_url": ""
  }
}
```

## Done! 🎉

That's it! The widget will automatically:

- ✅ Show loading skeleton on first load
- ✅ Display your items using the itemBuilder
- ✅ Load more items when user scrolls to 80% of the list
- ✅ Show loading indicator while fetching more
- ✅ Handle errors and show error messages
- ✅ Show empty state when no items

## Troubleshooting

### Issue: Load more not working

- Check that your API returns `next_page_url` with a value
- Verify `loadMoreThreshold` is appropriate (default 0.8)

### Issue: Items not showing

- Check your `parseItems()` method is correctly parsing the data
- Verify your API response structure matches expected format

### Issue: Skeleton not showing

- Make sure to provide `skeletonBuilder` parameter
- Check that skeleton widget is properly constructed

For more examples, see `example_usage.dart`
