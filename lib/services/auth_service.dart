/// AuthService interface and related types for authentication.
///
class AuthUser {
  /// Creates an instance of [AuthUser].
  const AuthUser({required this.uid, required this.isAnonymous, this.email});

  /// The unique identifier for the user.
  final String uid;

  /// Whether the user is signed in anonymously.
  final bool isAnonymous;

  /// The email address of the user, if available.
  final String? email;

  @override
  String toString() =>
      'AuthUser(uid: $uid, anonymous: $isAnonymous, email: $email)';
}

/// Generic auth-related exception that implementations should throw when
/// an underlying SDK (Firebase etc.) returns an error. Keeps tests deterministic.
class AppAuthException implements Exception {
  /// Creates an instance of [AppAuthException].
  AppAuthException(this.code, [this.message = 'Authentication error']);
  final String code;
  final String message;

  @override
  String toString() => 'AppAuthException(code: $code, message: $message)';
}

/// Lightweight abstraction for authentication operations used by the app.
/// Keep methods minimal to make testing straightforward.
abstract class AuthService {
  /// Returns the currently signed-in user or null.
  Future<AuthUser?> currentUser();

  /// Sign in anonymously and return the signed-in user.
  /// Throws [AppAuthException] on failure.
  Future<AuthUser> signInAnonymously();

  /// Sign out the current user.
  Future<void> signOut();

  /// Link the current user with email/password credential.
  /// On success returns the updated user.
  /// Throws [AppAuthException] (e.g. 'credential-already-in-use').
  Future<AuthUser> linkWithEmailAndPassword(
      {required String email, required String password});

  /// Delete current user account. Throws AppAuthException on failure.
  Future<void> deleteUser();

  /// Reauthenticate the current user using email/password.
  /// Required before some sensitive operations.
  Future<void> reauthenticateWithEmailAndPassword(
      {required String email, required String password});
}
