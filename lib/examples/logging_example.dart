import 'package:balance_ai_agent/services/logging_service.dart';

/// Example demonstrating how to use the LoggingService throughout the application
class LoggingExample {
  final LoggingService _logger = LoggingService.instance;

  /// Example of service initialization with logging
  Future<void> initializeService() async {
    _logger.info('Initializing example service...');
    
    try {
      // Simulate some initialization work
      await Future.delayed(const Duration(milliseconds: 100));
      _logger.debug('Service initialization step 1 completed');
      
      await Future.delayed(const Duration(milliseconds: 100));
      _logger.debug('Service initialization step 2 completed');
      
      _logger.info('Example service initialized successfully');
    } catch (e, stackTrace) {
      _logger.error(
        'Failed to initialize example service',
        error: e,
        stackTrace: stackTrace,
      );
      rethrow;
    }
  }

  /// Example of data processing with different log levels
  Future<String> processData(String input) async {
    _logger.debug('Starting data processing for input: ${input.length} characters');
    
    if (input.isEmpty) {
      _logger.warning('Received empty input for data processing');
      return 'No data to process';
    }
    
    try {
      // Simulate data processing
      final result = input.toUpperCase();
      _logger.info('Data processing completed successfully');
      _logger.debug('Processing result: $result');
      
      return result;
    } catch (e) {
      _logger.error(
        'Data processing failed',
        error: e,
      );
      rethrow;
    }
  }

  /// Example of network operation logging
  Future<Map<String, dynamic>> fetchData(String url) async {
    _logger.info('Fetching data from: $url');
    
    try {
      // Simulate network delay
      await Future.delayed(const Duration(milliseconds: 500));
      
      // Simulate success response
      final response = {'status': 'success', 'data': 'example data'};
      _logger.debug('Network response received: $response');
      _logger.info('Data fetched successfully');
      
      return response;
    } on Exception catch (e) {
      _logger.error(
        'Network request failed',
        error: e,
      );
      rethrow;
    }
  }

  /// Example of error handling with detailed logging
  Future<void> performCriticalOperation() async {
    _logger.info('Starting critical operation');
    
    try {
      await _validatePreconditions();
      await _executeOperation();
      await _validateResults();
      
      _logger.info('Critical operation completed successfully');
    } catch (e, stackTrace) {
      _logger.fatal(
        'Critical operation failed',
        error: e,
        stackTrace: stackTrace,
      );
      rethrow;
    }
  }

  Future<void> _validatePreconditions() async {
    _logger.debug('Validating preconditions...');
    // Validation logic here
    _logger.debug('Preconditions validated');
  }

  Future<void> _executeOperation() async {
    _logger.debug('Executing critical operation...');
    // Operation logic here
    _logger.debug('Operation executed');
  }

  Future<void> _validateResults() async {
    _logger.debug('Validating results...');
    // Result validation logic here
    _logger.debug('Results validated');
  }

  /// Example of user action logging
  void handleUserAction(String action, Map<String, dynamic> params) {
    _logger.info('User action: $action');
    _logger.debug('Action parameters: $params');
    
    switch (action) {
      case 'login':
        _logger.info('User login attempt');
        break;
      case 'logout':
        _logger.info('User logout');
        break;
      case 'data_save':
        _logger.info('User saved data');
        break;
      default:
        _logger.warning('Unknown user action: $action');
    }
  }
}