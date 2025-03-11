import 'package:tafaling/features/post/data/models/attachment_model.dart';
import 'package:tafaling/features/post/data/models/post_model.dart';
import 'package:tafaling/features/user/data/models/user_model.dart';

const jsonPosts = [
  {
    "postId": 133,
    "userId": 51,
    "body":
        "https://www.facebook.com/share/v/1EEHyjgC2c/?mibextid=wwXIfr Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum",
    "privacyId": 1,
    "createdBy": 51,
    "creator": {
      "user_id": 51,
      "name": "Countdown",
      "user_name": "countdown",
      "email": "atgaine@yahoo.com",
      "profile_picture": null,
      "cover_photo": null,
      "email_verified_at": null,
      "followers": 1,
      "following": 3,
      "total_like_count": 0,
      "is_following": false
    },
    "attachments": [],
    "likeCount": 0,
    "createdAt": "2025-03-10 19:49:38",
    "expireDate": "2026-03-10 19:49:38",
    "isLiked": 0
  },
  {
    "postId": 132,
    "userId": 50,
    "body": "https://www.facebook.com/reel/9311207522292673",
    "privacyId": 1,
    "createdBy": 50,
    "creator": {
      "user_id": 50,
      "name": "FunBuzz",
      "user_name": "funbuzz",
      "email": "daniel@workdirectory.ca",
      "profile_picture":
          "https://devapi.tafaling.com/storage/users/profile/hgXS2KY1nITVMMnJnGdJMXjgEdUc4DUcjjWlWmB9.jpg",
      "cover_photo":
          "https://devapi.tafaling.com/storage/users/cover/L9Nk6u6no2MLXuNlLTrlTGx2ZxY21kkDxt0tro7T.jpg",
      "email_verified_at": null,
      "followers": 0,
      "following": 19,
      "total_like_count": 0,
      "is_following": false
    },
    "attachments": [],
    "likeCount": 0,
    "createdAt": "2025-03-10 10:55:11",
    "expireDate": "2026-03-10 10:55:11",
    "isLiked": 0
  },
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
    "postId": 128,
    "userId": 48,
    "body": null,
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
    "attachments": [
      {
        "postId": 128,
        "fileURL": "https://devapi.tafaling.com/storage/posts/images",
        "fileName": "NxEnv5HoWnwzOuAbr5kcPXqyKLceFUQbgHCYLL3E.jpg",
        "mimeType": "image/jpeg",
        "attachmentId": 79
      }
    ],
    "likeCount": 1,
    "createdAt": "2025-03-10 04:53:42",
    "expireDate": "2026-03-10 04:53:42",
    "isLiked": 0
  },
  {
    "postId": 127,
    "userId": 48,
    "body":
        "Lorem Ipsum is simply Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum",
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
    "attachments": [
      {
        "postId": 127,
        "fileURL":
            "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample",
        "fileName": "BigBuckBunny.mp4",
        "mimeType": "video/mp4",
        "attachmentId": 78
      }
    ],
    "likeCount": 1,
    "createdAt": "2025-03-10 04:51:03",
    "expireDate": "2026-03-10 04:51:03",
    "isLiked": 0
  },
  {
    "postId": 126,
    "userId": 3,
    "body": "This looks cool",
    "privacyId": 1,
    "createdBy": 3,
    "creator": {
      "user_id": 3,
      "name": "Raven Quiah",
      "user_name": "raven_quiah",
      "email": "ravenmqh@gmail.com",
      "profile_picture":
          "https://devapi.tafaling.com/storage/users/profile/GWUnPV8QkArLidWGK48WBYRGm3OEVExdegokazD5.jpg",
      "cover_photo":
          "https://devapi.tafaling.com/storage/users/cover/yo0CKzqeXfzqIxbVD2j67rZm9AJPaujxqPkgf1ev.png",
      "email_verified_at": null,
      "followers": 8,
      "following": 3,
      "total_like_count": 0,
      "is_following": false
    },
    "attachments": [],
    "likeCount": 0,
    "createdAt": "2025-03-10 02:30:15",
    "expireDate": "2026-03-10 02:30:15",
    "isLiked": 0
  },
  {
    "postId": 125,
    "userId": 36,
    "body": "This looks cool",
    "privacyId": 1,
    "createdBy": 36,
    "creator": {
      "user_id": 36,
      "name": "Anthony",
      "user_name": "anthony",
      "email": "anthonydikcian007@gmail.com",
      "profile_picture":
          "https://devapi.tafaling.com/storage/users/profile/DXwZ7tfo70i7aTyoStDmtcBX1QtOOUgHbE0PdH8Q.jpg",
      "cover_photo": null,
      "email_verified_at": null,
      "followers": 5,
      "following": 5,
      "total_like_count": 0,
      "is_following": false
    },
    "attachments": [],
    "likeCount": 0,
    "createdAt": "2025-03-10 02:28:04",
    "expireDate": "2026-03-10 02:28:04",
    "isLiked": 0
  },
  {
    "postId": 124,
    "userId": 36,
    "body": "This looks cool",
    "privacyId": 1,
    "createdBy": 36,
    "creator": {
      "user_id": 36,
      "name": "Anthony",
      "user_name": "anthony",
      "email": "anthonydikcian007@gmail.com",
      "profile_picture":
          "https://devapi.tafaling.com/storage/users/profile/DXwZ7tfo70i7aTyoStDmtcBX1QtOOUgHbE0PdH8Q.jpg",
      "cover_photo": null,
      "email_verified_at": null,
      "followers": 5,
      "following": 5,
      "total_like_count": 0,
      "is_following": false
    },
    "attachments": [],
    "likeCount": 0,
    "createdAt": "2025-03-10 02:26:47",
    "expireDate": "2026-03-10 02:26:47",
    "isLiked": 0
  },
  {
    "postId": 120,
    "userId": 51,
    "body": "Nothing to think but action !!!",
    "privacyId": 1,
    "createdBy": 51,
    "creator": {
      "user_id": 51,
      "name": "Countdown",
      "user_name": "countdown",
      "email": "atgaine@yahoo.com",
      "profile_picture": null,
      "cover_photo": null,
      "email_verified_at": null,
      "followers": 1,
      "following": 3,
      "total_like_count": 0,
      "is_following": false
    },
    "attachments": [],
    "likeCount": 0,
    "createdAt": "2025-03-10 00:02:46",
    "expireDate": "2026-03-10 00:02:46",
    "isLiked": 0
  },
  {
    "postId": 114,
    "userId": 50,
    "body": "https://www.youtube.com/shorts/m6SeAfjrV_4",
    "privacyId": 1,
    "createdBy": 50,
    "creator": {
      "user_id": 50,
      "name": "FunBuzz",
      "user_name": "funbuzz",
      "email": "daniel@workdirectory.ca",
      "profile_picture":
          "https://devapi.tafaling.com/storage/users/profile/hgXS2KY1nITVMMnJnGdJMXjgEdUc4DUcjjWlWmB9.jpg",
      "cover_photo":
          "https://devapi.tafaling.com/storage/users/cover/L9Nk6u6no2MLXuNlLTrlTGx2ZxY21kkDxt0tro7T.jpg",
      "email_verified_at": null,
      "followers": 0,
      "following": 19,
      "total_like_count": 0,
      "is_following": false
    },
    "attachments": [],
    "likeCount": 0,
    "createdAt": "2025-03-09 06:09:41",
    "expireDate": "2026-03-09 06:09:41",
    "isLiked": 0
  },
  {
    "postId": 113,
    "userId": 50,
    "body": "https://www.youtube.com/shorts/wqzf8IGe-6w",
    "privacyId": 1,
    "createdBy": 50,
    "creator": {
      "user_id": 50,
      "name": "FunBuzz",
      "user_name": "funbuzz",
      "email": "daniel@workdirectory.ca",
      "profile_picture":
          "https://devapi.tafaling.com/storage/users/profile/hgXS2KY1nITVMMnJnGdJMXjgEdUc4DUcjjWlWmB9.jpg",
      "cover_photo":
          "https://devapi.tafaling.com/storage/users/cover/L9Nk6u6no2MLXuNlLTrlTGx2ZxY21kkDxt0tro7T.jpg",
      "email_verified_at": null,
      "followers": 0,
      "following": 19,
      "total_like_count": 0,
      "is_following": false
    },
    "attachments": [],
    "likeCount": 0,
    "createdAt": "2025-03-09 06:04:25",
    "expireDate": "2026-03-09 06:04:25",
    "isLiked": 0
  },
  {
    "postId": 112,
    "userId": 31,
    "body": "https://www.youtube.com/shorts/bhghAm_biGU",
    "privacyId": 1,
    "createdBy": 31,
    "creator": {
      "user_id": 31,
      "name": "Work Directory CA",
      "user_name": "Work Directory CA",
      "email": "info@WorkDirectory.ca",
      "profile_picture":
          "https://devapi.tafaling.com/storage/users/profile/bT2tAo10pcdkGkPHsTdT9H5YSX6wOHcgjSih0pmF.jpg",
      "cover_photo":
          "https://devapi.tafaling.com/storage/users/cover/bXABpi82LpQ6ljExUjhjkKurqe5x5xFp7hXoeFVj.jpg",
      "email_verified_at": null,
      "followers": 2,
      "following": 1,
      "total_like_count": 0,
      "is_following": false
    },
    "attachments": [],
    "likeCount": 0,
    "createdAt": "2025-03-09 05:58:01",
    "expireDate": "2026-03-09 05:58:01",
    "isLiked": 0
  },
  {
    "postId": 111,
    "userId": 31,
    "body": "https://www.youtube.com/watch?v=0QYiPYXkMNs",
    "privacyId": 1,
    "createdBy": 31,
    "creator": {
      "user_id": 31,
      "name": "Work Directory CA",
      "user_name": "Work Directory CA",
      "email": "info@WorkDirectory.ca",
      "profile_picture":
          "https://devapi.tafaling.com/storage/users/profile/bT2tAo10pcdkGkPHsTdT9H5YSX6wOHcgjSih0pmF.jpg",
      "cover_photo":
          "https://devapi.tafaling.com/storage/users/cover/bXABpi82LpQ6ljExUjhjkKurqe5x5xFp7hXoeFVj.jpg",
      "email_verified_at": null,
      "followers": 2,
      "following": 1,
      "total_like_count": 0,
      "is_following": false
    },
    "attachments": [],
    "likeCount": 0,
    "createdAt": "2025-03-09 05:27:11",
    "expireDate": "2026-03-09 05:27:11",
    "isLiked": 0
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
