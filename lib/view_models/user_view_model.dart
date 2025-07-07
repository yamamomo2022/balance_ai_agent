import 'package:firebase_auth/firebase_auth.dart';

class UserViewModel {
  User? _user;
  bool _isGuestMode = false;

  User? get user => _user;
  bool get isGuestMode => _isGuestMode;
  bool get isLoggedIn => _user != null || _isGuestMode;

  /// 通常のユーザー設定
  void setUser(User? user) {
    _user = user;
    // 通常ユーザーが設定されたらゲストモードは無効にする
    if (user != null) {
      _isGuestMode = false;
    }
  }

  /// ゲストモードの設定
  /// [isGuest] - trueの場合ゲストモードを有効化、falseの場合は無効化
  void setGuestMode(bool isGuest) {
    _isGuestMode = isGuest;
    // ゲストモードが有効の場合は、_userをnullに設定して通常ユーザーをクリア
    if (isGuest) {
      _user = null;
    }
  }

  /// ログアウト処理
  /// ゲストモード・通常ユーザーモード両方をクリア
  Future<void> logout() async {
    // Firebase認証からログアウト
    if (_user != null) {
      await FirebaseAuth.instance.signOut();
    }

    // 内部状態をリセット
    _user = null;
    _isGuestMode = false;
  }
}
