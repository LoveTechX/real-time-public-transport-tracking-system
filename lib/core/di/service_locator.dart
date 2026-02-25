import 'package:firebase_auth/firebase_auth.dart';
import '../../features/auth/data/auth_repository_impl.dart';
import '../../features/auth/domain/auth_repository.dart';
import '../../features/auth/presentation/auth_controller.dart';

class ServiceLocator {
  static final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  static final AuthRepository _authRepository =
      AuthRepositoryImpl(_firebaseAuth);

  static final AuthController authController =
      AuthController(_authRepository);
}