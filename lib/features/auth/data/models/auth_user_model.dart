import 'package:tafaling/features/auth/domain/entities/auth_user_entity.dart';
import 'package:tafaling/features/user/data/models/user_model.dart';

class AuthUserModel extends AuthUserEntity {
  const AuthUserModel({
    required super.accessToken,
    required super.refreshToken,
    required super.user,
  });

  factory AuthUserModel.fromJson(Map<String, dynamic> json) {
    return AuthUserModel(
      accessToken: json['access_token'] ?? "",
      refreshToken: json['refresh_token'] ?? "",
      user: UserModel.fromJson(json["user"] ?? {}),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'accessToken': accessToken,
      'refreshToken': refreshToken,
      "user": (user as UserModel).toJson(),
    };
  }

  AuthUserModel copyWith({
    String? accessToken,
    String? refreshToken,
    UserModel? user,
  }) {
    return AuthUserModel(
      accessToken: accessToken ?? this.accessToken,
      refreshToken: refreshToken ?? this.refreshToken,
      user: user ?? this.user,
    );
  }
}
