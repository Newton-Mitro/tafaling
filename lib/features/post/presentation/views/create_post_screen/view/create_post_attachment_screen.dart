import 'dart:async';
import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:image_picker/image_picker.dart';
import 'package:saver_gallery/saver_gallery.dart';
import 'package:tafaling/features/post/presentation/views/create_post_screen/view/create_post_body_screen.dart';

class CreatePostAttachmentScreen extends StatefulWidget {
  const CreatePostAttachmentScreen({super.key});

  @override
  State<CreatePostAttachmentScreen> createState() =>
      _CreatePostAttachmentScreenState();
}

class _CreatePostAttachmentScreenState
    extends State<CreatePostAttachmentScreen> {
  late List<CameraDescription> _cameras;
  CameraController? _controller;
  bool _isRecording = false;
  bool _isCameraInitialized = false;
  int _selectedCameraIndex = 0;
  final ImagePicker _imagePicker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _initCamera();
  }

  Future<void> _initCamera() async {
    final cameraStatus = await Permission.camera.request();
    final micStatus = await Permission.microphone.request();
    final storageStatus = await Permission.photos.request();

    if (!cameraStatus.isGranted ||
        !micStatus.isGranted ||
        !storageStatus.isGranted) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              "Camera, microphone, and gallery permissions are required",
            ),
          ),
        );
      }
      return;
    }

    try {
      _cameras = await availableCameras();
      if (_cameras.isEmpty) {
        debugPrint("No cameras available");
        return;
      }

      _controller = CameraController(
        _cameras[_selectedCameraIndex],
        ResolutionPreset.high,
      );
      await _controller!.initialize();

      if (mounted) {
        setState(() {
          _isCameraInitialized = true;
        });
      }
    } catch (e) {
      debugPrint("Camera initialization error: $e");
    }
  }

  Future<void> _switchCamera() async {
    if (_cameras.length < 2) return;

    _selectedCameraIndex = (_selectedCameraIndex + 1) % _cameras.length;
    _controller = CameraController(
      _cameras[_selectedCameraIndex],
      ResolutionPreset.high,
    );

    try {
      await _controller!.initialize();
      if (mounted) setState(() {});
    } catch (e) {
      debugPrint("Error switching camera: $e");
    }
  }

  Future<void> _takePhoto() async {
    if (!(_controller?.value.isInitialized ?? false) ||
        (_controller?.value.isTakingPicture ?? true)) {
      return;
    }

    try {
      final file = await _controller!.takePicture();

      // Read file bytes
      final bytes = await File(file.path).readAsBytes();

      // Save image to gallery using saver_gallery
      final saved = await SaverGallery.saveImage(
        bytes,
        fileName: "photo_${DateTime.now().millisecondsSinceEpoch}.jpg",
        androidRelativePath: "Pictures/MyAppImages",
        quality: 100,
        extension: "jpg",
        skipIfExists: false,
      );

      debugPrint("Image saved result: $saved");

      if (mounted) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder:
                (_) => CreatePostBodyScreen(
                  filePath: file.path,
                  fileType: "image",
                ),
          ),
        );
      }
    } catch (e) {
      debugPrint("Error taking photo: $e");
    }
  }

  Future<void> _startVideoRecording() async {
    if (!(_controller?.value.isInitialized ?? false) ||
        (_controller?.value.isRecordingVideo ?? true)) {
      return;
    }

    try {
      await _controller!.startVideoRecording();
      if (mounted) setState(() => _isRecording = true);
    } catch (e) {
      debugPrint("Error starting video: $e");
    }
  }

  Future<void> _stopVideoRecording() async {
    if (!(_controller?.value.isRecordingVideo ?? false)) {
      debugPrint("No video recording in progress to stop.");
      return;
    }

    try {
      debugPrint("Stopping video recording...");
      final file = await _controller!.stopVideoRecording();

      debugPrint("Video recording stopped, file saved at: ${file.path}");

      // Save video file to gallery using saver_gallery
      final saved = await SaverGallery.saveFile(
        filePath: file.path,
        fileName: "video_${DateTime.now().millisecondsSinceEpoch}.mp4",
        androidRelativePath: "Movies/MyAppVideos",
        skipIfExists: false,
      );

      debugPrint("Save to gallery result: $saved");

      if (mounted) {
        setState(() {
          _isRecording = false;
        });

        Navigator.push(
          context,
          MaterialPageRoute(
            builder:
                (_) => CreatePostBodyScreen(
                  filePath: file.path,
                  fileType: "video",
                ),
          ),
        );
      }
    } catch (e) {
      debugPrint("Error stopping video: $e");
    }
  }

  Future<void> _pickImageFromGallery() async {
    try {
      final pickedFile = await _imagePicker.pickImage(
        source: ImageSource.gallery,
      );
      if (pickedFile != null) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder:
                (_) => CreatePostBodyScreen(
                  filePath: pickedFile.path,
                  fileType: "image",
                ),
          ),
        );
      }
    } catch (e) {
      debugPrint("Error picking image: $e");
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!_isCameraInitialized) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Post Attachment')),
      body: CameraPreview(
        _controller!,
        child: Positioned(
          bottom: 40,
          left: 20,
          right: 20,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              FloatingActionButton(
                heroTag: 'switch',
                onPressed: _switchCamera,
                child: const Icon(Icons.switch_camera),
              ),
              FloatingActionButton(
                heroTag: 'photo',
                onPressed: _takePhoto,
                child: const Icon(Icons.camera_alt),
              ),
              FloatingActionButton(
                heroTag: 'video',
                backgroundColor: _isRecording ? Colors.red : Colors.blue,
                onPressed:
                    _isRecording ? _stopVideoRecording : _startVideoRecording,
                child: Icon(_isRecording ? Icons.stop : Icons.videocam),
              ),
              FloatingActionButton(
                heroTag: 'gallery',
                onPressed: _pickImageFromGallery,
                child: const Icon(Icons.photo_library),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
