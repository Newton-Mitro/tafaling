import 'dart:async';
import 'package:cached_video_player_plus/cached_video_player_plus.dart';
import 'package:flutter/material.dart';
import 'package:visibility_detector/visibility_detector.dart';

class VideoPostViewer extends StatefulWidget {
  const VideoPostViewer({
    super.key,
    required this.attachmentUrl,
    required this.autoPlay,
  });

  final String attachmentUrl;
  final bool autoPlay;

  @override
  State<VideoPostViewer> createState() => _VideoPostViewerState();
}

class _VideoPostViewerState extends State<VideoPostViewer> {
  late CachedVideoPlayerPlusController _videoPlayerController;
  bool _isInitialized = false;
  bool _showSeekBar = false;
  Timer? _hideSeekBarTimer;
  Duration _videoPosition = Duration.zero;
  bool _isVisible = false; // Track if the video is visible

  @override
  void initState() {
    super.initState();

    _videoPlayerController = CachedVideoPlayerPlusController.networkUrl(
        Uri.parse(widget.attachmentUrl),
        httpHeaders: {'Connection': 'keep-alive'},
      )
      ..initialize().then((_) {
        setState(() {
          _isInitialized = true;
        });

        _videoPlayerController.setLooping(true);

        // Listen to video position updates
        _videoPlayerController.addListener(() {
          if (mounted) {
            setState(() {
              _videoPosition = _videoPlayerController.value.position;
            });
          }
        });

        // Auto-play only if the video is visible
        if (widget.autoPlay && _isVisible) {
          _videoPlayerController.play();
        }
      });
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    _hideSeekBarTimer?.cancel();
    super.dispose();
  }

  void _togglePlayPause() {
    setState(() {
      if (_videoPlayerController.value.isPlaying) {
        _videoPlayerController.pause();
      } else {
        _videoPlayerController.play();
      }
    });
  }

  void _toggleSeekBarVisibility() {
    setState(() {
      _showSeekBar = !_showSeekBar;
    });
    _resetHideSeekBarTimer();
  }

  void _resetHideSeekBarTimer() {
    _hideSeekBarTimer?.cancel();
    _hideSeekBarTimer = Timer(const Duration(seconds: 3), () {
      if (mounted) {
        setState(() {
          _showSeekBar = false;
        });
      }
    });
  }

  void _onVisibilityChanged(VisibilityInfo visibilityInfo) {
    bool isVisible = visibilityInfo.visibleFraction > 0;
    if (isVisible != _isVisible) {
      setState(() {
        _isVisible = isVisible;
      });

      if (_isVisible) {
        if (widget.autoPlay) {
          _videoPlayerController.play();
        }
      } else {
        _videoPlayerController.pause();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: VisibilityDetector(
        key: Key(widget.attachmentUrl),
        onVisibilityChanged: _onVisibilityChanged,
        child: GestureDetector(
          onTap: _toggleSeekBarVisibility,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Center(
                child:
                    _isInitialized
                        ? AspectRatio(
                          aspectRatio: _videoPlayerController.value.aspectRatio,
                          child: CachedVideoPlayerPlus(_videoPlayerController),
                        )
                        : const CircularProgressIndicator(),
              ),
              if (_isInitialized)
                IconButton(
                  icon: Icon(
                    _videoPlayerController.value.isPlaying
                        ? Icons.pause
                        : Icons.play_arrow,
                    color: const Color.fromARGB(82, 255, 255, 255),
                  ),
                  onPressed: _togglePlayPause,
                ),
              if (_showSeekBar && _isInitialized)
                Positioned(
                  bottom: 120,
                  left: 20,
                  right: 20,
                  child: SliderTheme(
                    data: SliderTheme.of(context).copyWith(
                      trackHeight: 2,
                      activeTrackColor: Colors.blue,
                      inactiveTrackColor: Colors.grey,
                      thumbColor: Colors.red,
                      thumbShape: const RoundSliderThumbShape(
                        enabledThumbRadius: 6,
                      ),
                      overlayColor: Colors.black26.withOpacity(0.2),
                    ),
                    child: Slider(
                      value: _videoPosition.inSeconds.toDouble(),
                      min: 0,
                      max:
                          _videoPlayerController.value.duration.inSeconds
                              .toDouble(),
                      onChanged: (value) {},
                      onChangeEnd: (value) {
                        final seekToPosition = Duration(seconds: value.toInt());
                        _videoPlayerController.seekTo(seekToPosition);
                      },
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
