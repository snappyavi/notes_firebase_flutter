import 'package:notes_firebase/change_notifier/registration_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';


class AuthService {
  AuthService._();

  static final _auth = FirebaseAuth.instance;

  static User? get user => _auth.currentUser;

  static Stream<User?> get userStream => _auth.userChanges();

  static bool get isEmailVerified => user?.emailVerified ?? false;

  static Future<void> register({
    required String fullName,
    required String email,
    required String password,
  }) async {
    try {
      final credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
    } catch (e) {
      rethrow;
    }
  }


  static Future<void> login({
    required String email,
    required String password,
  }) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
    } catch (e) {
      rethrow;
    }
  }

  static Future<void> logout() async {
    await _auth.signOut();

  }

  static Future<void> resetPassword({required String email}) =>
      _auth.sendPasswordResetEmail(email: email);
}
