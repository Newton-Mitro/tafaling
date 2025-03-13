class SearchUserEntity {
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
}
