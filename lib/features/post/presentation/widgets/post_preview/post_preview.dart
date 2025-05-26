import 'package:flutter/material.dart';
import 'package:tafaling/core/utils/url_helper.dart';
import 'package:tafaling/features/post/domain/entities/post_entity.dart';
import 'package:tafaling/features/post/presentation/widgets/post_preview/image_post_preview.dart';
import 'package:tafaling/features/post/presentation/widgets/post_preview/video_post_preview.dart';

class PostPreview extends StatefulWidget {
  final PostEntity postEntity;
  const PostPreview({super.key, required this.postEntity});

  @override
  State<PostPreview> createState() => _PostPreviewState();
}

class _PostPreviewState extends State<PostPreview> {
  @override
  Widget build(BuildContext context) {
    final int attachmentCount = widget.postEntity.attachments.length;
    final List<String> extractedUrls = UrlHelper.extractUrls(
      widget.postEntity.body ?? '',
    );

    if (attachmentCount > 0) {
      final attachment = widget.postEntity.attachments[0];
      final mimeType = attachment.mimeType.toLowerCase();
      final attachmentUrl = '${attachment.fileURL}/${attachment.fileName}';

      if (mimeType.contains("image") && UrlHelper.isValidUrl(attachmentUrl)) {
        return ImagePostPreview(
          attachmentUrl: attachmentUrl,
          postBody: widget.postEntity.body ?? '',
          userEntity: widget.postEntity.creator,
        );
      } else if (mimeType.contains("video") &&
          UrlHelper.isValidUrl(attachmentUrl)) {
        return VideoPostPreview(
          videoUrl: attachmentUrl,
          postBody: widget.postEntity.body ?? '',
          userEntity: widget.postEntity.creator,
        );
      } else {
        return const SizedBox.shrink(); // Return empty if unknown type
      }
    }
    return const SizedBox.shrink();
    // else if (extractedUrls.isNotEmpty)
    //   LinkPreviewer(url: extractedUrls.first)
    // else
    //   const SizedBox.shrink(),
  }
}
