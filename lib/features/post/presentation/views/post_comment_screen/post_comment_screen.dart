import 'package:flutter/material.dart';
import 'package:tafaling/core/extensions/app_context.dart';
import 'package:tafaling/features/post/domain/entities/post_entity.dart';
import 'package:tafaling/shared/widgets/buttons/app_primary_button.dart';

class CommentPostScreen extends StatefulWidget {
  final PostEntity postEntity;
  const CommentPostScreen({super.key, required this.postEntity});

  @override
  State<CommentPostScreen> createState() => _CommentPostScreenState();
}

class _CommentPostScreenState extends State<CommentPostScreen> {
  final TextEditingController _commentController = TextEditingController();

  // Demo comments list
  final List<Map<String, String>> _demoComments = [
    {
      "userName": "Alice",
      "userAvatarUrl": "https://i.pravatar.cc/150?img=1",
      "comment": "Great post! Really enjoyed reading it.",
    },
    {
      "userName": "Bob",
      "userAvatarUrl": "https://i.pravatar.cc/150?img=2",
      "comment": "Thanks for sharing this!",
    },
    {
      "userName": "Charlie",
      "userAvatarUrl": "https://i.pravatar.cc/150?img=3",
      "comment": "Interesting perspective.",
    },
  ];

  void _submitComment() {
    final text = _commentController.text.trim();

    if (text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter a comment before submitting.'),
        ),
      );
      return;
    }

    // Add comment to demo list (in real app, submit to backend instead)
    setState(() {
      _demoComments.insert(0, {
        "userName": "You",
        "userAvatarUrl": "https://i.pravatar.cc/150?img=5",
        "comment": text,
      });
      _commentController.clear();
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Comment posted successfully!')),
    );
  }

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  Widget _buildComment(Map<String, String> commentData) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: NetworkImage(commentData["userAvatarUrl"]!),
      ),
      title: Text(
        commentData["userName"]!,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      subtitle: Text(commentData["comment"]!),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Comment')),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // Comment input
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
                  controller: _commentController,
                  maxLines: 4,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 14,
                      horizontal: 16,
                    ),
                    hintText: "Write your comment here...",
                    border: InputBorder.none,
                  ),
                  onChanged: (_) => setState(() {}),
                ),
              ),
              const SizedBox(height: 16),

              // Submit button aligned right
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  AppPrimaryButton(
                    onPressed: _submitComment,
                    label: 'Post Comment',
                    iconBefore: Icon(
                      Icons.comment,
                      color: context.theme.colorScheme.onPrimary,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 24),

              // Comments list header
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Comments (${_demoComments.length})',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 8),

              // Expanded list of comments with scrolling
              Expanded(
                child: ListView.separated(
                  itemCount: _demoComments.length,
                  separatorBuilder: (_, __) => const Divider(),
                  itemBuilder:
                      (context, index) => _buildComment(_demoComments[index]),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
