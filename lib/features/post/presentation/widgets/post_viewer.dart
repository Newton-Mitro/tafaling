import 'package:flutter/material.dart';
import 'package:photo_view_v3/photo_view.dart';
import 'package:tafaling/features/post/presentation/widgets/sidebar_widget.dart';

class PostViewer extends StatefulWidget {
  final String imageUrl;
  const PostViewer({super.key, required this.imageUrl});

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
    if (_pageController.page! < itemCount - 1) {
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
            itemCount:
                itemCount, // This should be dynamically set based on your data
            onPageChanged: (index) {},
            itemBuilder: (context, index) {
              return Container(
                  child: Stack(
                alignment: Alignment.centerRight,
                children: [
                  PhotoView(
                    backgroundDecoration: BoxDecoration(
                      color: Colors.transparent,
                    ),
                    imageProvider: NetworkImage(widget.imageUrl),
                    loadingBuilder: (context, event) => Center(
                      child: Container(
                        width: 20.0,
                        height: 20.0,
                        child: CircularProgressIndicator(),
                      ),
                    ),
                  ),
                  Text(
                    "$index",
                    style: TextStyle(fontSize: 50, color: Colors.lightGreen),
                  ),
                ],
              ));
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
