// // ignore_for_file: unused_local_variable

// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:multiple_result/multiple_result.dart';
// import '../../base_crud/code/domain/base_domain_imports.dart';
// import '../../error/failure.dart';
// import 'paginated_cubit.dart';
// import 'paginated_list_config.dart';
// import 'paginated_list_widget.dart';

// // ============================================================================
// // EXAMPLE MODELS
// // ============================================================================

// /// Example Product Entity
// // class ProductEntity {
// //   final int id;
// //   final String name;
// //   final String image;
// //   final double price;

// //   ProductEntity({
// //     required this.id,
// //     required this.name,
// //     required this.image,
// //     required this.price,
// //   });

// //   factory ProductEntity.fromJson(Map<String, dynamic> json) {
// //     return ProductEntity(
// //       id: json['id'] ?? 0,
// //       name: json['name'] ?? '',
// //       image: json['image'] ?? '',
// //       price: (json['price'] ?? 0).toDouble(),
// //     );
// //   }
// // }

// // ============================================================================
// // EXAMPLE CUBIT
// // ============================================================================

// /// Example Products Cubit with pagination
// // class ProductsCubit extends PaginatedCubit<ProductEntity> {
// //   ProductsCubit() : super();

// //   @override
// //   Future<Result<Map<String, dynamic>, Failure>> fetchPageData(int page) async {
// //     // Replace with your actual API call
// //     return await baseCrudUseCase.call(
// //       CrudBaseParams(
// //         api: '/api/products?page=$page',
// //         httpRequestType: HttpRequestType.get,
// //         mapper: (json) => json, // Return raw JSON
// //       ),
// //     );
// //   }

// //   @override
// //   List<ProductEntity> parseItems(dynamic json) {
// //     // Parse the items from the API response
// //     return (json as List).map((e) => ProductEntity.fromJson(e)).toList();
// //   }
// // }

// // ============================================================================
// // EXAMPLE USAGE - VERTICAL LIST VIEW
// // ============================================================================

// // class ProductsListScreen extends StatelessWidget {
// //   const ProductsListScreen({super.key});

// //   @override
// //   Widget build(BuildContext context) {
// //     return BlocProvider(
// //       create: (context) => ProductsCubit()..fetchInitialData(),
// //       child: Scaffold(
// //         appBar: AppBar(title: const Text('Products')),
// //         body: PaginatedListWidget<ProductsCubit, ProductEntity>(
// //           config: const PaginatedListConfig(
// //             viewType: ListViewType.list,
// //             scrollDirection: Axis.vertical,
// //             padding: EdgeInsets.all(16),
// //             itemMargin: EdgeInsets.symmetric(vertical: 8),
// //             shrinkWrap: false,
// //           ),
// //           itemBuilder: (context, product, index) {
// //             return ProductCard(product: product);
// //           },
// //           // skeletonBuilder now automatically creates a list/grid matching the config
// //           // Just provide a single skeleton item widget with static/initial data
// //           skeletonBuilder: (context) {
// //             return ProductCard(product: ProductEntity.initial());
// //           },
// //           skeletonItemCount: 5, // Number of skeleton items to show (default: 6)
// //           emptyWidget: const Center(
// //             child: Text('No products found'),
// //           ),
// //         ),
// //       ),
// //     );
// //   }
// // }

// // ============================================================================
// // EXAMPLE USAGE - HORIZONTAL LIST VIEW WITH SEPARATOR
// // ============================================================================

// class HorizontalProductsWidget extends StatelessWidget {
//   const HorizontalProductsWidget({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (context) => ProductsCubit()..fetchInitialData(),
//       child: SizedBox(
//         height: 200,
//         child: PaginatedListWidget<ProductsCubit, ProductEntity>(
//           config: PaginatedListConfig(
//             viewType: ListViewType.list,
//             scrollDirection: Axis.horizontal,
//             padding: const EdgeInsets.symmetric(horizontal: 16),
//             itemMargin: const EdgeInsets.symmetric(horizontal: 8),
//             useSeparator: true,
//             separator: const SizedBox(width: 16),
//             physics: const BouncingScrollPhysics(),
//           ),
//           itemBuilder: (context, product, index) {
//             return SizedBox(
//               width: 150,
//               child: ProductCard(product: product),
//             );
//           },
//         ),
//       ),
//     );
//   }
// }

