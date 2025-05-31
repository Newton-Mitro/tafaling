import 'dart:io';

import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tafaling/core/extensions/app_context.dart';
import 'package:tafaling/routes/app_route_name.dart';
import 'package:video_player/video_player.dart';

import '../bloc/create_post_bloc.dart';

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

  final List<Map<String, dynamic>> _privacyOptions = [
    {'id': 1, 'label': 'Public'},
    {'id': 2, 'label': 'Friends'},
    {'id': 3, 'label': 'Only Me'},
  ];
  int _selectedPrivacyId = 1;

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
    final file = File(widget.filePath);

    if (bodyText.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter some text before submitting.'),
        ),
      );
      return;
    }

    context.read<CreatePostBloc>().add(
      SubmitPostEvent(
        privacyId: _selectedPrivacyId,
        body: bodyText,
        attachments: [file],
      ),
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
      body: BlocConsumer<CreatePostBloc, CreatePostState>(
        listener: (context, state) {
          if (state is CreatePostSuccess) {
            _postBodyController.clear();
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.message)));
            Navigator.pushReplacementNamed(context, AppRouteName.homePage);
          } else if (state is CreatePostFailure) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.error)));
          }
        },
        builder: (context, state) {
          return SafeArea(
            child: Stack(
              children: [
                SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 24,
                  ),
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
                      SizedBox(width: double.infinity, child: _buildPreview()),
                      const SizedBox(height: 30),

                      // 🔒 Privacy Selection
                      Text(
                        "Privacy",
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 12),
                      DropdownButtonFormField<int>(
                        value: _selectedPrivacyId,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: theme.colorScheme.surface,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide.none,
                          ),
                        ),
                        items:
                            _privacyOptions
                                .map(
                                  (option) => DropdownMenuItem<int>(
                                    value: option['id'],
                                    child: Text(option['label']),
                                  ),
                                )
                                .toList(),
                        onChanged: (value) {
                          if (value != null) {
                            setState(() {
                              _selectedPrivacyId = value;
                            });
                          }
                        },
                      ),
                      const SizedBox(height: 24),

                      // 📝 Post Body Input
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

                      // 🚀 Submit Button
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton.icon(
                          onPressed:
                              state is CreatePostLoading ? null : _submitPost,
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
                if (state is CreatePostLoading)
                  const Center(child: CircularProgressIndicator()),
              ],
            ),
          );
        },
      ),
    );
  }
}
