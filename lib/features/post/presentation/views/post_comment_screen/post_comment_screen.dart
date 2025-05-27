import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tafaling/core/extensions/app_context.dart';
import 'package:tafaling/core/injection.dart';
import 'package:tafaling/features/post/domain/entities/comment_entity.dart';
import 'package:tafaling/features/post/presentation/views/post_comment_screen/bloc/post_comment_bloc/post_comment_bloc.dart';
import 'package:tafaling/features/post/presentation/views/post_comment_screen/bloc/post_comment_list_bloc/post_comment_list_bloc.dart';
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
  late final PostCommentListBloc _postCommentListbloc;
  late final PostCommentBloc _postCommentbloc;
  final TextEditingController _mainCommentController = TextEditingController();
  final TextEditingController _replyController = TextEditingController();

  int? _replyingToCommentId; // store comment id we are replying to

  @override
  void initState() {
    super.initState();
    _postCommentListbloc = sl<PostCommentListBloc>();
    _postCommentbloc = sl<PostCommentBloc>();
    _loadComments();
  }

  void _loadComments() {
    _postCommentListbloc.add(
      LoadPostComments(
        postId: widget.postEntity.id,
        userId: widget.postEntity.userId,
        parentCommentId: null,
        pageSize: 10,
      ),
    );
  }

  void _submitMainComment() {
    final text = _mainCommentController.text.trim();
    if (text.isEmpty) return;

    // Dispatch AddMainComment event with text
    _postCommentbloc.add(
      SubmitPostComment(
        postId: widget.postEntity.id,
        comment: text,
        parentId: -1,
      ),
    );

    _mainCommentController.clear();
  }

  void _submitReply() {
    final text = _replyController.text.trim();
    if (text.isEmpty || _replyingToCommentId == null) return;

    // Dispatch AddReply event
    _postCommentbloc.add(
      SubmitPostComment(
        postId: widget.postEntity.id,
        parentId: _replyingToCommentId!,
        comment: text,
      ),
    );

    _replyController.clear();
    setState(() {
      _replyingToCommentId = null;
    });
  }

  @override
  void dispose() {
    _mainCommentController.dispose();
    _replyController.dispose();
    _postCommentListbloc.close();
    super.dispose();
  }

  Widget _buildReplyRow(CommentEntity comment) {
    return Container(
      margin: const EdgeInsets.only(top: 6),
      padding: const EdgeInsets.only(left: 4),
      child: Row(
        children: [
          CircleAvatar(
            backgroundImage: NetworkImage(
              comment.createdBy.profilePicture ?? '',
            ),
            radius: 14,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  comment.createdBy.name,
                  style: const TextStyle(fontWeight: FontWeight.w500),
                ),
                Text(comment.content),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCommentRow(CommentEntity comment) {
    final bool isReplyingHere = _replyingToCommentId == comment.commentId;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: context.theme.colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage(
                  comment.createdBy.profilePicture ?? '',
                ),
                radius: 18,
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      comment.createdBy.name,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 4),
                    Text(comment.content),
                    const SizedBox(height: 4),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _replyingToCommentId = comment.commentId;
                          _replyController.clear();
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
          if (comment.replies.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(left: 40, top: 10),
              child: Column(
                children: comment.replies.map(_buildReplyRow).toList(),
              ),
            ),
          if (isReplyingHere)
            Padding(
              padding: const EdgeInsets.only(left: 40, top: 10),
              child: Column(
                children: [
                  TextField(
                    controller: _replyController,
                    decoration: InputDecoration(
                      hintText: 'Reply...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    maxLines: null,
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      AppPrimaryButton(
                        label: "Send",
                        onPressed: _submitReply,
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
                            _replyingToCommentId = null;
                            _replyController.clear();
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
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _postCommentListbloc,
      child: Scaffold(
        appBar: AppBar(title: const Text("Comments")),
        body: SafeArea(
          child: BlocBuilder<PostCommentListBloc, PostCommentListState>(
            builder: (context, state) {
              if (state is PostCommentListLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is PostCommentListLoaded) {
                final comments = state.comments;

                if (comments.isEmpty) {
                  return ListView(
                    padding: const EdgeInsets.fromLTRB(16, 12, 16, 100),
                    children: [
                      PostPreview(postEntity: widget.postEntity),
                      const SizedBox(height: 40),
                      Column(
                        children: [
                          Icon(
                            Icons.chat_bubble_outline,
                            size: 48,
                            color: Colors.grey[500],
                          ),
                          const SizedBox(height: 12),
                          Text(
                            "No comments yet. Be the first to comment!",
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 16,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ],
                  );
                }

                return ListView.builder(
                  padding: const EdgeInsets.fromLTRB(16, 12, 16, 100),
                  itemCount: comments.length + 1, // +1 for post preview
                  itemBuilder: (context, index) {
                    if (index == 0) {
                      return PostPreview(postEntity: widget.postEntity);
                    } else {
                      return _buildCommentRow(comments[index - 1]);
                    }
                  },
                );
              } else if (state is PostCommentListError) {
                return Center(child: Text('Error: ${state.message}'));
              }

              // initial or unknown state
              return const SizedBox.shrink();
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
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(24),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 16,
                      ),
                    ),
                    maxLines: null,
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
      ),
    );
  }
}
