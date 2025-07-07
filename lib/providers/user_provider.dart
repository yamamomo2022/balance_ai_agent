import 'package:balance_ai_agent/view_models/user_view_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class UserProvider with ChangeNotifier {
  final UserViewModel _viewModel = UserViewModel();

  User? get user => _viewModel.user;
  bool get isGuestMode => _viewModel.isGuestMode;
  bool get isLoggedIn => _viewModel.isLoggedIn;

  /// 通常のユーザー設定
  void setUser(User? user) {
    _viewModel.setUser(user);
    notifyListeners();
  }

  /// ゲストモードの設定
  /// [isGuest] - trueの場合ゲストモードを有効化、falseの場合は無効化
  void setGuestMode(bool isGuest) {
    _viewModel.setGuestMode(isGuest);
    notifyListeners();
  }

  /// ログアウト処理
  /// ゲストモード・通常ユーザーモード両方をクリア
  Future<void> logout() async {
    await _viewModel.logout();
    notifyListeners();
  }
}
