import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:tafaling/core/extensions/app_context.dart';
import 'package:tafaling/features/post/domain/entities/post_entity.dart';
import 'package:tafaling/features/post/presentation/views/post_preview_screen/widgets/video_post_viewer.dart';

class ProfilePostsGrid extends StatelessWidget {
  final int itemCount;
  final List<PostEntity> myPosts;

  const ProfilePostsGrid({
    super.key,
    required this.itemCount,
    required this.myPosts,
  });

  @override
  Widget build(BuildContext context) {
    // Check if there are no posts
    if (itemCount == 0) {
      return Center(
        child: Text(
          'No posts available',
          style: TextStyle(
            fontSize: 18,
            color: context.theme.colorScheme.onSurface,
          ),
        ),
      );
    }

    // Build the grid if there are posts
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 4,
        mainAxisSpacing: 4,
        childAspectRatio: 1, // Ensures square grid cells
      ),
      itemCount: itemCount,
      itemBuilder: (context, index) {
        final post =
            myPosts[index].attachments.isNotEmpty
                ? myPosts[index].attachments.first
                : null;
        final thumbnailUrl =
            post != null ? "${post.fileURL}/${post.fileName}" : '';

        final mimeType = post?.mimeType.toLowerCase() ?? "link";

        return Container(
          margin: const EdgeInsets.all(2),
          decoration: BoxDecoration(
            border: Border.all(
              color: context.theme.colorScheme.surface,
              width: 2,
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child:
                mimeType.contains("image")
                    ? CachedNetworkImage(
                      imageUrl: thumbnailUrl,
                      fit: BoxFit.cover,
                      errorWidget:
                          (context, url, error) =>
                              Image.asset('assets/images/misc/no_preview.png'),
                    )
                    : mimeType.contains("video")
                    ? VideoPostViewer(
                      attachmentUrl: thumbnailUrl,
                      autoPlay: false,
                    )
                    : CachedNetworkImage(
                      imageUrl: thumbnailUrl,
                      fit: BoxFit.cover,
                      errorWidget:
                          (context, url, error) =>
                              Image.asset('assets/images/misc/no_preview.png'),
                    ),
          ),
        );
      },
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
    );
  }
}
