import 'package:logger/logger.dart';

/// グローバルに利用可能なloggerインスタンス
/// 
/// アプリ全体で統一的なログ出力を行うためのloggerインスタンス。
/// どのファイルからでもimportして利用可能。
/// 
/// 使用例:
/// ```dart
/// import 'package:balance_ai_agent/utility/logger.dart';
/// 
/// void someFunction() {
///   logger.d('Debug message');
///   logger.i('Info message');
///   logger.w('Warning message');
///   logger.e('Error message');
/// }
/// ```
final Logger logger = Logger(
  printer: PrettyPrinter(
    methodCount: 2, // スタックトレースの表示行数
    errorMethodCount: 8, // エラー時のスタックトレース表示行数
    lineLength: 120, // 1行の最大文字数
    colors: true, // カラー出力を有効にする
    printEmojis: true, // 絵文字を表示する
    dateTimeFormat: DateTimeFormat.onlyTimeAndSinceStart, // 時刻表示形式
  ),
);