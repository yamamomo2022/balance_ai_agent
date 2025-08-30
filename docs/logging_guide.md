# ロギング機能の実装ガイド

## 概要

このプロジェクトでは、統一されたロギング機能として `logger` パッケージを導入しています。
デバッグや運用時のログ出力を統一し、可読性・保守性を向上させることを目的としています。

## 実装内容

### 1. パッケージの追加

`pubspec.yaml` に `logger: ^2.5.0` を追加しました。

### 2. LoggingService クラス

`lib/services/logging_service.dart` にシングルトンパターンでロギングサービスを実装しています。

#### 特徴
- **環境依存のログレベル**: デバッグモードでは `Level.debug`、リリースモードでは `Level.info`
- **見やすい出力形式**: カラー表示、絵文字、時間表示付きの `PrettyPrinter` を使用
- **エラーハンドリング**: `error` オブジェクトと `stackTrace` をサポート

#### 利用可能なメソッド
- `debug()`: デバッグレベルのログ
- `info()`: 情報レベルのログ
- `warning()`: 警告レベルのログ
- `error()`: エラーレベルのログ
- `fatal()`: 致命的エラーレベルのログ

### 3. 初期化

`main.dart` でアプリケーション開始時にロギングサービスを初期化しています。

```dart
// Initialize logging service
LoggingService.instance.initialize();
LoggingService.instance.info('Application starting...');
```

### 4. 既存のprint文置き換え

以下のファイルで `print` 文を `LoggingService` に置き換えました：

- `lib/main.dart`: Firebase認証エラー
- `lib/services/local_database.dart`: データベース操作エラー
- `lib/services/genkit_client.dart`: API通信のデバッグログ
- `lib/providers/persistent_tab_state_notifier.dart`: ストレージ操作エラー

## 使用例

### 基本的な使用方法

```dart
import 'package:balance_ai_agent/services/logging_service.dart';

// 情報ログ
LoggingService.instance.info('User logged in successfully');

// エラーログ
try {
  // 何らかの処理
} catch (e) {
  LoggingService.instance.error(
    'Failed to process data',
    error: e,
  );
}

// デバッグログ（デバッグモードでのみ表示）
LoggingService.instance.debug('Processing step 1 completed');
```

### エラーとスタックトレース付きログ

```dart
try {
  await someAsyncOperation();
} catch (e, stackTrace) {
  LoggingService.instance.error(
    'Async operation failed',
    error: e,
    stackTrace: stackTrace,
  );
}
```

## ベストプラクティス

1. **適切なログレベルの使用**
   - `debug`: 開発時のデバッグ情報
   - `info`: 一般的な情報（アプリの状態変化など）
   - `warning`: 警告レベルの問題
   - `error`: エラー情報
   - `fatal`: 致命的な問題

2. **メッセージの書き方**
   - 簡潔で理解しやすいメッセージを心がける
   - 必要に応じて文脈情報を含める
   - 機密情報はログに含めない

3. **エラーハンドリング**
   - catch ブロックでは必ず適切なログレベルでログを出力
   - `error` パラメータで例外オブジェクトを渡す
   - 重要な箇所では `stackTrace` も含める

## テスト

`test/logging_service_test.dart` にロギングサービスの基本的なテストを含めています。
テストはすべてのログレベルが正常に動作することを確認します。

```bash
flutter test test/logging_service_test.dart
```

## 今後の拡張

- ログファイルへの出力機能
- リモートロギング（Crashlytics、Sentryなど）
- ログフィルタリング機能
- パフォーマンス計測ログ