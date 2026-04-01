import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mazaya/src/config/res/config_imports.dart';
import 'package:mazaya/src/core/widgets/scaffolds/default_scaffold.dart';
import 'package:mazaya/src/core/widgets/scaffolds/header_config.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewScreen extends StatefulWidget {
  final String url;
  final String title;

  const WebViewScreen({super.key, required this.url, required this.title});

  @override
  State<WebViewScreen> createState() => _WebViewScreenState();
}

class _WebViewScreenState extends State<WebViewScreen> {
  late final WebViewController _controller;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (String url) {
            setState(() {
              _isLoading = true;
            });
          },
          onPageFinished: (String url) {
            setState(() {
              _isLoading = false;
            });
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.url));
  }

  @override
  Widget build(BuildContext context) {
    return DefaultScaffold(
      header: HeaderConfig(title: widget.title, showBackButton: false),
      slivers: [
        SliverFillRemaining(
          child: _isLoading
              ? const Skeletonizer(enabled: true, child: _WebViewSkeleton())
              : WebViewWidget(controller: _controller),
        ),
      ],
    );
  }
}

class _WebViewSkeleton extends StatelessWidget {
  const _WebViewSkeleton();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(AppPadding.pH16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            height: 200.h,
            decoration: BoxDecoration(
              color: AppColors.grey1,
              borderRadius: BorderRadius.circular(AppCircular.r8),
            ),
          ),
          SizedBox(height: AppSize.sH16),
          Container(
            width: 150.w,
            height: AppSize.sH20,
            decoration: BoxDecoration(
              color: AppColors.grey1,
              borderRadius: BorderRadius.circular(AppCircular.r5),
            ),
          ),
          SizedBox(height: AppSize.sH8),
          Container(
            width: double.infinity,
            height: AppSize.sH14,
            decoration: BoxDecoration(
              color: AppColors.grey1,
              borderRadius: BorderRadius.circular(AppCircular.r2),
            ),
          ),
          SizedBox(height: AppSize.sH8),
          Container(
            width: double.infinity,
            height: AppSize.sH14,
            decoration: BoxDecoration(
              color: AppColors.grey1,
              borderRadius: BorderRadius.circular(AppCircular.r2),
            ),
          ),
          SizedBox(height: AppSize.sH8),
          Container(
            width: 250.w,
            height: AppSize.sH14,
            decoration: BoxDecoration(
              color: AppColors.grey1,
              borderRadius: BorderRadius.circular(AppCircular.r2),
            ),
          ),
          SizedBox(height: AppSize.sH24),
          Container(
            width: 120.w,
            height: AppSize.sH20,
            decoration: BoxDecoration(
              color: AppColors.grey1,
              borderRadius: BorderRadius.circular(AppCircular.r5),
            ),
          ),
          SizedBox(height: AppSize.sH8),
          Container(
            width: double.infinity,
            height: AppSize.sH14,
            decoration: BoxDecoration(
              color: AppColors.grey1,
              borderRadius: BorderRadius.circular(AppCircular.r2),
            ),
          ),
          SizedBox(height: AppSize.sH8),
          Container(
            width: double.infinity,
            height: AppSize.sH14,
            decoration: BoxDecoration(
              color: AppColors.grey1,
              borderRadius: BorderRadius.circular(AppCircular.r2),
            ),
          ),
        ],
      ),
    );
  }
}
