# Logger Usage Documentation

このファイルはBalance AI Agentアプリケーションでのloggerパッケージの使用方法を説明します。

## 概要

アプリ全体で統一的なログ出力を行うため、`logger`パッケージを導入し、グローバルloggerインスタンスを提供しています。

## 基本的な使用方法

### インポート

```dart
import 'package:balance_ai_agent/utility/logger.dart';
```

### ログレベル

- `logger.d()` - Debug（開発時のデバッグ情報）
- `logger.i()` - Info（一般的な情報）
- `logger.w()` - Warning（警告）
- `logger.e()` - Error（エラー）

### 使用例

```dart
// シンプルなメッセージ
logger.i('ユーザーがログインしました');

// エラーとスタックトレースを含む
try {
  // 何らかの処理
} catch (error, stackTrace) {
  logger.e('処理中にエラーが発生しました', error: error, stackTrace: stackTrace);
}

// 構造化データを含む
logger.d('API呼び出し', {
  'endpoint': '/api/chat',
  'method': 'POST',
  'userId': user.id
});
```

## 設定

loggerは以下の設定で初期化されています：

- **カラー出力**: 有効
- **絵文字**: 有効  
- **スタックトレース**: エラー時は8行、通常時は2行
- **行長**: 120文字
- **時刻形式**: 開始時点からの経過時間

## ファイル例

実装例は以下のファイルを参照してください：

- `lib/utility/logger.dart` - Logger定義
- `lib/utility/logger_demo.dart` - 使用例
- `lib/services/local_database.dart` - 実際の使用例
- `lib/services/genkit_client.dart` - 実際の使用例
- `lib/main.dart` - アプリ起動時のログ例

## テスト

loggerのテストは `test/utility/logger_test.dart` にあります。

## 注意事項

- 本番環境では適切なログレベルフィルタリングを設定することを推奨します
- 機密情報をログに出力しないよう注意してください
- パフォーマンスが重要な処理では、ログ出力の頻度に注意してください