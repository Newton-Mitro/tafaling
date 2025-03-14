import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:tafaling/features/post/data/models/post_model.dart';
import 'package:tafaling/features/post/presentation/widgets/video_post_viewer.dart';

class ProfileVideoGrid extends StatelessWidget {
  final int itemCount;
  final List<PostModel> myPosts;

  const ProfileVideoGrid({
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
          style: TextStyle(fontSize: 18, color: Colors.grey[600]),
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
        final post = myPosts[index].attachments.isNotEmpty
            ? myPosts[index].attachments.first
            : null;
        final thumbnailUrl =
            post != null ? "${post.fileURL}/${post.fileName}" : '';

        final mimeType = post?.mimeType.toLowerCase() ?? "link";

        if (mimeType.contains("image")) {
          return Container(
            color: Colors.grey,
            child: CachedNetworkImage(
              imageUrl: thumbnailUrl,
              errorWidget: (context, url, error) =>
                  Image.asset('assets/images/misc/no_preview.png'),
            ),
          );
        } else if (mimeType.contains("video")) {
          return VideoPostViewer(
            attachmentUrl: thumbnailUrl,
            autoPlay: false,
          );
        } else {
          return Container(
            color: Colors.grey,
            child: CachedNetworkImage(
              imageUrl: thumbnailUrl,
              errorWidget: (context, url, error) =>
                  Image.asset('assets/images/misc/no_preview.png'),
            ),
          );
        }
      },
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
    );
  }
}
