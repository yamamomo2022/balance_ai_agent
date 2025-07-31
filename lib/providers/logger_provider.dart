import 'package:balance_ai_agent/services/logger_service.dart';
import 'package:flutter/foundation.dart';

/// LoggerServiceの依存性注入を管理するProvider
/// 
/// アプリケーション全体でLoggerServiceのインスタンスを
/// 共有し、設定の変更を監視する
class LoggerProvider with ChangeNotifier {
  LoggerService get logger => LoggerService.instance;

  /// ログレベルの設定変更（将来的な拡張用）
  bool _isDebugEnabled = kDebugMode;
  bool get isDebugEnabled => _isDebugEnabled;

  /// デバッグログの有効/無効を切り替え
  void setDebugEnabled(bool enabled) {
    if (_isDebugEnabled != enabled) {
      _isDebugEnabled = enabled;
      logger.info('Debug logging ${enabled ? 'enabled' : 'disabled'}');
      notifyListeners();
    }
  }

  /// アプリケーション起動時のログ記録
  void logAppStart() {
    logger.info('Application started');
  }

  /// アプリケーション終了時のログ記録
  void logAppStop() {
    logger.info('Application stopped');
  }

  /// クラッシュやエラーの記録
  void logCrash(Object error, StackTrace stackTrace, {String? context}) {
    final message = context != null 
        ? 'Application crash in $context'
        : 'Application crash';
    logger.error(message, error: error, stackTrace: stackTrace);
  }
}