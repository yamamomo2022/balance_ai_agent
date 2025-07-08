import 'package:flutter/material.dart';

/// アプリ全体のテーマ定義を集約したクラス
class AppTheme {
  AppTheme._(); // プライベートコンストラクタでインスタンス化を防ぐ

  // =====================================
  // プライマリカラー
  // =====================================
  
  /// メインテーマカラー（バランスを表す青緑色）
  static const Color primaryColor = Color(0xFF3A8891);
  
  /// セカンダリテーマカラー（チャット用リフレッシュボタンなど）
  static const Color secondaryColor = Color.fromARGB(255, 98, 185, 195);

  // =====================================
  // グラデーションカラー
  // =====================================
  
  /// AppBarグラデーション開始色
  static const Color gradientStart = Color.fromARGB(255, 114, 219, 184);
  
  /// AppBarグラデーション終了色  
  static const Color gradientEnd = Color.fromARGB(255, 87, 151, 199);
  
  /// ログイン画面背景グラデーション開始色
  static const Color loginGradientStart = Color(0xFFE8F3F3);
  
  /// ログイン画面背景グラデーション終了色
  static const Color loginGradientEnd = Colors.white;

  // =====================================
  // アクセントカラー
  // =====================================
  
  /// BottomNavigationBar選択時カラー
  static const Color bottomNavSelectedColor = Colors.cyan;
  
  /// 編集モード時のカラー
  static const Color editModeColor = Colors.blue;
  
  /// 保存モード時のカラー
  static const Color saveModeColor = Colors.green;

  // =====================================
  // システムカラー
  // =====================================
  
  /// エラー表示用カラー
  static const Color errorColor = Colors.red;
  
  /// 成功表示用カラー
  static const Color successColor = Colors.green;
  
  /// 透明カラー
  static const Color transparent = Colors.transparent;
  
  /// 影カラー
  static const Color shadowColor = Colors.black;
  
  /// 白カラー
  static const Color whiteColor = Colors.white;

  // =====================================
  // グラデーション定義
  // =====================================
  
  /// AppBar用グラデーション
  static const LinearGradient appBarGradient = LinearGradient(
    colors: [gradientStart, gradientEnd],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  
  /// ログイン画面背景用グラデーション
  static const LinearGradient loginBackgroundGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [loginGradientStart, loginGradientEnd],
  );
}