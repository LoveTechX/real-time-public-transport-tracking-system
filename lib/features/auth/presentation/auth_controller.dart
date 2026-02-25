import 'package:firebase_auth/firebase_auth.dart';
import '../data/auth_repository_impl.dart';

class AuthController {
  late final AuthRepositoryImpl _repository;

  AuthController() {
    _repository = AuthRepositoryImpl(FirebaseAuth.instance);
  }

  Future<void> login(String email, String password) async {
    await _repository.login(email: email, password: password);
  }

  Future<void> logout() async {
    await _repository.logout();
  }
}
