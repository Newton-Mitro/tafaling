import 'package:flutter/material.dart';
import 'package:any_link_preview/any_link_preview.dart';
import 'package:tafaling/core/utils/url_extractor.dart';
import 'package:tafaling/features/post/presentation/widgets/youtube_video_player.dart';

class LinkPreviewer extends StatefulWidget {
  final String url;

  const LinkPreviewer({super.key, required this.url});

  @override
  State<LinkPreviewer> createState() => _LinkPreviewerState();
}

class _LinkPreviewerState extends State<LinkPreviewer> {
  Metadata? _metadata;
  bool _isLoading = true;
  bool _hasError = false;

  @override
  void initState() {
    super.initState();
    if (!UrlExtractor.isYouTubeUrl(widget.url)) {
      _fetchMetadata();
    }
  }

  Future<void> _fetchMetadata() async {
    try {
      final metadata = await AnyLinkPreview.getMetadata(
        link: widget.url,
        cache: const Duration(days: 2),
        proxyUrl:
            "https://thingproxy.freeboard.io/fetch/", // Needed for web support
      );

      if (mounted) {
        setState(() {
          _metadata = metadata;
          _isLoading = false;
          _hasError = metadata == null; // Mark error if metadata is null
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isLoading = false;
          _hasError = true;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (UrlExtractor.isYouTubeUrl(widget.url)) {
      return Container(
        alignment: Alignment.center,
        child: YouTubeVideoPlayer(videoUrl: widget.url),
      );
    }

    return _isLoading
        ? const Center(child: CircularProgressIndicator())
        : _hasError
            ? _buildErrorWidget()
            : _buildPreviewWidget();
  }

  Widget _buildErrorWidget() {
    return Container(
        alignment: Alignment.center,
        child: Image.asset('assets/images/misc/no_preview.png'));
  }

  Widget _buildPreviewWidget() {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (_metadata?.image != null)
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                _metadata!.image!,
                fit: BoxFit.cover,
                width: double.infinity,
                height: 200,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    width: double.infinity,
                    height: 200,
                    color: Colors.grey[300],
                    alignment: Alignment.center,
                    child: const Icon(
                      Icons.broken_image,
                      size: 50,
                      color: Colors.grey,
                    ),
                  );
                },
              ),
            ),
          const SizedBox(height: 8),
          if (_metadata?.title != null)
            Text(
              _metadata!.title!,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          if (_metadata?.desc != null)
            Text(
              _metadata!.desc!,
              style: const TextStyle(fontSize: 14),
            ),
          Text(
            widget.url,
            style: const TextStyle(
              fontSize: 12,
              color: Colors.blue,
            ),
          ),
        ],
      ),
    );
  }
}
