import 'package:flutter/material.dart';
import 'package:tafaling/features/post/domain/entities/post_entity.dart';
import 'package:tafaling/features/post/presentation/widgets/post_preview/post_preview.dart';

class SharePostScreen extends StatefulWidget {
  final PostEntity postEntity;
  const SharePostScreen({super.key, required this.postEntity});

  @override
  State<SharePostScreen> createState() => _SharePostScreenState();
}

class _SharePostScreenState extends State<SharePostScreen> {
  final TextEditingController _postController = TextEditingController();

  void _sharePost() {
    final text = _postController.text.trim();

    if (text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter some text to share.')),
      );
      return;
    }

    // TODO: Send the post to your backend or state management layer

    print('Shared: $text');

    // Clear input
    _postController.clear();
    setState(() {});

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Post shared successfully!')));
  }

  @override
  void dispose() {
    _postController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Share Post')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Preview Section
            const Text(
              'Preview',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            PostPreview(postEntity: widget.postEntity),
            const SizedBox(height: 24),

            /// Post Input Field
            TextField(
              controller: _postController,
              maxLines: 5,
              decoration: const InputDecoration(
                hintText: "What's on your mind?",
                border: OutlineInputBorder(),
              ),
              onChanged: (_) => setState(() {}),
            ),
            const SizedBox(height: 16),

            /// Share Button
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                onPressed: _sharePost,
                child: const Text('Share'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
