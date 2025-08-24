import 'package:balance_ai_agent/services/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart' as fb;

/// Concrete AuthService using FirebaseAuth SDK. Keep light and testable by
/// accepting an optional [fb.FirebaseAuth] instance.
class FirebaseAuthService implements AuthService {
  /// Creates a new instance of [FirebaseAuthService].
  FirebaseAuthService({fb.FirebaseAuth? firebaseAuth})
      : _firebaseAuth = firebaseAuth ?? fb.FirebaseAuth.instance;
  final fb.FirebaseAuth _firebaseAuth;

  @override
  Future<AuthUser?> currentUser() async {
    final u = _firebaseAuth.currentUser;
    if (u == null) return null;
    return AuthUser(uid: u.uid, isAnonymous: u.isAnonymous, email: u.email);
  }

  @override
  Stream<AuthUser?> authStateChanges() =>
      _firebaseAuth.authStateChanges().map((u) => u == null
          ? null
          : AuthUser(uid: u.uid, isAnonymous: u.isAnonymous, email: u.email));

  @override
  Future<AuthUser> signInAnonymously() async {
    try {
      final cred = await _firebaseAuth.signInAnonymously();
      final u = cred.user;
      if (u == null) throw AppAuthException('no-user', 'No user returned');
      return AuthUser(uid: u.uid, isAnonymous: u.isAnonymous, email: u.email);
    } on fb.FirebaseAuthException catch (e) {
      throw AppAuthException(e.code, e.message ?? 'FirebaseAuth error');
    } catch (e) {
      throw AppAuthException('unknown', e.toString());
    }
  }

  @override
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  @override
  Future<AuthUser> linkWithEmailAndPassword(
      {required String email, required String password}) async {
    final user = _firebaseAuth.currentUser;
    if (user == null) {
      throw AppAuthException('no-user', 'No current user to link');
    }
    try {
      final credential =
          fb.EmailAuthProvider.credential(email: email, password: password);
      final result = await user.linkWithCredential(credential);
      final u = result.user;
      if (u == null) {
        throw AppAuthException('no-user', 'No user returned after link');
      }
      return AuthUser(uid: u.uid, isAnonymous: u.isAnonymous, email: u.email);
    } on fb.FirebaseAuthException catch (e) {
      throw AppAuthException(e.code, e.message ?? 'FirebaseAuth error');
    }
  }

  @override
  Future<void> deleteUser() async {
    final user = _firebaseAuth.currentUser;
    if (user == null) {
      throw AppAuthException('no-user', 'No current user to delete');
    }
    try {
      await user.delete();
    } on fb.FirebaseAuthException catch (e) {
      throw AppAuthException(e.code, e.message ?? 'FirebaseAuth error');
    }
  }

  @override
  Future<void> reauthenticateWithEmailAndPassword(
      {required String email, required String password}) async {
    final user = _firebaseAuth.currentUser;
    if (user == null) {
      throw AppAuthException('no-user', 'No current user to reauthenticate');
    }
    try {
      final credential =
          fb.EmailAuthProvider.credential(email: email, password: password);
      await user.reauthenticateWithCredential(credential);
    } on fb.FirebaseAuthException catch (e) {
      throw AppAuthException(e.code, e.message ?? 'FirebaseAuth error');
    }
  }
}
