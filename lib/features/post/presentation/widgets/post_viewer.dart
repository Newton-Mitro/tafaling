import 'package:flutter/material.dart';
import 'package:tafaling/features/post/data/models/post_model.dart';
import 'package:tafaling/features/post/presentation/widgets/image_post_viewer.dart';
import 'package:tafaling/features/post/presentation/widgets/sidebar_widget.dart';
import 'package:tafaling/features/post/presentation/widgets/video_post_viewer.dart';

class PostViewer extends StatefulWidget {
  final PostModel postModel;
  const PostViewer({super.key, required this.postModel});

  @override
  State<PostViewer> createState() => _PostViewerState();
}

class _PostViewerState extends State<PostViewer> {
  late PageController _pageController;
  late int itemCount = 10;

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
    if (_pageController.page! > 0) {
      _pageController.previousPage(
          duration: Duration(milliseconds: 300), curve: Curves.easeInOut);
    }
  }

  void _nextPage() {
    if (_pageController.page! < widget.postModel.attachments.length - 1) {
      _pageController.nextPage(
          duration: Duration(milliseconds: 300), curve: Curves.easeInOut);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          PageView.builder(
            scrollDirection: Axis.horizontal,
            controller: _pageController,
            itemCount: widget.postModel.attachments.length,
            onPageChanged: (index) {},
            itemBuilder: (context, index) {
              if (widget.postModel.attachments[index].mimeType
                  .contains("Image")) {
                return ImagePostViewer(
                  attachmentUrl: widget.postModel.attachments[index].fileURL +
                      widget.postModel.attachments[index].fileName,
                );
              } else if (widget.postModel.attachments[index].mimeType
                  .contains("Video")) {
                return VideoPostViewer(
                  attachmentUrl: widget.postModel.attachments[index].fileURL +
                      widget.postModel.attachments[index].fileName,
                );
              } else {
                return Container(
                  color: Colors.transparent,
                );
              }
            },
          ),
          // Only show arrows if itemCount > 1
          if (itemCount > 1)
            Positioned(
              left: 5,
              top: MediaQuery.of(context).size.height / 2 - 20,
              child: IconButton(
                icon: Icon(
                  Icons.arrow_left,
                  size: 45,
                  color: Color.fromARGB(46, 255, 135, 135),
                ),
                onPressed: _previousPage,
              ),
            ),
          if (itemCount > 1)
            Positioned(
              right: 5,
              top: MediaQuery.of(context).size.height / 2 - 20,
              child: IconButton(
                icon: Icon(
                  Icons.arrow_right,
                  size: 45,
                  color: Color.fromARGB(46, 255, 135, 135),
                ),
                onPressed: _nextPage,
              ),
            ),
          SidebarWidget(post: null)
        ],
      ),
    );
  }
}
