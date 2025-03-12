import 'package:tafaling/features/auth/domain/repositories/auth_repository.dart';

class RegisterUseCase {
  final AuthRepository repository;

  RegisterUseCase(this.repository);

  Future<String> call(
      String name, String email, String password, String confirmPassword) {
    return repository.register(name, email, password, confirmPassword);
  }
}
