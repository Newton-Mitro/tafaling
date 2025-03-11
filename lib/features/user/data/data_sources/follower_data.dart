import 'package:tafaling/features/user/data/models/user_model.dart';

final List<Map<String, dynamic>> jsonFollowers = [
  {
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
  {
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
    "is_following": true
  },
  {
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
  }
];

List<UserModel> myFollowers =
    jsonFollowers.map((json) => UserModel.fromJson(json)).toList();
