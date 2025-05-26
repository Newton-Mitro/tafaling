import 'dart:io';

import 'package:flutter/material.dart';
import 'package:tafaling/core/extensions/app_context.dart';

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

    // TODO: Handle post submission (upload file + text) to backend or state management

    print('Post submitted with body: $bodyText');
    print('Attached file path: ${widget.filePath}');
    print('Attached file type: ${widget.fileType}');

    // Clear text after submit
    _postBodyController.clear();

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Post submitted successfully!')),
    );
  }

  @override
  void dispose() {
    _postBodyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Create Post"),
        centerTitle: true,
        elevation: 2,
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

              // Preview container with shadow and rounded corners
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: theme.colorScheme.surface,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                padding: const EdgeInsets.all(12),
                child:
                    widget.fileType == "image"
                        ? ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.file(
                            File(widget.filePath),
                            height: 280,
                            fit: BoxFit.contain,
                          ),
                        )
                        : const Padding(
                          padding: EdgeInsets.symmetric(vertical: 60),
                          child: Center(
                            child: Text(
                              "Video preview is not implemented.",
                              style: TextStyle(
                                fontSize: 16,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                          ),
                        ),
              ),
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
                  color: context.theme.colorScheme.surface,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: TextField(
                  controller: _postBodyController,
                  maxLines: 3,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 14,
                      horizontal: 16,
                    ),
                    hintText: "Write your post here...",
                    border: InputBorder.none,
                  ),
                  onChanged: (_) => setState(() {}),
                ),
              ),

              const SizedBox(height: 36),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: _submitPost,
                  icon: Icon(
                    Icons.send,
                    color: context.theme.colorScheme.onPrimary,
                  ),
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
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 4,
                    backgroundColor: theme.colorScheme.primary,
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
