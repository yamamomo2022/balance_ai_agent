import 'package:balance_ai_agent/services/firebase_auth_service.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('firebase auth service anonymous sign-in (mock)', () async {
    final mockAuth = MockFirebaseAuth();
    final service = FirebaseAuthService(firebaseAuth: mockAuth);

    final userBefore = await service.currentUser();
    expect(userBefore, isNull);

    final signed = await service.signInAnonymously();
    expect(signed.isAnonymous, isTrue);
    expect(signed.uid, isNotEmpty);

    final userAfter = await service.currentUser();
    expect(userAfter, isNotNull);
    expect(userAfter!.isAnonymous, isTrue);
  });
}
