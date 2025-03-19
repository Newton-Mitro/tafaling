import 'package:equatable/equatable.dart';

class SearchUserEntity extends Equatable {
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

  const SearchUserEntity({
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

  SearchUserEntity copyWith({
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
    return SearchUserEntity(
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

  @override
  List<Object?> get props => [
    userId,
    userName,
    email,
    firstName,
    lastName,
    dateOfBirth,
    profilePicture,
    coverPhoto,
    gender,
    registrationDate,
    countryId,
    privacySettingId,
    name,
    following,
    followers,
    isFollowing,
  ];
}
