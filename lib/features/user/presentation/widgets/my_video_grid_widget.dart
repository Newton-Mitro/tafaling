import 'package:cached_network_image_plus/flutter_cached_network_image_plus.dart';
import 'package:flutter/material.dart';

class MyVideoGrid extends StatelessWidget {
  final int itemCount;
  final List<dynamic> myPosts;

  const MyVideoGrid({
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
        var post = myPosts[index].attachments.isNotEmpty
            ? myPosts[index].attachments[0]
            : null;
        final thumbnailUrl =
            post != null ? "${post.fileURL}${post.fileName}" : '';

        return Container(
          color: Colors.grey,
          child: CacheNetworkImagePlus(
            imageUrl: thumbnailUrl,
            boxFit:
                BoxFit.cover, // Make the image cover the grid cell completely
            errorWidget: Center(
              child: Icon(
                Icons.error,
              ),
            ),
          ),
        );
      },
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
    );
  }
}
