import 'dart:io';

import 'package:flutter/material.dart';

class PreviewPage extends StatelessWidget {
  final String filePath;
  final String fileType; // "image" or "video"

  const PreviewPage({
    super.key,
    required this.filePath,
    required this.fileType,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Preview")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text("File Path: $filePath"),
            Text("File Type: $fileType"),
            const SizedBox(height: 20),
            if (fileType == "image")
              Image.file(File(filePath), height: 300, fit: BoxFit.contain)
            else if (fileType == "video")
              // For video preview you may want to use a package like video_player
              Text("Video preview is not implemented."),
          ],
        ),
      ),
    );
  }
}
