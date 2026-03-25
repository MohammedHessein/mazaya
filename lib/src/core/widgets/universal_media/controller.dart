import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'enums.dart';

class UniversalMediaController extends ChangeNotifier {
  final String path;
  final bool autoPlay;

  VideoPlayerController? _videoController;
  bool _isInitialized = false;
  bool _isLoading = false;
  String? _error;

  UniversalMediaController({required this.path, this.autoPlay = false}) {
    _initialize();
  }

  MediaType get mediaType => _detectMediaType();
  MediaSource get mediaSource => _detectMediaSource();
  VideoPlayerController? get videoController => _videoController;
  bool get isInitialized => _isInitialized;
  bool get isLoading => _isLoading;
  String? get error => _error;
  bool get isPlaying => _videoController?.value.isPlaying ?? false;

  MediaType _detectMediaType() {
    final ext = path.split('.').last.toLowerCase();

    if (['mp4', 'mov', 'avi', 'mkv', 'flv', 'wmv', 'webm'].contains(ext)) {
      return MediaType.video;
    } else if (ext == 'svg') {
      return MediaType.svg;
    } else {
      return MediaType.image;
    }
  }

  MediaSource _detectMediaSource() {
    return path.startsWith('http') ? MediaSource.network : MediaSource.asset;
  }

  Future<void> _initialize() async {
    if (mediaType == MediaType.video) {
      await _loadVideo();
    } else {
      _isInitialized = true;
      notifyListeners();
    }
  }

  Future<void> _loadVideo() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _videoController = mediaSource == MediaSource.network
          ? VideoPlayerController.networkUrl(Uri.parse(path))
          : VideoPlayerController.asset(path);

      await _videoController!.initialize();
      await _videoController!.setLooping(true);

      if (autoPlay) {
        await _videoController!.play();
      }

      _isInitialized = true;
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      _isLoading = false;
      _isInitialized = false;
      notifyListeners();
    }
  }

  Future<void> play() async {
    if (_isInitialized && _videoController != null) {
      await _videoController!.play();
      notifyListeners();
    }
  }

  Future<void> pause() async {
    if (_isInitialized && _videoController != null) {
      await _videoController!.pause();
      notifyListeners();
    }
  }

  Future<void> seekTo(Duration position) async {
    if (_isInitialized && _videoController != null) {
      await _videoController!.seekTo(position);
    }
  }

  Future<void> reload() async {
    if (mediaType == MediaType.video) {
      await _videoController?.dispose();
      _isInitialized = false;
      _isLoading = false;
      _error = null;
      await _loadVideo();
    }
  }

  @override
  void dispose() {
    _videoController?.dispose();
    super.dispose();
  }
}
