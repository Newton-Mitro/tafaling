import 'package:flutter/material.dart';
import 'package:tafaling/core/utils/url_helper.dart';
import 'package:tafaling/features/post/domain/entities/post_entity.dart';
import 'package:tafaling/features/post/presentation/widgets/image_post_viewer.dart';
import 'package:tafaling/features/post/presentation/widgets/link_post_viewer.dart';
import 'package:tafaling/features/post/presentation/widgets/post_body_text.dart';
import 'package:tafaling/features/post/presentation/widgets/post_sidebar.dart';
import 'package:tafaling/features/post/presentation/widgets/video_post_viewer.dart';

class PostViewer extends StatefulWidget {
  final PostEntity postModel;
  const PostViewer({super.key, required this.postModel});

  @override
  State<PostViewer> createState() => _PostViewerState();
}

class _PostViewerState extends State<PostViewer> {
  late final PageController _attachmentController;

  @override
  void initState() {
    super.initState();
    _attachmentController = PageController(initialPage: 0);
  }

  @override
  void dispose() {
    _attachmentController.dispose();
    super.dispose();
  }

  void _previousPage() {
    if (_attachmentController.page != null && _attachmentController.page! > 0) {
      _attachmentController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _nextPage() {
    if (_attachmentController.page != null &&
        _attachmentController.page! < widget.postModel.attachments.length - 1) {
      _attachmentController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final int attachmentCount = widget.postModel.attachments.length;
    final List<String> extractedUrls = UrlHelper.extractUrls(
      widget.postModel.body ?? '',
    );

    return Stack(
      children: [
        if (attachmentCount > 0)
          PageView.builder(
            scrollDirection: Axis.horizontal,
            controller: _attachmentController,
            itemCount: attachmentCount,
            itemBuilder: (context, index) {
              final attachment = widget.postModel.attachments[index];
              final mimeType = attachment.mimeType.toLowerCase();

              if (mimeType.contains("image")) {
                return ImagePostViewer(
                  attachmentUrl: '${attachment.fileURL}/${attachment.fileName}',
                );
              } else if (mimeType.contains("video")) {
                return VideoPostViewer(
                  attachmentUrl: '${attachment.fileURL}/${attachment.fileName}',
                  autoPlay: true,
                );
              } else {
                return const SizedBox.shrink(); // Return empty if unknown type
              }
            },
          )
        else if (extractedUrls.isNotEmpty)
          LinkPreviewer(url: extractedUrls.first)
        else
          const SizedBox.shrink(), // Show nothing if no URL is available
        // Navigation Arrows (Only if multiple attachments exist)
        if (attachmentCount > 1) ...[
          Positioned(
            left: 5,
            top: MediaQuery.of(context).size.height / 2 - 20,
            child: IconButton(
              icon: const Icon(Icons.arrow_left, size: 45, color: Colors.grey),
              onPressed: _previousPage,
            ),
          ),
          Positioned(
            right: 5,
            top: MediaQuery.of(context).size.height / 2 - 20,
            child: IconButton(
              icon: const Icon(Icons.arrow_right, size: 45, color: Colors.grey),
              onPressed: _nextPage,
            ),
          ),
        ],

        PostBodyText(postModel: widget.postModel),
        PostSidebar(postModel: widget.postModel),
      ],
    );
  }
}
