import 'package:flutter/material.dart';
import 'package:tafaling/core/widgets/my_bottom_navigation_bar/states/notifiers.dart';
import 'package:tafaling/features/auth/data/models/user_model.dart';
import 'package:tafaling/features/post/data/models/attachment_model.dart';
import 'package:tafaling/features/post/data/models/post_model.dart';
import 'package:tafaling/features/post/presentation/widgets/post_body.dart';
import 'package:tafaling/features/post/presentation/widgets/post_viewer.dart';
import 'package:tafaling/features/post/presentation/widgets/top_navigation.dart';

const postModels = [
  PostModel(
      postId: 1,
      userId: 1,
      body:
          "Lorem ipsum is typically a corrupted version of De finibus bonorum et malorum, a 1st-century BC text by the Roman statesman and philosopher Cicero, with words altered, added, and removed to make it nonsensical and improper Latin. The first two words themselves are a truncation of dolorem ipsum",
      privacyId: 1,
      createdBy: 1,
      creator: UserModel(
          userId: 1,
          name: "John Doe",
          userName: "John Doe",
          email: "john.doe@email.com",
          followers: 5,
          following: 2,
          totalLikeCount: 10,
          isFollowing: true),
      attachments: [
        AttachmentModel(
            attachmentId: 1,
            postId: 1,
            fileName: "360_F_266724172_Iy8gdKgMa7XmrhYYxLCxyhx6J7070Pr8.jpg",
            filePath: "https://t4.ftcdn.net/jpg/02/66/72/41/",
            fileURL: "https://t4.ftcdn.net/jpg/02/66/72/41/",
            mimeType: "Image/jpg",
            createdBy: 1,
            likeCount: 0,
            viewCount: 0,
            shareCount: 0,
            createdAt: "",
            updatedAt: ""),
        AttachmentModel(
            attachmentId: 2,
            postId: 2,
            fileName: "kitty-cat-kitten-pet-45201.jpeg",
            filePath: "https://images.pexels.com/photos/45201/",
            fileURL: "https://images.pexels.com/photos/45201/",
            mimeType: "Image/jpg",
            createdBy: 1,
            likeCount: 0,
            viewCount: 0,
            shareCount: 0,
            createdAt: "",
            updatedAt: "")
      ],
      likeCount: 0,
      createdAt: "",
      expireDate: "",
      isLiked: false),
  PostModel(
      postId: 1,
      userId: 1,
      body:
          "Lorem ipsum is typically a corrupted version of De finibus bonorum et malorum, a 1st-century BC text by the Roman statesman and philosopher Cicero, with words altered, added, and removed to make it nonsensical and improper Latin. The first two words themselves are a truncation of dolorem ipsum",
      privacyId: 1,
      createdBy: 1,
      creator: UserModel(
          userId: 1,
          name: "John Doe",
          userName: "John Doe",
          email: "john.doe@email.com",
          followers: 5,
          following: 2,
          totalLikeCount: 10,
          isFollowing: true),
      attachments: [
        AttachmentModel(
            attachmentId: 2,
            postId: 2,
            fileName: "bee.mp4",
            filePath:
                "https://flutter.github.io/assets-for-api-docs/assets/videos/",
            fileURL:
                "https://flutter.github.io/assets-for-api-docs/assets/videos/",
            mimeType: "Video/mp4",
            createdBy: 1,
            likeCount: 0,
            viewCount: 0,
            shareCount: 0,
            createdAt: "",
            updatedAt: ""),
        AttachmentModel(
            attachmentId: 1,
            postId: 1,
            fileName: "BigBuckBunny.mp4",
            filePath:
                "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/",
            fileURL:
                "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/",
            mimeType: "Video/mp4",
            createdBy: 1,
            likeCount: 0,
            viewCount: 0,
            shareCount: 0,
            createdAt: "",
            updatedAt: ""),
      ],
      likeCount: 0,
      createdAt: "",
      expireDate: "",
      isLiked: false)
];

class PostsScreen extends StatefulWidget {
  const PostsScreen({super.key});

  @override
  State<PostsScreen> createState() => _PostsScreenState();
}

class _PostsScreenState extends State<PostsScreen> {
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: selectedPostNotifier.value);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: selectedPostNotifier,
      builder: (context, selectedPost, child) {
        return Stack(
          children: [
            PageView.builder(
              scrollDirection: Axis.vertical,
              controller: _pageController,
              itemCount: postModels.length,
              onPageChanged: (index) {
                selectedPostNotifier.value = index;
              },
              itemBuilder: (context, index) {
                return Stack(
                  children: [
                    PostViewer(
                      postModel: postModels[index],
                    ),
                    PostBody(
                      postModel: postModels[index],
                    ),
                  ],
                );
              },
            ),
            TopNavigation(),
          ],
        );
      },
    );
  }
}
