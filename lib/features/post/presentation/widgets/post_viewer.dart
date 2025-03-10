import 'package:flutter/material.dart';
import 'package:tafaling/core/utils/url_extractor.dart';
import 'package:tafaling/features/post/data/models/post_model.dart';
import 'package:tafaling/features/post/presentation/widgets/image_post_viewer.dart';
import 'package:tafaling/features/post/presentation/widgets/link_preview.dart';
import 'package:tafaling/features/post/presentation/widgets/post_body.dart';
import 'package:tafaling/features/post/presentation/widgets/sidebar_widget.dart';
import 'package:tafaling/features/post/presentation/widgets/video_post_viewer.dart';

class PostViewer extends StatefulWidget {
  final PostModel postModel;
  const PostViewer({super.key, required this.postModel});

  @override
  State<PostViewer> createState() => _PostViewerState();
}

class _PostViewerState extends State<PostViewer> {
  late final PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _previousPage() {
    if (_pageController.page != null && _pageController.page! > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _nextPage() {
    if (_pageController.page != null &&
        _pageController.page! < widget.postModel.attachments.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final int attachmentCount = widget.postModel.attachments.length;
    final List<String> extractedUrls =
        UrlExtractor.extractUrls(widget.postModel.body ?? '');

    return Stack(
      children: [
        if (attachmentCount > 0)
          PageView.builder(
            scrollDirection: Axis.horizontal,
            controller: _pageController,
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

        PostBody(postModel: widget.postModel),
        SidebarWidget(postModel: widget.postModel),
      ],
    );
  }
}
