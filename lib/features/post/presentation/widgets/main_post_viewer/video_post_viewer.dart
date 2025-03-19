import 'dart:async';
import 'package:cached_video_player_plus/cached_video_player_plus.dart';
import 'package:flutter/material.dart';
import 'package:tafaling/core/utils/app_context.dart';

class VideoPostViewer extends StatefulWidget {
  const VideoPostViewer(
      {super.key, required this.attachmentUrl, required this.autoPlay});
  final String attachmentUrl;
  final bool autoPlay;

  @override
  State<VideoPostViewer> createState() => _MyVideoPlayerState();
}

class _MyVideoPlayerState extends State<VideoPostViewer> {
  late CachedVideoPlayerPlusController videoPlayerController;
  bool _isInitialized = false;
  bool _showSeekBar = false;
  Timer? _hideSeekBarTimer;
  Duration _videoPosition = Duration.zero;

  @override
  void initState() {
    super.initState();
    videoPlayerController = CachedVideoPlayerPlusController.networkUrl(
      Uri.parse(widget.attachmentUrl),
      httpHeaders: {
        'Connection': 'keep-alive',
      },
    )..initialize().then((_) async {
        setState(() {
          _isInitialized = true;
        });
        if (widget.autoPlay) {
          videoPlayerController.play();
        }
        // videoPlayerController.play();
        await videoPlayerController.setLooping(true);

        // Listen to video position updates
        videoPlayerController.addListener(() {
          if (mounted) {
            setState(() {
              _videoPosition = videoPlayerController.value.position;
            });
          }
        });
      });
  }

  @override
  void dispose() {
    videoPlayerController.dispose();
    _hideSeekBarTimer?.cancel();
    super.dispose();
  }

  void _togglePlayPause() {
    setState(() {
      if (videoPlayerController.value.isPlaying) {
        videoPlayerController.pause();
      } else {
        videoPlayerController.play();
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
    _hideSeekBarTimer?.cancel(); // Cancel any existing timer
    _hideSeekBarTimer = Timer(const Duration(seconds: 3), () {
      setState(() {
        _showSeekBar = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: _toggleSeekBarVisibility,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Center(
              child: _isInitialized
                  ? AspectRatio(
                      aspectRatio: videoPlayerController.value.aspectRatio,
                      child: CachedVideoPlayerPlus(videoPlayerController),
                    )
                  : CircularProgressIndicator(),
            ),
            if (_isInitialized)
              IconButton(
                icon: Icon(
                  videoPlayerController.value.isPlaying
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
                    activeTrackColor: context.theme.colorScheme.primary,
                    inactiveTrackColor: const Color.fromARGB(96, 66, 66, 66),
                    thumbColor: context.theme.colorScheme.error,
                    thumbShape: const RoundSliderThumbShape(
                      enabledThumbRadius: 6,
                    ),
                    overlayColor:
                        Colors.black26.withOpacity(0.2), // Lighter overlay
                  ),
                  child: Slider(
                    value: _videoPosition.inSeconds.toDouble(),
                    min: 0,
                    max: videoPlayerController.value.duration.inSeconds
                        .toDouble(),
                    onChanged: (value) {},
                    onChangeEnd: (value) {
                      final seekToPosition = Duration(seconds: value.toInt());
                      videoPlayerController.seekTo(seekToPosition);
                    },
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
