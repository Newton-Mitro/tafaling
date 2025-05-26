import 'package:cached_video_player_plus/cached_video_player_plus.dart';
import 'package:flutter/material.dart';
import 'package:tafaling/core/extensions/app_context.dart';
import 'package:tafaling/features/user/domain/entities/user_entity.dart';

class VideoPostPreview extends StatefulWidget {
  final String videoUrl;
  final String postBody;
  final UserEntity userEntity;

  const VideoPostPreview({
    super.key,
    required this.videoUrl,
    required this.postBody,
    required this.userEntity,
  });

  @override
  State<VideoPostPreview> createState() => _VideoPostPreviewState();
}

class _VideoPostPreviewState extends State<VideoPostPreview> {
  late CachedVideoPlayerPlusController _controller;

  @override
  void initState() {
    super.initState();

    _controller = CachedVideoPlayerPlusController.networkUrl(
        Uri.parse(widget.videoUrl),
      )
      ..initialize().then((_) {
        setState(() {});
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: context.theme.colorScheme.surface,
        boxShadow: const [
          BoxShadow(
            color: Color.fromARGB(25, 0, 0, 0),
            blurRadius: 3,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Video player
          AspectRatio(
            aspectRatio: 16 / 9,
            child:
                _controller.value.isInitialized
                    ? Stack(
                      children: [
                        CachedVideoPlayerPlus(_controller),
                        Positioned.fill(
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                _controller.value.isPlaying
                                    ? _controller.pause()
                                    : _controller.play();
                              });
                            },
                            child: AnimatedOpacity(
                              opacity: _controller.value.isPlaying ? 0 : 1,
                              duration: const Duration(milliseconds: 200),
                              child: const Center(
                                child: Icon(
                                  Icons.play_circle_fill,
                                  size: 64,
                                  color: Colors.white70,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                    : const Center(child: CircularProgressIndicator()),
          ),

          /// User Info
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundImage:
                      widget.userEntity.profilePicture != null
                          ? NetworkImage(widget.userEntity.profilePicture!)
                          : null,
                  child:
                      widget.userEntity.profilePicture == null
                          ? const Icon(Icons.person)
                          : null,
                ),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.userEntity.name,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      widget.userEntity.email,
                      style: const TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              ],
            ),
          ),

          /// Post Body
          if (widget.postBody.trim().isNotEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Text(widget.postBody),
            ),

          const SizedBox(height: 12),
        ],
      ),
    );
  }
}
