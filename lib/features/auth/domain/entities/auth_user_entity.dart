import 'package:equatable/equatable.dart';
import 'package:tafaling/features/user/domain/entities/user_entity.dart';

class AuthUserEntity extends Equatable {
  final String accessToken;
  final String refreshToken;
  final UserEntity user;

  const AuthUserEntity(
      {required this.accessToken,
      required this.refreshToken,
      required this.user});

  @override
  List<Object?> get props => [accessToken, refreshToken, user];
}
