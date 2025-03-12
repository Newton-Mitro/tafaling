class SearchUserModel {
  final int userId;
  final String? userName;
  final String email;
  final String? firstName;
  final String? lastName;
  final String? dateOfBirth;
  final String? profilePicture;
  final String? coverPhoto;
  final String? gender;
  final String? registrationDate;
  final int? countryId;
  final int? privacySettingId;
  final String name;
  final int following;
  final int followers;
  final bool isFollowing;

  SearchUserModel({
    required this.userId,
    required this.userName,
    required this.email,
    this.firstName,
    this.lastName,
    this.dateOfBirth,
    required this.profilePicture,
    required this.coverPhoto,
    this.gender,
    this.registrationDate,
    this.countryId,
    this.privacySettingId,
    required this.name,
    required this.following,
    required this.followers,
    required this.isFollowing,
  });

  // Factory method to create an instance from JSON
  factory SearchUserModel.fromJson(Map<String, dynamic> json) {
    return SearchUserModel(
      userId: json['userId'] as int,
      userName: json['userName'] as String?,
      email: json['email'] as String,
      firstName: json['firstName'] as String?,
      lastName: json['lastName'] as String?,
      dateOfBirth: json['dateOfBirth'] as String?,
      profilePicture: json['profilePicture'] as String?,
      coverPhoto: json['coverPhoto'] as String?,
      gender: json['gender'] as String?,
      registrationDate: json['registrationDate'] as String?,
      countryId: json['countryId'] as int?,
      privacySettingId: json['PrivacySettingId'] as int?,
      name: json['name'] as String,
      following: json['following'] as int,
      followers: json['followers'] as int,
      isFollowing: json['isFollowing'] as bool,
    );
  }

  // Method to convert the object to JSON
  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'userName': userName,
      'email': email,
      'firstName': firstName,
      'lastName': lastName,
      'dateOfBirth': dateOfBirth,
      'profilePicture': profilePicture,
      'coverPhoto': coverPhoto,
      'gender': gender,
      'registrationDate': registrationDate,
      'countryId': countryId,
      'PrivacySettingId': privacySettingId,
      'name': name,
      'following': following,
      'followers': followers,
      'isFollowing': isFollowing,
    };
  }

  // CopyWith method to create a new instance with some fields modified
  SearchUserModel copyWith({
    int? userId,
    String? userName,
    String? email,
    String? firstName,
    String? lastName,
    String? dateOfBirth,
    String? profilePicture,
    String? coverPhoto,
    String? gender,
    String? registrationDate,
    int? countryId,
    int? privacySettingId,
    String? name,
    int? following,
    int? followers,
    bool? isFollowing,
  }) {
    return SearchUserModel(
      userId: userId ?? this.userId,
      userName: userName ?? this.userName,
      email: email ?? this.email,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      profilePicture: profilePicture ?? this.profilePicture,
      coverPhoto: coverPhoto ?? this.coverPhoto,
      gender: gender ?? this.gender,
      registrationDate: registrationDate ?? this.registrationDate,
      countryId: countryId ?? this.countryId,
      privacySettingId: privacySettingId ?? this.privacySettingId,
      name: name ?? this.name,
      following: following ?? this.following,
      followers: followers ?? this.followers,
      isFollowing: isFollowing ?? this.isFollowing,
    );
  }
}
