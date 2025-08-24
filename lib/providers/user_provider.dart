import 'package:balance_ai_agent/models/user.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'user_provider.g.dart';

/// ユーザー情報を管理するプロバイダー
@riverpod
class UserNotifier extends _$UserNotifier {
  @override
  User? build() => null;

  /// ユーザー情報を取得するゲッター
  User? get user => state;

  /// ユーザー情報を設定するセッター
  set user(User? newUser) => state = newUser;

  /// ログアウト処理
  void logout() => state = null;
}
