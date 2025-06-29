#　個人開発アプリ 「だいたいあん」

[<img src="assets/images/app_store_badge.png" height="50">](https://apps.apple.com/jp/app/%E3%81%A0%E3%81%84%E3%81%9F%E3%81%84%E3%81%82%E3%82%93/id6742693704)

## 🌟 開発背景

現代社会では、SNSの普及や消費社会の発達により、**衝動的な判断**や**短期的な欲求**に流されやすい環境が整っています。私自身も、ついつい不要なものを購入してしまったり、健康に良くないとわかっていても夜更かしをしてしまったりする経験があり、「理想の自分」と「現実の行動」のギャップに悩んでいました。

既存の習慣化アプリや家計簿アプリは数多く存在しますが、それらは**結果の記録**に焦点を当てており、**判断の瞬間**での支援が不十分だと感じていました。

そこで、**AIの力を借りて、リアルタイムで理想的な行動選択を支援する**アプリを開発することを決意しました。単なる記録ツールではなく、ユーザーの価値観や目標を理解し、その場で最適なアドバイスを提供する「パーソナルAIコーチ」を目指して開発しています。

## 📱 プロジェクト概要

**だいたいあん** は、無駄遣いや不摂生に走りがちな現代人のために、理想的な行動選択を支援するAIエージェントアプリです。

### 🎯 解決したい課題
- 衝動的な消費行動の抑制
- 健康的なライフスタイルの維持
- 理想の自分との行動ギャップの解消

### 💡 アプローチ
- AIによる個人に最適化された提案
- 継続的な対話を通じた行動パターンの学習
- ユーザーフレンドリーなチャット形式のインターフェース

## ✨ 主な機能

### 🔐 認証機能
- メールアドレス・パスワードによるユーザー登録・ログイン
- パスワードリセット機能
- ゲストモード（お試し利用）
- アカウント削除機能

### 🤖 AI対話機能
- パーソナライズされたAIエージェントとの対話
- ライフスタイル情報を基にした提案生成
- 継続的な学習による提案精度の向上

### 📊 ライフスタイル管理
- ユーザープロファイルの設定・管理
- 行動履歴の記録・分析
- 個人に合わせたコンテンツ配信

## 🛠 技術スタック

### Frontend
- **Flutter** (3.6.0) - クロスプラットフォーム開発
- **Dart** - プログラミング言語
- **Provider** - 状態管理
- **Flutter Hooks** - ライフサイクル管理

### Backend & Cloud Services
- **Firebase Authentication** - ユーザー認証
- **Firebase Core** - Firebase統合
- **Google Genkit** - AI統合

### UI/UX
- **Flutter Chat UI** - チャットインターフェース
- **Material Design** - デザインシステム
- **Custom Icons** - アプリ専用アイコン

### Data Management
- **SQLite** (sqflite) - ローカルデータベース
- **HTTP/Dio** - API通信
- **Environment Variables** - 設定管理

### Development Tools
- **Flutter Lints** - コード品質管理
- **Flutter Launcher Icons** - アイコン生成

## 🏗 アーキテクチャ

```
lib/
├── main.dart                 # アプリケーションエントリーポイント
├── firebase_options.dart     # Firebase設定
├── enums/                    # 列挙型定義
│   └── tab_item.dart
├── models/                   # データモデル
│   ├── lifestyle.dart
│   └── user.dart
├── pages/                    # 画面コンポーネント
│   ├── base_page.dart
│   ├── chat_room_page.dart
│   ├── lifestyle_page.dart
│   ├── login_signup_page.dart
│   ├── setting_page.dart
│   └── signup_page.dart
├── providers/                # 状態管理
│   ├── lifestyle_provider.dart
│   └── user_provider.dart
├── services/                 # ビジネスロジック
│   ├── genkit_client.dart
│   ├── image_generation_service.dart
│   └── local_database.dart
├── utility/                  # ユーティリティ
└── widgets/                  # 再利用可能なUI部品

genkit/                       # AI統合バックエンド
├── src/
│   ├── app.ts               # Express サーバー
│   ├── genkit.ts            # Genkit設定
│   ├── index.ts             # エントリーポイント
│   └── genkit-flows/        # AIフロー定義
└── prompts/                 # プロンプト管理
```

### 設計パターン
- **Provider Pattern** - 状態管理とデータ流通
- **Repository Pattern** - データアクセス層の抽象化
- **Clean Architecture** - 関心の分離とテスタビリティ

## 🚀 開発における工夫・技術的チャレンジ

### 1. AIとの効果的な統合
- Google Genkitを活用したAI対話システムの構築
- ユーザーのライフスタイル情報を活用したコンテキスト生成
- プロンプトエンジニアリングによる提案品質の向上

### 2. ユーザー体験の最適化
- Firebase Authenticationによる安全で簡単な認証フロー
- ゲストモードによる機能試用の実現
- 直感的なチャットUIによる自然な対話体験

### 3. データ管理の効率化
- SQLiteによるローカルデータのキャッシュ戦略
- Environment Variablesによる開発・本番環境の分離
- Providerパターンによる効率的な状態管理

### 4. 開発プロセスの改善
- Flutter Lintsによるコード品質の維持
- 環境別設定ファイルによる柔軟なデプロイ
- TypeScript + Node.jsによるバックエンド開発

## 📱 スクリーンショット

*（実機でのスクリーンショットを後日追加予定）*

## ⚙️ セットアップ・実行方法

### 前提条件
- Flutter SDK 3.6.0以上
- Dart SDK 3.0以上
- Node.js 18以上（AI統合機能用）
- Firebase プロジェクト

### 1. リポジトリのクローン

```bash
git clone https://github.com/yamamomo2022/balance_ai_agent.git
cd balance_ai_agent
```

### 2. 依存関係のインストール

```bash
# Flutter依存関係
flutter pub get

# AI統合バックエンドの依存関係
cd genkit
npm install
cd ..
```

### 3. Firebase設定

1. [Firebase Console](https://console.firebase.google.com/)でプロジェクトを作成
2. Android用の`google-services.json`を`android/app/`に配置
3. iOS用の`GoogleService-Info.plist`を`ios/Runner/`に配置
4. Authentication機能を有効化（Email/Password認証）

### 4. 環境変数の設定

```bash
# 開発環境用
cp .env.development.example .env.development

# 本番環境用  
cp .env.production.example .env.production
```

各ファイルに必要なAPI keyやendpointを設定してください。

### 5. アプリケーションの起動

```bash
# Flutterアプリの起動
flutter run

# AI統合バックエンドの起動（別ターミナル）
cd genkit
npm run dev
```

### 6. 動作確認

- アプリが正常に起動することを確認
- ゲストモードで基本機能を試用
- 新規アカウント作成とログインの動作確認

## 🧪 テスト

```bash
# 単体テスト実行
flutter test

# 統合テスト実行（実装予定）
flutter test integration_test/
```

## 🚀 ビルド・デプロイ

### Android
```bash
flutter build apk --release
# または
flutter build appbundle --release
```

### iOS
```bash
flutter build ios --release
```

## 📈 今後の改善・拡張予定

### 短期目標
- [ ] チャット履歴の永続化
- [ ] プッシュ通知機能
- [ ] ダークモード対応
- [ ] 多言語対応（英語）

### 中期目標  
- [ ] 機械学習による提案精度向上
- [ ] ソーシャル機能（目標共有）
- [ ] データ分析ダッシュボード
- [ ] Webアプリ版の開発

### 長期目標
- [ ] AIコーチング機能の強化
- [ ] サブスクリプションモデルの導入

## 🤝 貢献

このプロジェクトは個人開発ですが、フィードバックやアイデアをお待ちしています。

1. Issueを作成してバグ報告や機能提案を行う
2. Pull Requestを送信（事前にIssueでの相談を推奨）
3. [Twitter](https://twitter.com/your_twitter)でのフィードバック

## 📄 使用技術・ライブラリの詳細

| カテゴリ | ライブラリ/技術 | バージョン | 用途 |
|---------|-------------|-----------|------|
| フレームワーク | Flutter | 3.6.0 | アプリ開発基盤 |
| 言語 | Dart | 3.0+ | アプリ開発言語 |
| 認証 | Firebase Auth | 5.5.0 | ユーザー認証 |
| データベース | SQLite | 2.4.1 | ローカルデータ保存 |
| 状態管理 | Provider | 6.1.2 | アプリ状態管理 |
| UI | Flutter Chat UI | 1.6.15 | チャットインターフェース |
| HTTP通信 | Dio | 5.8.0 | API通信 |
| 環境設定 | Flutter DotEnv | 5.2.1 | 環境変数管理 |
| AI統合 | Google Genkit | - | AI対話エンジン |
| バックエンド | Node.js + TypeScript | 18+ | AI統合サーバー |

## 🎨 デザイン・UI/UX の特徴

### デザインコンセプト
- **ミニマル**: 不要な要素を排除した直感的なインターフェース
- **フレンドリー**: 親しみやすいAIエージェントとの対話体験
- **アクセシブル**: 幅広いユーザーが利用しやすい設計

### 技術的な実装ポイント
- Material Designガイドラインに準拠
- レスポンシブデザインによる様々な画面サイズへの対応
- カスタムアイコンとブランディング

## 📊 パフォーマンス最適化

### 実装した最適化
- **効率的な状態管理**: パターンによる最小限の再描画
- **データキャッシング**: SQLiteによるローカルデータの効率的な管理
- **非同期処理**: Future/Streamを活用したノンブロッキング処理
- **メモリ管理**: 適切なリソース管理とライフサイクル制御

### 実装済みのセキュリティ対策
- Firebase Authenticationによる安全な認証
- 環境変数による機密情報の分離
- HTTPSによる通信の暗号化
- 入力値検証とサニタイゼーション

### このプロジェクトで身につけた技術
- FlutterによるiOSアプリ開発
- Firebase統合とクラウドサービス活用
- AI APIとの統合開発
- TypeScript/Node.jsによるバックエンド開発
- モバイルアプリのUX/UI設計
- 状態管理パターンの実装

## 📱 対応プラットフォーム

- ✅ iOS 12.0+

## ライセンス

このリポジトリはMITライセンスで公開されています。  
詳細は [LICENSE](LICENSE) ファイルをご覧ください。
