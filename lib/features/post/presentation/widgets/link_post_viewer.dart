import 'package:flutter/material.dart';
import 'package:flutter_link_previewer/flutter_link_previewer.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' show PreviewData;
import 'package:tafaling/core/utils/url_extractor.dart';
import 'package:tafaling/features/post/presentation/widgets/youtube_video_player.dart';

class LinkPreviewer extends StatefulWidget {
  final String url;

  const LinkPreviewer({super.key, required this.url});

  @override
  State<LinkPreviewer> createState() => _LinkPreviewerState();
}

class _LinkPreviewerState extends State<LinkPreviewer> {
  Map<String, PreviewData?> datas = {};

  @override
  Widget build(BuildContext context) {
    return UrlExtractor.isYouTubeUrl(widget.url)
        ? Container(
            alignment: Alignment.center,
            child: YouTubeVideoPlayer(
              videoUrl: widget.url,
            ),
          )
        : Container(
            alignment: Alignment.center,
            child: LinkPreview(
              enableAnimation: true,
              onPreviewDataFetched: (data) {
                setState(() {
                  datas[widget.url] = data;
                });
              },
              previewData: datas[widget.url],
              text: widget.url,
              width: MediaQuery.of(context).size.width,
              previewBuilder: (context, previewData) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Extract the image URL from previewData.image and use it in Image.network
                    if (previewData.image != null)
                      ClipRRect(
                        borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(10)),
                        child: Image.network(
                          previewData.image!
                              .url, // Use `.url` to get the image URL string
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: 200,
                        ),
                      ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          if (previewData.title != null)
                            Text(
                              previewData.title!,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          if (previewData.description != null)
                            Text(
                              previewData.description!,
                              style: const TextStyle(fontSize: 14),
                            ),
                          Text(
                            widget.url,
                            style: const TextStyle(
                                fontSize: 12, color: Colors.blue),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
          );
  }
}
