import 'package:balance_ai_agent/services/auth_service.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('anonymous sign-in returns anonymous user', () async {
    // This test intentionally expects a concrete implementation named
    // FirebaseAuthService to exist. It should fail until a real or fake
    // implementation is provided.
    final AuthService service = FirebaseAuthService();

    final user = await service.signInAnonymously();

    expect(user, isNotNull);
    expect(user.isAnonymous, isTrue);
  });
}
