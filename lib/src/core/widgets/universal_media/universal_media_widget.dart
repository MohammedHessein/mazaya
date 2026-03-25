import 'package:flutter/material.dart';

import 'controller.dart';
import 'enums.dart';
import 'widgets.dart';

class UniversalMediaWidget extends StatefulWidget {
  final String path;
  final BoxFit fit;
  final double? width;
  final double? height;
  final bool autoPlay;

  const UniversalMediaWidget({
    super.key,
    required this.path,
    this.fit = BoxFit.contain,
    this.width,
    this.height,
    this.autoPlay = false,
  });

  @override
  State<UniversalMediaWidget> createState() => _UniversalMediaWidgetState();
}

class _UniversalMediaWidgetState extends State<UniversalMediaWidget> {
  late UniversalMediaController _controller;

  @override
  void initState() {
    super.initState();
    _controller = UniversalMediaController(
      path: widget.path,
      autoPlay: widget.autoPlay,
    );
    _controller.addListener(_onControllerUpdate);
  }

  @override
  void dispose() {
    _controller.removeListener(_onControllerUpdate);
    _controller.dispose();
    super.dispose();
  }

  void _onControllerUpdate() {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.path.isEmpty) {
      return const SizedBox.shrink();
    }

    return SizedBox(
      width: widget.width,
      height: widget.height,
      child: _buildMediaWidget(),
    );
  }

  Widget _buildMediaWidget() {
    switch (_controller.mediaType) {
      case MediaType.video:
        return MediaVideoPlayer(controller: _controller, fit: widget.fit);
      case MediaType.svg:
        return MediaSvgViewer(
          path: widget.path,
          source: _controller.mediaSource,
          fit: widget.fit,
        );
      case MediaType.image:
        return MediaImageViewer(
          path: widget.path,
          source: _controller.mediaSource,
          fit: widget.fit,
          width: widget.width,
          height: widget.height,
        );
    }
  }
}