// // ============================================================================
// // EXAMPLE USAGE - GRID VIEW
// // ============================================================================

// class ProductsGridScreen extends StatelessWidget {
//   const ProductsGridScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (context) => ProductsCubit()..fetchInitialData(),
//       child: Scaffold(
//         appBar: AppBar(title: const Text('Products Grid')),
//         body: PaginatedListWidget<ProductsCubit, ProductEntity>(
//           config: const PaginatedListConfig(
//             viewType: ListViewType.grid,
//             scrollDirection: Axis.vertical,
//             padding: EdgeInsets.all(16),
//             itemMargin: EdgeInsets.all(4),
//             gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//               crossAxisCount: 2,
//               childAspectRatio: 0.75,
//               crossAxisSpacing: 12,
//               mainAxisSpacing: 12,
//             ),
//           ),
//           itemBuilder: (context, product, index) {
//             return ProductCard(product: product);
//           },
//           // skeletonBuilder automatically creates grid layout matching config
//           skeletonBuilder: (context) {
//             return ProductCard(product: ProductEntity.initial());
//           },
//           skeletonItemCount: 8, // Show 8 skeleton items in grid
//           loadMoreThreshold: 0.7, // Load more at 70% scroll
//         ),
//       ),
//     );
//   }
// }

// // ============================================================================
// // EXAMPLE USAGE - WITH CUSTOM SCROLL CONTROLLER
// // ============================================================================

// class ProductsWithCustomScrollScreen extends StatefulWidget {
//   const ProductsWithCustomScrollScreen({super.key});

//   @override
//   State<ProductsWithCustomScrollScreen> createState() =>
//       _ProductsWithCustomScrollScreenState();
// }

// class _ProductsWithCustomScrollScreenState
//     extends State<ProductsWithCustomScrollScreen> {
//   final ScrollController _scrollController = ScrollController();
//   bool _showBackToTop = false;

//   @override
//   void initState() {
//     super.initState();
//     _scrollController.addListener(_onScroll);
//   }

//   void _onScroll() {
//     if (_scrollController.offset > 500 && !_showBackToTop) {
//       setState(() => _showBackToTop = true);
//     } else if (_scrollController.offset <= 500 && _showBackToTop) {
//       setState(() => _showBackToTop = false);
//     }
//   }

//   @override
//   void dispose() {
//     _scrollController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (context) => ProductsCubit()..fetchInitialData(),
//       child: Scaffold(
//         appBar: AppBar(title: const Text('Products with Scroll')),
//         body: PaginatedListWidget<ProductsCubit, ProductEntity>(
//           config: PaginatedListConfig(
//             viewType: ListViewType.list,
//             controller: _scrollController,
//             padding: const EdgeInsets.all(16),
//           ),
//           itemBuilder: (context, product, index) {
//             return ProductCard(product: product);
//           },
//         ),
//         floatingActionButton: _showBackToTop
//             ? FloatingActionButton(
//                 onPressed: () {
//                   _scrollController.animateTo(
//                     0,
//                     duration: const Duration(milliseconds: 500),
//                     curve: Curves.easeInOut,
//                   );
//                 },
//                 child: const Icon(Icons.arrow_upward),
//               )
//             : null,
//       ),
//     );
//   }
// }

// // ============================================================================
// // EXAMPLE USAGE - WITH STOP SCROLL (NeverScrollableScrollPhysics)
// // ============================================================================

// class ProductsNoScrollScreen extends StatelessWidget {
//   const ProductsNoScrollScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (context) => ProductsCubit()..fetchInitialData(),
//       child: Scaffold(
//         appBar: AppBar(title: const Text('Products - No Scroll')),
//         body: SingleChildScrollView(
//           child: Column(
//             children: [
//               const Padding(
//                 padding: EdgeInsets.all(16),
//                 child: Text('Other content here'),
//               ),
//               PaginatedListWidget<ProductsCubit, ProductEntity>(
//                 config: const PaginatedListConfig(
//                   viewType: ListViewType.list,
//                   physics: NeverScrollableScrollPhysics(),
//                   shrinkWrap: true,
//                   padding: EdgeInsets.all(16),
//                 ),
//                 itemBuilder: (context, product, index) {
//                   return ProductCard(product: product);
//                 },
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// // ============================================================================
// // EXAMPLE USAGE - WITH PULL TO REFRESH
// // ============================================================================

