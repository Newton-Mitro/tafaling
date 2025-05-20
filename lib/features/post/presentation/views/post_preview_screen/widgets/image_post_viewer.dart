import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:photo_view/photo_view.dart';

class ImagePostViewer extends StatelessWidget {
  final String attachmentUrl;

  const ImagePostViewer({super.key, required this.attachmentUrl});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent, // <-- Makes background transparent
      child: Center(
        child: PhotoView(
          backgroundDecoration: const BoxDecoration(
            color:
                Colors
                    .transparent, // <-- Ensures the image viewer has a transparent background
          ),
          enablePanAlways: true,
          loadingBuilder:
              (context, event) => const Center(
                child: SizedBox(
                  width: 20.0,
                  height: 20.0,
                  child: CircularProgressIndicator(),
                ),
              ),
          imageProvider: CachedNetworkImageProvider(attachmentUrl),
          errorBuilder:
              (context, error, stackTrace) =>
                  Image.asset('assets/images/misc/no_preview.png'),
        ),
      ),
    );
  }
}
