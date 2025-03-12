import 'package:cached_network_image_plus/flutter_cached_network_image_plus.dart';
import 'package:flutter/material.dart';

class ImagePostViewer extends StatelessWidget {
  final String attachmentUrl;
  const ImagePostViewer({super.key, required this.attachmentUrl});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: CacheNetworkImagePlus(
        imageUrl: attachmentUrl,
        errorWidget: Image.asset('assets/images/misc/no_preview.png'),
      ),
    );
  }
}
