import 'package:flutter/material.dart';
import 'package:mazaya/src/core/widgets/scaffolds/app_header_sliver.dart';
import 'package:mazaya/src/core/widgets/scaffolds/header_config.dart';

class DefaultScaffold extends StatelessWidget {
  final HeaderConfig header;
  final List<Widget> slivers;
  final Widget? bottomNavigationBar;
  final bool extendBody;

  const DefaultScaffold({
    super.key,
    required this.header,
    required this.slivers,
    this.bottomNavigationBar,
    this.extendBody = false,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: extendBody,
      bottomNavigationBar: bottomNavigationBar,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          AppHeaderSliver(config: header),
          ...slivers,
          if (extendBody)
            const SliverToBoxAdapter(child: SizedBox(height: 100)),
        ],
      ),
    );
  }
}
