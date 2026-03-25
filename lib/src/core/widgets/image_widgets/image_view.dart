import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import '../../../config/res/config_imports.dart';

enum MediaType { image, video }

enum MediaSource { network, asset }

class ImageView extends StatefulWidget {
  const ImageView({
    super.key,
    required this.mediaPath,
    required this.mediaType,
    required this.mediaSource,
    this.minScale = 0.0,
    this.maxScale = 4.0,
    this.autoPlayVideo = true,
    this.loopVideo = true,
  });

  final String mediaPath;
  final MediaType mediaType;
  final MediaSource mediaSource;
  final double minScale;
  final double maxScale;
  final bool autoPlayVideo;
  final bool loopVideo;

  @override
  State<ImageView> createState() => _ImageViewState();
}

class _ImageViewState extends State<ImageView> {
  VideoPlayerController? _videoController;
  bool _isVideoInitialized = false;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    if (widget.mediaType == MediaType.video) {
      _initializeVideoPlayer();
    }
  }

  Future<void> _initializeVideoPlayer() async {
    setState(() => _isLoading = true);

    try {
      // Initialize video controller based on source
      if (widget.mediaSource == MediaSource.network) {
        _videoController = VideoPlayerController.networkUrl(
          Uri.parse(widget.mediaPath),
        );
      } else {
        _videoController = VideoPlayerController.asset(widget.mediaPath);
      }

      await _videoController!.initialize();
      _videoController!.setLooping(widget.loopVideo);

      if (widget.autoPlayVideo) {
        await _videoController!.play();
      }

      setState(() {
        _isVideoInitialized = true;
        _isLoading = false;
      });
    } catch (e) {
      setState(() => _isLoading = false);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error loading video: $e')),
        );
      }
    }
  }

  @override
  void dispose() {
    _videoController?.dispose();
    super.dispose();
  }

  Widget _buildImageWidget() {
    Widget imageWidget;

    if (widget.mediaSource == MediaSource.network) {
      imageWidget = Image.network(
        widget.mediaPath,
        fit: BoxFit.contain,
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return Center(
            child: CircularProgressIndicator(
              value: loadingProgress.expectedTotalBytes != null
                  ? loadingProgress.cumulativeBytesLoaded /
                      loadingProgress.expectedTotalBytes!
                  : null,
            ),
          );
        },
        errorBuilder: (context, error, stackTrace) {
          return const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.error_outline, size: 48, color: Colors.red),
                SizedBox(height: 16),
                Text('Failed to load image'),
              ],
            ),
          );
        },
      );
    } else {
      imageWidget = Image.asset(
        widget.mediaPath,
        fit: BoxFit.contain,
        errorBuilder: (context, error, stackTrace) {
          return const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.error_outline, size: 48, color: Colors.red),
                SizedBox(height: 16),
                Text('Failed to load image'),
              ],
            ),
          );
        },
      );
    }

    return InteractiveViewer(
      minScale: widget.minScale,
      maxScale: widget.maxScale,
      scaleFactor: 1.0,
      child: imageWidget,
    );
  }

  Widget _buildVideoWidget() {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (!_isVideoInitialized || _videoController == null) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline, size: 48, color: Colors.red),
            SizedBox(height: 16),
            Text('Failed to load video'),
          ],
        ),
      );
    }

    return Center(
      child: AspectRatio(
        aspectRatio: _videoController!.value.aspectRatio,
        child: Stack(
          alignment: Alignment.center,
          children: [
            VideoPlayer(_videoController!),
            // Play/Pause overlay
            GestureDetector(
              onTap: () {
                setState(() {
                  if (_videoController!.value.isPlaying) {
                    _videoController!.pause();
                  } else {
                    _videoController!.play();
                  }
                });
              },
              child: Container(
                color: Colors.transparent,
                child: Center(
                  child: AnimatedOpacity(
                    opacity: _videoController!.value.isPlaying ? 0.0 : 1.0,
                    duration: const Duration(milliseconds: 300),
                    child: Container(
                      decoration: const BoxDecoration(
                        color: Colors.black54,
                        shape: BoxShape.circle,
                      ),
                      padding: const EdgeInsets.all(16),
                      child: Icon(
                        _videoController!.value.isPlaying
                            ? Icons.pause
                            : Icons.play_arrow,
                        size: 48,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            // Video progress bar
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: VideoProgressIndicator(
                _videoController!,
                allowScrubbing: true,
                colors: VideoProgressColors(
                  playedColor: Theme.of(context).primaryColor,
                  bufferedColor: Colors.grey,
                  backgroundColor: Colors.grey.shade300,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      primary: false,
      backgroundColor: Colors.black,
      body: Stack(
        alignment: Alignment.topLeft,
        children: [
          Container(
            constraints: BoxConstraints.expand(
              height: MediaQuery.of(context).size.height,
            ),
            child: widget.mediaType == MediaType.image
                ? _buildImageWidget()
                : _buildVideoWidget(),
          ),
          Padding(
            padding: EdgeInsets.all(AppPadding.pH12),
            child: const CloseButton(
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
