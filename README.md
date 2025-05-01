## アプリ概要

**だいたいあん** は、無駄遣いや不摂生に奥なってしまいそうな時に，理想の自分へ向かうための選択肢を提案するAIエージェントアプリです。  
Firebase認証によるログイン・サインアップや、お試しモード（ゲスト利用）も可能です。

## 主な機能

- メールアドレスとパスワードによるユーザー登録・ログイン
- パスワードリセット
- ゲストモード（お試し利用）
- アカウント削除
- ユーザーごとのチャットルーム（今後拡張予定）

## セットアップ方法

1. このリポジトリをクローンします。

   ```sh
   git clone https://github.com/yamamomo2022/balance_ai_agent.git
   cd balance_ai_agent
   ```

2. 必要なパッケージをインストールします。

   ```sh
   flutter pub get
   ```

3. Firebaseプロジェクトを作成し、`google-services.json`（Android）や`GoogleService-Info.plist`（iOS）を各プラットフォームの所定の場所に配置してください。

4. アプリを起動します。

   ```sh
   flutter run
   ```

## 使用技術

- Flutter
- Firebase Authentication
- Provider（状態管理）

## ライセンス

このリポジトリはMITライセンスで公開されています。  
詳細は [LICENSE](LICENSE) ファイルをご覧ください。




