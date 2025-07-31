# Logging Implementation Documentation

## Overview

This document describes the logging implementation for the Balance AI Agent Flutter application. The logging system provides comprehensive monitoring, debugging, and operational insights while maintaining security and performance.

## Architecture

### LoggerService
- **Location**: `lib/services/logger_service.dart`
- **Pattern**: Singleton
- **Features**:
  - Environment-aware output (development: console, production: file + console)
  - Structured log levels (debug, info, warning, error)
  - Sensitive data masking for privacy protection
  - Specialized logging methods for different operations

### LoggerProvider
- **Location**: `lib/providers/logger_provider.dart`
- **Pattern**: Provider/ChangeNotifier
- **Purpose**: Dependency injection and configuration management
- **Integration**: Added to main.dart's MultiProvider

## Log Levels

| Level | Purpose | Environment |
|-------|---------|-------------|
| `debug` | Detailed development information | Development only |
| `info` | General application flow | All environments |
| `warning` | Potential issues that don't break functionality | All environments |
| `error` | Errors and exceptions | All environments |

## Usage Examples

### Basic Logging
```dart
final logger = LoggerService.instance;

logger.debug('Detailed debug information');
logger.info('Application started');
logger.warning('Potential issue detected');
logger.error('Error occurred', error: exception, stackTrace: stackTrace);
```

### Specialized Logging Methods

#### User Actions
```dart
logger.logUserAction('button_click');
logger.logUserAction('navigation', parameters: {'from': 'home', 'to': 'chat'});
```

#### API Calls
```dart
logger.logApiCall('/api/chat', method: 'POST', statusCode: 200);
logger.logApiCall('/api/chat', method: 'POST', error: 'Connection failed');
```

#### Database Operations
```dart
logger.logDatabaseOperation('INSERT', table: 'lifestyle');
logger.logDatabaseOperation('SELECT', table: 'lifestyle', error: exception);
```

#### Operation Wrapper
```dart
final result = await logger.handleOperation(
  apiCall(),
  'Chat API call',
  fallbackValue: 'Default response',
);
```

## Security Features

### Data Masking
The logger automatically masks sensitive information:
- **Email addresses**: `user@example.com` → `use***@***.***`
- **Phone numbers**: `090-1234-5678` → `***-***-****`
- **Long identifiers**: `abcdefghijklmnopqrstuvwxyz1234567890` → `abcdefgh...`

### Configuration
- Development: Console output only
- Production: Both console and file output
- Log files stored in app documents directory
- Daily log rotation with timestamp

## Integration Points

### Global Error Handling
```dart
// In main.dart
FlutterError.onError = (FlutterErrorDetails details) {
  LoggerService.instance.error(
    'Flutter Error: ${details.exception}',
    error: details.exception,
    stackTrace: details.stack,
  );
};
```

### Existing Services Updated
1. **GenkitClient**: API call logging and error handling
2. **LocalDatabase**: Database operation logging
3. **AuthForm**: Authentication event logging
4. **ChatRoomPage**: User interaction and lifecycle logging

## Testing

### Test Coverage
- **Location**: `test/logger_service_test.dart`
- **Coverage**:
  - Singleton pattern validation
  - Log level functionality
  - Specialized logging methods
  - Operation wrapper functionality
  - Error handling scenarios

### Running Tests
```bash
flutter test test/logger_service_test.dart
```

## Performance Considerations

- Minimal overhead in production
- Async file writing to prevent UI blocking
- Automatic log rotation to manage storage
- Configurable log levels to reduce verbosity

## Future Enhancements

### Planned Features
- Cloud logging integration (Firebase, CloudWatch, etc.)
- Log analytics dashboard
- Performance metrics logging
- User behavior analytics (privacy-compliant)

### Configuration Options
- Log level filtering
- Remote log level adjustment
- Custom output destinations
- Log retention policies

## Migration from Print Statements

All `print()` statements have been replaced with appropriate logger calls:
- Debug information → `logger.debug()`
- General information → `logger.info()`
- Error messages → `logger.error()`
- User actions → `logger.logUserAction()`

## Best Practices

1. **Use appropriate log levels**: Don't use `error` for warnings
2. **Include context**: Provide relevant parameters and state information
3. **Avoid logging sensitive data**: The system masks known patterns, but be cautious
4. **Use structured logging**: Prefer the specialized methods for consistent formatting
5. **Handle errors gracefully**: Use the operation wrapper for better error management

## Troubleshooting

### Common Issues
- **Missing logs in production**: Check file permissions and storage availability
- **Performance impact**: Reduce log verbosity in production
- **Memory usage**: Ensure log files are properly rotated

### Debug Commands
```dart
// Check if logger is initialized
logger.info('Logger test message');

// Verify file output (production)
final directory = await getApplicationDocumentsDirectory();
print('Log files: ${directory.path}/logs/');
```