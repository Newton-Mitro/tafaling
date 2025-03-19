import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class ShareYouTubeVideoPlayer extends StatefulWidget {
  final String videoUrl;

  const ShareYouTubeVideoPlayer({super.key, required this.videoUrl});

  @override
  State<ShareYouTubeVideoPlayer> createState() =>
      _ShareYouTubeVideoPlayerState();
}

class _ShareYouTubeVideoPlayerState extends State<ShareYouTubeVideoPlayer> {
  late YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();
    String videoId = YoutubePlayer.convertUrlToId(widget.videoUrl) ?? '';

    _controller = YoutubePlayerController(
      initialVideoId: videoId,
      flags: YoutubePlayerFlags(autoPlay: false, mute: false),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return YoutubePlayer(
      controller: _controller,
      showVideoProgressIndicator: true,
    );
  }
}
