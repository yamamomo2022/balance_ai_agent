import 'package:balance_ai_agent/utility/logger.dart';

/// logger使用例のデモンストレーション
/// 
/// このファイルはloggerパッケージの使用方法を示すためのデモです。
/// 実際のアプリケーションでは、このように各所でloggerをimportして使用できます。
void demonstrateLoggerUsage() {
  // デバッグ情報のログ
  logger.d('This is a debug message');
  
  // 情報レベルのログ
  logger.i('Application started successfully');
  
  // 警告レベルのログ
  logger.w('This is a warning message');
  
  // エラーレベルのログ
  logger.e('This is an error message');
  
  // エラーとスタックトレースを含むログ
  try {
    throw Exception('Sample exception');
  } catch (error, stackTrace) {
    logger.e('An exception occurred', error: error, stackTrace: stackTrace);
  }
  
  // 構造化データを含むログ
  logger.i('User login attempt', {
    'userId': 'user123',
    'timestamp': DateTime.now().toIso8601String(),
    'platform': 'mobile'
  });
}