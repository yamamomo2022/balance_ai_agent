import 'package:balance_ai_agent/utility/logger.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:logger/logger.dart';

void main() {
  group('Logger Utility Tests', () {
    test('logger instance should be available globally', () {
      // loggerインスタンスが正常に取得できることを確認
      expect(logger, isA<Logger>());
      expect(logger, isNotNull);
    });

    test('logger should have proper configuration', () {
      // loggerが適切に設定されていることを確認
      expect(logger.printer, isA<PrettyPrinter>());
    });

    test('logger should handle different log levels', () {
      // 異なるログレベルでエラーが発生しないことを確認
      expect(() => logger.d('Debug test message'), returnsNormally);
      expect(() => logger.i('Info test message'), returnsNormally);
      expect(() => logger.w('Warning test message'), returnsNormally);
      expect(() => logger.e('Error test message'), returnsNormally);
    });
  });
}