import 'package:tafaling/features/post/data/models/attachment_model.dart';
import 'package:tafaling/features/post/data/models/post_model.dart';
import 'package:tafaling/features/user/data/models/user_model.dart';

const jsonPosts = [
  {
    "postId": 129,
    "userId": 48,
    "body": "https://youtu.be/_j5dQshrD5Y?si=kXPAJATEYYlaVx1p",
    "privacyId": 1,
    "createdBy": 48,
    "creator": {
      "user_id": 48,
      "name": "Juliet",
      "user_name": "juliet",
      "email": "julietsarkar2006@gmail.com",
      "profile_picture":
          "https://devapi.tafaling.com/storage/users/profile/6g2Sne78KmdhV7lXiOIxB7b85EPyzgnoSVtnlGHF.jpg",
      "cover_photo":
          "https://devapi.tafaling.com/storage/users/cover/ycwEXmDrgYJdavk4Q0Nupj62d8PFUX4A9sADvXkb.jpg",
      "email_verified_at": null,
      "followers": 1,
      "following": 0,
      "total_like_count": 0,
      "is_following": false
    },
    "attachments": [],
    "likeCount": 1,
    "createdAt": "2025-03-10 04:56:51",
    "expireDate": "2026-03-10 04:56:51",
    "isLiked": 0
  },
  {
    "postId": 109,
    "userId": 41,
    "body": null,
    "privacyId": 1,
    "createdBy": 41,
    "creator": {
      "user_id": 41,
      "name": "Alauddin Mallik",
      "user_name": "alauddin_mallik",
      "email": "mallikbd@gmail.com",
      "profile_picture": null,
      "cover_photo": null,
      "email_verified_at": null,
      "followers": 2,
      "following": 1,
      "total_like_count": 0,
      "is_following": false
    },
    "attachments": [
      {
        "postId": 109,
        "fileURL": "https://devapi.tafaling.com/storage/posts/images",
        "fileName": "qpkoBUMkSLewhSwWGNn0FJU4m2JKzxxRSu3X2WHr.png",
        "mimeType": "image/png",
        "attachmentId": 77
      }
    ]
  }
];

List<PostModel> posts =
    jsonPosts.map((json) => PostModel.fromJson(json)).toList();

const postModels = [
  PostModel(
      id: 1,
      userId: 1,
      body:
          "Lorem ipsum is typically a corrupted version of De finibus bonorum et malorum, a 1st-century BC text by the Roman statesman and philosopher Cicero, with words altered, added, and removed to make it nonsensical and improper Latin. The first two words themselves are a truncation of dolorem ipsum",
      privacyId: 1,
      createdBy: 1,
      creator: UserModel(
          id: 1,
          name: "John Doe",
          userName: "John Doe",
          email: "john.doe@email.com",
          profilePicture:
              "https://t3.ftcdn.net/jpg/00/35/66/46/360_F_35664648_N33kGk5LKODV6A9Hq5cqDaU9X2VwTPmg.jpg",
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
      ],
      likeCount: 0,
      createdAt: "",
      expireDate: "",
      isLiked: false),
  PostModel(
      id: 1,
      userId: 1,
      body:
          "Lorem ipsum is typically a https://www.facebook.com/share/p/1BvppbxsNt/ corrupted version of De finibus https://youtu.be/RhXh09PMI1I?si=xXzSq25Xz9ELWapc bonorum et malorum, a 1st-century BC text by the Roman statesman and philosopher Cicero, with words altered, added, and removed to make it nonsensical and improper Latin. The first two words themselves are a truncation of dolorem ipsum",
      privacyId: 1,
      createdBy: 1,
      creator: UserModel(
          id: 1,
          name: "John Doe",
          userName: "John Doe",
          email: "john.doe@email.com",
          profilePicture:
              "https://i.pinimg.com/236x/8a/f0/c7/8af0c73b925ce833fde73c074c5c78b1.jpg",
          followers: 5,
          following: 2,
          totalLikeCount: 10,
          isFollowing: true),
      attachments: [],
      likeCount: 0,
      createdAt: "",
      expireDate: "",
      isLiked: false),
  PostModel(
      id: 1,
      userId: 1,
      body:
          "Lorem ipsum is typically a corrupted version of De finibus bonorum et malorum, a 1st-century BC text by the Roman statesman and philosopher Cicero, with words altered, added, and removed to make it nonsensical and improper Latin. The first two words themselves are a truncation of dolorem ipsum",
      privacyId: 1,
      createdBy: 1,
      creator: UserModel(
          id: 1,
          name: "John Doe",
          userName: "John Doe",
          email: "john.doe@email.com",
          profilePicture:
              "https://www.shutterstock.com/image-photo/leopard-portrait-600nw-106640027.jpg",
          followers: 5,
          following: 2,
          totalLikeCount: 10,
          isFollowing: true),
      attachments: [
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
            updatedAt: ""),
      ],
      likeCount: 0,
      createdAt: "",
      expireDate: "",
      isLiked: false)
];
