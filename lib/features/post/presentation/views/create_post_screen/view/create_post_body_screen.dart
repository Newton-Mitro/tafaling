import 'dart:io';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:tafaling/core/extensions/app_context.dart';
import 'package:video_player/video_player.dart';

class CreatePostBodyScreen extends StatefulWidget {
  final String filePath;
  final String fileType; // "image" or "video"

  const CreatePostBodyScreen({
    super.key,
    required this.filePath,
    required this.fileType,
  });

  @override
  State<CreatePostBodyScreen> createState() => _CreatePostBodyScreenState();
}

class _CreatePostBodyScreenState extends State<CreatePostBodyScreen> {
  final TextEditingController _postBodyController = TextEditingController();
  VideoPlayerController? _videoController;
  ChewieController? _chewieController;

  @override
  void initState() {
    super.initState();
    if (widget.fileType == "video") {
      _videoController = VideoPlayerController.file(File(widget.filePath))
        ..initialize().then((_) {
          _chewieController = ChewieController(
            videoPlayerController: _videoController!,
            autoPlay: false,
            looping: false,
            aspectRatio: _videoController!.value.aspectRatio,
          );
          setState(() {});
        });
    }
  }

  void _submitPost() {
    final bodyText = _postBodyController.text.trim();

    if (bodyText.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter some text before submitting.'),
        ),
      );
      return;
    }

    // TODO: Send data to backend
    print('Post Body: $bodyText');
    print('File: ${widget.filePath} (${widget.fileType})');

    _postBodyController.clear();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Post submitted successfully!')),
    );
  }

  @override
  void dispose() {
    _postBodyController.dispose();
    _videoController?.dispose();
    _chewieController?.dispose();
    super.dispose();
  }

  Widget _buildPreview() {
    if (widget.fileType == "image") {
      return ClipRRect(
        borderRadius: BorderRadius.circular(5),
        child: Image.file(
          File(widget.filePath),
          height: 280,
          fit: BoxFit.cover,
        ),
      );
    }

    if (_chewieController != null &&
        _chewieController!.videoPlayerController.value.isInitialized) {
      return AspectRatio(
        aspectRatio: _videoController!.value.aspectRatio,
        child: Chewie(controller: _chewieController!),
      );
    }

    return Container(
      height: 280,
      alignment: Alignment.center,
      child: const CircularProgressIndicator(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Create Post"),
        elevation: 2,
        backgroundColor: theme.colorScheme.primary,
        foregroundColor: theme.colorScheme.onPrimary,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Attachment Preview",
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 12),

              Container(width: double.infinity, child: _buildPreview()),

              const SizedBox(height: 30),
              Text(
                "Post Content",
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 12),

              Container(
                decoration: BoxDecoration(
                  color: theme.colorScheme.surface,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 6,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: TextField(
                  controller: _postBodyController,
                  maxLines: 3,
                  decoration: const InputDecoration(
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 16,
                    ),
                    hintText: "Write your post here...",
                    border: InputBorder.none,
                  ),
                ),
              ),

              const SizedBox(height: 36),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: _submitPost,
                  icon: const Icon(Icons.send),
                  label: const Padding(
                    padding: EdgeInsets.symmetric(vertical: 14),
                    child: Text(
                      "Submit Post",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    backgroundColor: theme.colorScheme.primary,
                    foregroundColor: theme.colorScheme.onPrimary,
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