// class ProductsWithRefreshScreen extends StatelessWidget {
//   const ProductsWithRefreshScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (context) => ProductsCubit()..fetchInitialData(),
//       child: Scaffold(
//         appBar: AppBar(title: const Text('Products - Pull to Refresh')),
//         body: Builder(
//           builder: (context) {
//             return RefreshIndicator(
//               onRefresh: () async {
//                 await context.read<ProductsCubit>().refresh();
//               },
//               child: PaginatedListWidget<ProductsCubit, ProductEntity>(
//                 config: const PaginatedListConfig(
//                   viewType: ListViewType.list,
//                   padding: EdgeInsets.all(16),
//                 ),
//                 itemBuilder: (context, product, index) {
//                   return ProductCard(product: product);
//                 },
//               ),
//             );
//           },
//         ),
//       ),
//     );
//   }
// }

// // ============================================================================
// // EXAMPLE UI WIDGETS
// // ============================================================================

// class ProductCard extends StatelessWidget {
//   final ProductEntity product;

//   const ProductCard({super.key, required this.product});

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       child: ListTile(
//         leading: Image.network(
//           product.image,
//           width: 50,
//           height: 50,
//           fit: BoxFit.cover,
//           errorBuilder: (context, error, stackTrace) => const Icon(Icons.image),
//         ),
//         title: Text(product.name),
//         subtitle: Text('\$${product.price.toStringAsFixed(2)}'),
//         trailing: const Icon(Icons.arrow_forward_ios),
//       ),
//     );
//   }
// }

// class ProductCardSkeleton extends StatelessWidget {
//   const ProductCardSkeleton({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       child: ListTile(
//         leading: Container(
//           width: 50,
//           height: 50,
//           color: Colors.grey[300],
//         ),
//         title: Container(
//           height: 16,
//           color: Colors.grey[300],
//         ),
//         subtitle: Container(
//           height: 12,
//           color: Colors.grey[300],
//         ),
//       ),
//     );
//   }
// }

// // ============================================================================
// // HOW TO USE IN YOUR CODE:
// // ============================================================================

// /*
// 1. Create your entity model (e.g., ProductEntity)

// 2. Create a cubit that extends PaginatedCubit:
//    - Override fetchPageData() to call your API
//    - Override parseItems() to parse items from response

// 3. Use PaginatedListWidget in your UI:
//    - Wrap with BlocProvider
//    - Configure using PaginatedListConfig
//    - Provide itemBuilder

// EXAMPLE API RESPONSE STRUCTURE:
// {
//   "data": [
//     {"id": 1, "name": "Product 1", ...},
//     {"id": 2, "name": "Product 2", ...}
//   ],
//   "pagination": {
//     "total_items": 100,
//     "count_items": 10,
//     "per_page": 30,
//     "total_pages": 4,
//     "current_page": 1,
//     "next_page_url": "https://api.example.com/products?page=2",
//     "perv_page_url": ""
//   }
// }

// CONFIGURATION OPTIONS:
// - viewType: ListViewType.list or ListViewType.grid
// - scrollDirection: Axis.vertical or Axis.horizontal
// - physics: NeverScrollableScrollPhysics(), BouncingScrollPhysics(), etc.
// - padding: EdgeInsets for list padding
// - itemMargin: EdgeInsets for each item
// - useSeparator: true/false (only for list view)
// - separator: Custom separator widget
// - gridDelegate: SliverGridDelegate for grid view
// - shrinkWrap: true/false
// - controller: Custom ScrollController

// CUBIT METHODS:
// - fetchInitialData() - Load first page
// - loadMore() - Load next page (automatic on scroll)
// - refresh() - Reload from first page
// - reset() - Reset to initial state
//
// SKELETON BUILDER:
// The skeletonBuilder now automatically creates a list/grid view matching your config.
// - For grid views: Creates a GridView with your gridDelegate settings
// - For list views: Creates a ListView with separator if configured
// - Just provide a single widget builder that returns one skeleton item
// - The widget will be repeated according to skeletonItemCount (default: 6)
// - All skeleton items are wrapped with Skeletonizer package automatically
//
// Example:
// skeletonBuilder: (context) => ProductCard(product: ProductEntity.initial()),
// skeletonItemCount: 8, // Optional, defaults to 6
// */
