import 'package:balance_ai_agent/services/logging_service.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('LoggingService', () {
    late LoggingService loggingService;

    setUpAll(() {
      loggingService = LoggingService.instance;
      loggingService.initialize();
    });

    test('should initialize successfully', () {
      expect(loggingService, isNotNull);
    });

    test('should log debug messages without throwing', () {
      expect(
        () => loggingService.debug('Test debug message'),
        returnsNormally,
      );
    });

    test('should log info messages without throwing', () {
      expect(
        () => loggingService.info('Test info message'),
        returnsNormally,
      );
    });

    test('should log warning messages without throwing', () {
      expect(
        () => loggingService.warning('Test warning message'),
        returnsNormally,
      );
    });

    test('should log error messages without throwing', () {
      expect(
        () => loggingService.error('Test error message'),
        returnsNormally,
      );
    });

    test('should log fatal messages without throwing', () {
      expect(
        () => loggingService.fatal('Test fatal message'),
        returnsNormally,
      );
    });

    test('should handle error objects and stack traces', () {
      final error = Exception('Test exception');
      final stackTrace = StackTrace.current;

      expect(
        () => loggingService.error(
          'Test error with exception',
          error: error,
          stackTrace: stackTrace,
        ),
        returnsNormally,
      );
    });
  });
}