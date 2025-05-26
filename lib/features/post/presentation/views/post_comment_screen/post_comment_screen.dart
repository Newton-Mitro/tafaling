import 'package:flutter/material.dart';
import 'package:tafaling/core/extensions/app_context.dart';
import 'package:tafaling/features/post/presentation/widgets/post_preview/post_preview.dart';
import 'package:tafaling/shared/widgets/buttons/app_primary_button.dart';
import 'package:tafaling/features/post/domain/entities/post_entity.dart';

class CommentPostScreen extends StatefulWidget {
  final PostEntity postEntity;

  const CommentPostScreen({super.key, required this.postEntity});

  @override
  State<CommentPostScreen> createState() => _CommentPostScreenState();
}

class _CommentPostScreenState extends State<CommentPostScreen> {
  final TextEditingController _mainCommentController = TextEditingController();
  final TextEditingController _replyController = TextEditingController();

  int? _replyingToIndex;

  final List<Map<String, dynamic>> _comments = [
    {
      "userName": "Alice",
      "userAvatarUrl": "https://i.pravatar.cc/150?img=1",
      "comment": "This is a great post!",
      "replies": [
        {
          "userName": "Alice",
          "userAvatarUrl": "https://i.pravatar.cc/150?img=1",
          "comment": "This is a great post!",
          "replies": [],
        },
      ],
    },
    {
      "userName": "Bob",
      "userAvatarUrl": "https://i.pravatar.cc/150?img=2",
      "comment": "Thanks for sharing!",
      "replies": [],
    },
  ];

  void _submitMainComment() {
    final text = _mainCommentController.text.trim();
    if (text.isEmpty) return;

    setState(() {
      _comments.insert(0, {
        "userName": "You",
        "userAvatarUrl": "https://i.pravatar.cc/150?img=10",
        "comment": text,
        "replies": [],
      });
      _mainCommentController.clear();
    });
  }

  void _submitReply(int index) {
    final text = _replyController.text.trim();
    if (text.isEmpty) return;

    setState(() {
      _comments[index]['replies'].add({
        "userName": "You",
        "userAvatarUrl": "https://i.pravatar.cc/150?img=11",
        "comment": text,
      });
      _replyController.clear();
      _replyingToIndex = null;
    });
  }

  Widget _buildReplyRow(Map<String, dynamic> reply) {
    return Container(
      margin: const EdgeInsets.only(top: 6),
      padding: const EdgeInsets.only(left: 4),
      child: Row(
        children: [
          CircleAvatar(
            backgroundImage: NetworkImage(reply["userAvatarUrl"]),
            radius: 14,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  reply["userName"],
                  style: const TextStyle(fontWeight: FontWeight.w500),
                ),
                Text(reply["comment"]),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCommentRow(Map<String, dynamic> comment, int index) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: context.theme.colorScheme.surfaceVariant,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage(comment["userAvatarUrl"]),
                radius: 18,
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      comment["userName"],
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 4),
                    Text(comment["comment"]),
                    const SizedBox(height: 4),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _replyingToIndex = index;
                          _replyController.text = '';
                        });
                      },
                      child: Text(
                        "Reply",
                        style: TextStyle(
                          color: context.theme.colorScheme.primary,
                          fontSize: 13,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          if ((comment['replies'] as List).isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(left: 40, top: 10),
              child: Column(
                children:
                    (comment['replies'] as List<Map<String, dynamic>>)
                        .map(_buildReplyRow)
                        .toList(),
              ),
            ),
          if (_replyingToIndex == index)
            Padding(
              padding: const EdgeInsets.only(left: 40, top: 10),
              child: Column(
                children: [
                  TextField(
                    controller: _replyController,
                    decoration: InputDecoration(
                      hintText: 'Reply...',
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      AppPrimaryButton(
                        label: "Send",
                        onPressed: () => _submitReply(index),
                        iconBefore: Icon(
                          Icons.send,
                          size: 16,
                          color: context.theme.colorScheme.onPrimary,
                        ),
                      ),
                      const SizedBox(width: 8),
                      TextButton(
                        onPressed: () {
                          setState(() {
                            _replyingToIndex = null;
                          });
                        },
                        child: const Text("Cancel"),
                      ),
                    ],
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _mainCommentController.dispose();
    _replyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Comments")),
      body: SafeArea(
        child: ListView.builder(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 100),
          itemCount: _comments.length + 1, // extra item for post preview
          itemBuilder: (context, index) {
            if (index == 0) {
              return PostPreview(postEntity: widget.postEntity);
            } else {
              return _buildCommentRow(_comments[index - 1], index - 1);
            }
          },
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Container(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
          decoration: BoxDecoration(
            color: context.theme.colorScheme.surface,
            border: Border(top: BorderSide(color: Colors.grey.shade300)),
          ),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _mainCommentController,
                  decoration: InputDecoration(
                    hintText: "Write a comment...",
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 16,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Container(
                decoration: BoxDecoration(
                  color: context.theme.colorScheme.primary,
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                  onPressed: _submitMainComment,
                  icon: Icon(
                    Icons.send,
                    size: 18,
                    color: context.theme.colorScheme.onPrimary,
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
