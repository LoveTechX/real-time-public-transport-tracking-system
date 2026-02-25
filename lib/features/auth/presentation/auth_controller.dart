import '../domain/auth_repository.dart';

class AuthController {
  final AuthRepository _repository;

  AuthController(this._repository);

  Future<void> login(String email, String password) async {
    await _repository.login(email: email, password: password);
  }

  Future<void> logout() async {
    await _repository.logout();
  }
}