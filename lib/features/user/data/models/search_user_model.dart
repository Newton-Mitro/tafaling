import 'package:tafaling/features/user/domain/entities/search_user_entity.dart';

class SearchUserModel extends SearchUserEntity {
  const SearchUserModel({
    required super.userId,
    required super.userName,
    required super.email,
    super.firstName,
    super.lastName,
    super.dateOfBirth,
    required super.profilePicture,
    required super.coverPhoto,
    super.gender,
    super.registrationDate,
    super.countryId,
    super.privacySettingId,
    required super.name,
    required super.following,
    required super.followers,
    required super.isFollowing,
  });

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
