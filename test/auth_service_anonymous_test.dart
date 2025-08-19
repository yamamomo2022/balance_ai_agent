import 'package:balance_ai_agent/services/auth_service.dart';
import 'package:flutter_test/flutter_test.dart';

import 'mocks/fake_auth_service.dart';

void main() {
  test('anonymous sign-in returns anonymous user', () async {
    final AuthService service = FakeAuthService();

    final user = await service.signInAnonymously();

    expect(user, isNotNull);
    expect(user.isAnonymous, isTrue);
    expect(user.uid, equals('fake-uid-123'));
  });
}
