// Example of how the new logging system works in the Balance AI Agent app
import 'package:balance_ai_agent/services/logger_service.dart';

/// This example demonstrates the comprehensive logging implementation
/// that replaces all print() statements in the application
void demonstrateLogging() {
  final logger = LoggerService.instance;

  // Basic log levels
  logger.debug('Debug information for development');
  logger.info('Application flow information'); 
  logger.warning('Potential issue detected');
  logger.error('Error occurred', error: Exception('Sample error'));

  // User action logging
  logger.logUserAction('user_login');
  logger.logUserAction('navigate_to_chat', parameters: {
    'from': 'login_page',
    'to': 'chat_room',
    'user_type': 'authenticated'
  });

  // API call logging
  logger.logApiCall('/api/chat', method: 'POST', statusCode: 200);
  logger.logApiCall('/api/auth', method: 'POST', error: 'Authentication failed');

  // Database operation logging
  logger.logDatabaseOperation('INSERT', table: 'lifestyle');
  logger.logDatabaseOperation('SELECT', table: 'users', error: Exception('Connection timeout'));

  // Automatic data masking for privacy
  logger.info('User email: user@example.com'); // Becomes: use***@***.***
  logger.info('Phone: 090-1234-5678'); // Becomes: ***-***-****
  logger.info('User ID: abcdefghijklmnopqrstuvwxyz1234567890'); // Becomes: abcdefgh...

  // Operation wrapper with error handling
  _demonstrateOperationWrapper();
}

Future<void> _demonstrateOperationWrapper() async {
  final logger = LoggerService.instance;

  // Example: API call with automatic error handling and logging
  final result = await logger.handleOperation(
    _simulateApiCall(),
    'Chat API request',
    fallbackValue: 'Fallback response when API fails',
  );

  logger.info('API call result: $result');
}

Future<String> _simulateApiCall() async {
  // Simulate an API call that might fail
  await Future.delayed(Duration(milliseconds: 100));
  if (DateTime.now().millisecond % 2 == 0) {
    throw Exception('Simulated API failure');
  }
  return 'API call successful';
}

/*
BEFORE (using print statements):
  print('User signed in: ${credential.user?.email}');
  print('Chat response received');
  print('Error saving lifestyle: $e');

AFTER (using LoggerService):
  logger.info('User signed in successfully');
  logger.logApiCall('/chat', method: 'POST', statusCode: 200);
  logger.logDatabaseOperation('INSERT', table: 'lifestyle', error: e);

Benefits:
- ✅ Environment-aware output (console in dev, file in production)
- ✅ Structured logging with consistent formatting
- ✅ Automatic sensitive data masking
- ✅ Centralized error handling and monitoring
- ✅ Easy to disable/filter by log level
- ✅ Integration with Dart DevTools
- ✅ Persistent logging for production debugging
*/