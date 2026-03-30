import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mazaya/src/core/widgets/universal_media/enums.dart';
import 'package:mazaya/src/core/widgets/scaffolds/sliver_scaffold_body.dart';
import 'package:mazaya/src/core/widgets/scaffolds/stack_scaffold_body.dart';

class DefaultScaffold extends StatelessWidget {
  final String title;
  final Widget body;
  final List<Widget>? slivers;
  final void Function()? onTap;
  final Widget? trailing;
  final Widget? headLineWidget;
  final bool showCurvedHeader;
  final Widget? headerWidget;
  final ScaffoldHeaderType headerType;
  final String? imageUrl;
  final String? userName;
  final String? subTitle;
  final bool showBackButton;
  final Widget? bottomNavigationBar;
  final bool extendBody;

  const DefaultScaffold({
    super.key,
    required this.title,
    this.body = const SizedBox.shrink(),
    this.onTap,
    this.headLineWidget,
    this.trailing,
    this.showCurvedHeader = false,
    this.headerWidget,
    this.headerType = ScaffoldHeaderType.standard,
    this.imageUrl,
    this.userName,
    this.subTitle,
    this.showBackButton = true,
    this.bottomNavigationBar,
    this.extendBody = false,
    this.slivers,
  });

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: true,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) return;
        if (onTap != null) onTap!();
      },
      child: AnnotatedRegion<SystemUiOverlayStyle>(
        value: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.light,
        ),
        child: Scaffold(
          extendBody: extendBody,
          bottomNavigationBar: bottomNavigationBar,
          body: slivers != null
              ? SliverScaffoldBody(
                  headerType: headerType,
                  imageUrl: imageUrl,
                  userName: userName,
                  showBackButton: showBackButton,
                  title: title,
                  trailing: trailing,
                  headerWidget: headerWidget,
                  headLineWidget: headLineWidget,
                  slivers: slivers!,
                  extendBody: extendBody,
                )
              : StackScaffoldBody(
                  headerType: headerType,
                  imageUrl: imageUrl,
                  userName: userName,
                  showBackButton: showBackButton,
                  title: title,
                  trailing: trailing,
                  headerWidget: headerWidget,
                  headLineWidget: headLineWidget,
                  body: body,
                ),
        ),
      ),
    );
  }
}
