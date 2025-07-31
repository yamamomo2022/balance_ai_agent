import 'dart:developer' as developer;
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';
import 'package:path_provider/path_provider.dart';

/// ログレベルの定義
enum LogLevel {
  debug('DEBUG'),
  info('INFO'),
  warning('WARNING'),
  error('ERROR');

  const LogLevel(this.label);
  final String label;
}

/// アプリケーション全体で使用するロギングサービス
/// 
/// 機能:
/// - 環境に応じたログ出力先の切り替え (開発: コンソール、本番: ファイル)
/// - ログレベル別の管理
/// - エラー発生時の自動ログ出力
/// - 個人情報保護のためのデータマスキング
class LoggerService {
  static LoggerService? _instance;
  static LoggerService get instance => _instance ??= LoggerService._();
  
  LoggerService._() {
    _initializeLogger();
  }

  late Logger _logger;
  bool _isInitialized = false;

  /// ロガーの初期化
  void _initializeLogger() {
    if (_isInitialized) return;

    LogOutput output;
    
    if (kDebugMode) {
      // 開発環境: コンソール出力
      output = ConsoleOutput();
    } else {
      // 本番環境: ファイル出力（将来的にクラウド連携も可能）
      output = MultiOutput([
        ConsoleOutput(),
        FileOutput(),
      ]);
    }

    _logger = Logger(
      filter: ProductionFilter(),
      printer: PrettyPrinter(
        methodCount: 2,
        errorMethodCount: 8,
        lineLength: 120,
        colors: kDebugMode,
        printEmojis: true,
        printTime: true,
      ),
      output: output,
    );

    _isInitialized = true;
  }

  /// デバッグレベルのログ出力
  /// 開発時のみ表示される詳細な情報
  void debug(String message, {Object? error, StackTrace? stackTrace}) {
    if (!_isInitialized) _initializeLogger();
    
    final maskedMessage = _maskSensitiveData(message);
    _logger.d(maskedMessage, error: error, stackTrace: stackTrace);
    
    // Dart developer ツールにも出力（デバッグ時）
    if (kDebugMode) {
      developer.log(
        maskedMessage,
        name: 'BalanceAI.Debug',
        error: error,
        stackTrace: stackTrace,
      );
    }
  }

  /// 情報レベルのログ出力
  /// 通常の動作を示す情報
  void info(String message, {Object? error, StackTrace? stackTrace}) {
    if (!_isInitialized) _initializeLogger();
    
    final maskedMessage = _maskSensitiveData(message);
    _logger.i(maskedMessage, error: error, stackTrace: stackTrace);
    
    developer.log(
      maskedMessage,
      name: 'BalanceAI.Info',
      error: error,
      stackTrace: stackTrace,
    );
  }

  /// 警告レベルのログ出力
  /// 問題の可能性があるが、アプリは継続動作する状況
  void warning(String message, {Object? error, StackTrace? stackTrace}) {
    if (!_isInitialized) _initializeLogger();
    
    final maskedMessage = _maskSensitiveData(message);
    _logger.w(maskedMessage, error: error, stackTrace: stackTrace);
    
    developer.log(
      maskedMessage,
      name: 'BalanceAI.Warning',
      level: 900,
      error: error,
      stackTrace: stackTrace,
    );
  }

  /// エラーレベルのログ出力
  /// エラーや例外が発生した状況
  void error(String message, {Object? error, StackTrace? stackTrace}) {
    if (!_isInitialized) _initializeLogger();
    
    final maskedMessage = _maskSensitiveData(message);
    _logger.e(maskedMessage, error: error, stackTrace: stackTrace);
    
    developer.log(
      maskedMessage,
      name: 'BalanceAI.Error',
      level: 1000,
      error: error,
      stackTrace: stackTrace,
    );
  }

  /// ユーザー操作のログ記録
  /// ボタンクリック、画面遷移などのユーザーアクション
  void logUserAction(String action, {Map<String, dynamic>? parameters}) {
    final message = parameters != null 
        ? 'User Action: $action with params: $parameters'
        : 'User Action: $action';
    info(message);
  }

  /// API呼び出しのログ記録
  void logApiCall(String endpoint, {String? method, int? statusCode, Object? error}) {
    if (error != null) {
      this.error('API Call Failed: $method $endpoint', error: error);
    } else {
      info('API Call: $method $endpoint (Status: $statusCode)');
    }
  }

  /// データベース操作のログ記録
  void logDatabaseOperation(String operation, {String? table, Object? error}) {
    if (error != null) {
      this.error('Database Operation Failed: $operation on $table', error: error);
    } else {
      debug('Database Operation: $operation on $table');
    }
  }

  /// 個人情報や機密情報をマスクする
  String _maskSensitiveData(String message) {
    // メールアドレスをマスク
    String masked = message.replaceAllMapped(
      RegExp(r'\b[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Z|a-z]{2,}\b'),
      (match) => '${match.group(0)?.substring(0, 3)}***@***.***',
    );

    // 電話番号をマスク (日本の電話番号形式)
    masked = masked.replaceAllMapped(
      RegExp(r'\b\d{2,4}-\d{2,4}-\d{4}\b'),
      (match) => '***-***-****',
    );

    // FirebaseのUID等をマスク
    masked = masked.replaceAllMapped(
      RegExp(r'\b[a-zA-Z0-9]{20,}\b'),
      (match) => '${match.group(0)?.substring(0, 8)}...',
    );

    return masked;
  }
}

/// ファイル出力用のLogOutput実装
class FileOutput extends LogOutput {
  File? _file;

  @override
  Future<void> init() async {
    final directory = await getApplicationDocumentsDirectory();
    final logDir = Directory('${directory.path}/logs');
    if (!await logDir.exists()) {
      await logDir.create(recursive: true);
    }
    
    final now = DateTime.now();
    final fileName = 'app_${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}.log';
    _file = File('${logDir.path}/$fileName');
  }

  @override
  void output(OutputEvent event) {
    if (_file != null) {
      final timestamp = DateTime.now().toIso8601String();
      final logEntry = '[$timestamp] ${event.lines.join('\n')}\n';
      _file!.writeAsStringSync(logEntry, mode: FileMode.append);
    }
  }
}

/// LoggerServiceの拡張メソッド
extension LoggerServiceExtension on LoggerService {
  /// エラーハンドリングと自動ログ出力を行うヘルパーメソッド
  Future<T?> handleOperation<T>(
    Future<T> operation,
    String operationName, {
    T? fallbackValue,
  }) async {
    try {
      info('Starting operation: $operationName');
      final result = await operation;
      info('Operation completed: $operationName');
      return result;
    } catch (error, stackTrace) {
      this.error(
        'Operation failed: $operationName',
        error: error,
        stackTrace: stackTrace,
      );
      return fallbackValue;
    }
  }
}