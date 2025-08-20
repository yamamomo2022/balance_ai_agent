import 'dart:async';

import 'package:balance_ai_agent/services/auth_service.dart';

/// Simple in-memory fake implementation of [AuthService] for tests.
class FakeAuthService implements AuthService {
  FakeAuthService({AuthUser? initialUser}) : _user = initialUser {
    _controller = StreamController<AuthUser?>.broadcast();
    // emit initial state
    _controller.add(_user);
  }
  AuthUser? _user;
  late final StreamController<AuthUser?> _controller;

  @override
  Future<AuthUser?> currentUser() async => _user;

  @override
  Stream<AuthUser?> authStateChanges() => _controller.stream;

  @override
  Future<AuthUser> signInAnonymously() async {
    // If already signed in, return existing user.
    if (_user != null) return _user!;

    // Create a deterministic test UID.
    _user = const AuthUser(uid: 'fake-uid-123', isAnonymous: true);
    _controller.add(_user);
    return _user!;
  }

  @override
  Future<void> signOut() async {
    _user = null;
    _controller.add(null);
  }

  @override
  Future<AuthUser> linkWithEmailAndPassword(
      {required String email, required String password}) async {
    if (_user == null) {
      throw AppAuthException('no-user', 'No current user to link');
    }
    // Simulate linking by returning a non-anonymous user with email.
    _user = AuthUser(uid: _user!.uid, isAnonymous: false, email: email);
    return _user!;
  }

  @override
  Future<void> deleteUser() async {
    if (_user == null) {
      throw AppAuthException('no-user', 'No current user to delete');
    }
    _user = null;
  }

  @override
  Future<void> reauthenticateWithEmailAndPassword(
      {required String email, required String password}) async {
    if (_user == null) {
      throw AppAuthException('no-user', 'No current user to reauthenticate');
    }
    // For fake, assume reauthentication always succeeds when email matches.
    if (_user!.email != null && _user!.email != email) {
      throw AppAuthException(
          'wrong-credentials', 'Email does not match current user');
    }
    return;
  }
}
