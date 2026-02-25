import 'package:firebase_auth/firebase_auth.dart';
import '../../features/auth/data/auth_repository_impl.dart';
import '../../features/auth/domain/auth_repository.dart';
import '../../features/auth/presentation/auth_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../features/tracking/data/tracking_repository_impl.dart';
import '../../features/tracking/presentation/tracking_controller.dart';

class ServiceLocator {
  static final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  static final AuthRepository _authRepository =
      AuthRepositoryImpl(_firebaseAuth);

  static final AuthController authController = AuthController(_authRepository);

  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  static final TrackingController trackingController = TrackingController(
    TrackingRepositoryImpl(_firestore),
  );
}
