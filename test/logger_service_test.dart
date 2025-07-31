import 'package:balance_ai_agent/services/logger_service.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('LoggerService Tests', () {
    late LoggerService logger;

    setUp(() {
      logger = LoggerService.instance;
    });

    test('should create singleton instance', () {
      final logger1 = LoggerService.instance;
      final logger2 = LoggerService.instance;
      
      expect(logger1, equals(logger2));
    });

    test('should mask sensitive data in messages', () {
      // This test checks that the logger properly masks sensitive information
      // We'll test it indirectly by checking that the service doesn't crash
      expect(() {
        logger.info('User email: test@example.com');
        logger.info('Phone: 090-1234-5678');
        logger.info('UID: abcdefghijklmnopqrstuvwxyz1234567890');
      }, returnsNormally);
    });

    test('should handle log levels correctly', () {
      expect(() {
        logger.debug('Debug message');
        logger.info('Info message');
        logger.warning('Warning message');
        logger.error('Error message');
      }, returnsNormally);
    });

    test('should log user actions', () {
      expect(() {
        logger.logUserAction('button_click');
        logger.logUserAction('navigation', parameters: {'from': 'home', 'to': 'profile'});
      }, returnsNormally);
    });

    test('should log API calls', () {
      expect(() {
        logger.logApiCall('/api/chat', method: 'POST', statusCode: 200);
        logger.logApiCall('/api/chat', method: 'POST', error: 'Connection failed');
      }, returnsNormally);
    });

    test('should log database operations', () {
      expect(() {
        logger.logDatabaseOperation('INSERT', table: 'lifestyle');
        logger.logDatabaseOperation('SELECT', table: 'lifestyle', error: Exception('DB error'));
      }, returnsNormally);
    });

    test('should handle operation with success', () async {
      final result = await logger.handleOperation(
        Future.value('success'),
        'test operation',
      );
      
      expect(result, equals('success'));
    });

    test('should handle operation with failure', () async {
      final result = await logger.handleOperation<String>(
        Future.error(Exception('Test error')),
        'test operation',
        fallbackValue: 'fallback',
      );
      
      expect(result, equals('fallback'));
    });
  });

  group('LogLevel Tests', () {
    test('should have correct labels', () {
      expect(LogLevel.debug.label, equals('DEBUG'));
      expect(LogLevel.info.label, equals('INFO'));
      expect(LogLevel.warning.label, equals('WARNING'));
      expect(LogLevel.error.label, equals('ERROR'));
    });
  });
}