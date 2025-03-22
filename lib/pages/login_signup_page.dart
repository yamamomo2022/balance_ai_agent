import 'package:balance_ai_agent/providers/user_provider.dart';
import 'package:balance_ai_agent/widgets/auth_form.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'base_page.dart';
import 'signup_page.dart';

class LoginSignupPage extends StatelessWidget {
  final bool showDeletedMessage;

  const LoginSignupPage({
    super.key,
    this.showDeletedMessage = false,
  });

  /// お試しモードでアプリを利用するためのハンドラー
  void _handleTryDemoMode(BuildContext context) {
    // ゲストモードフラグを設定（UserProviderを使用）
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    userProvider.setGuestMode(true);
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const BasePage()),
    );

    // お試し利用の通知
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('お試しモードでログインしました。一部機能が制限されています。'),
        duration: Duration(seconds: 4),
        backgroundColor: Color(0xFF3A8891),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // アカウント削除メッセージの表示
    if (showDeletedMessage) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('アカウントが削除されました'),
            backgroundColor: Colors.green,
          ),
        );
      });
    }

    // テーマカラーの定義
    const Color primaryColor = Color(0xFF3A8891); // バランスを表す青緑色

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFE8F3F3),
              Colors.white,
            ],
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // 天秤のイラスト
                Icon(
                  Icons.balance,
                  size: 80,
                  color: primaryColor,
                ),
                const SizedBox(height: 16),
                // アプリ名
                Card(
                  margin: const EdgeInsets.symmetric(horizontal: 24),
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: AuthForm(isLogin: true),
                  ),
                ),
                const SizedBox(height: 24),
                // 区切り線
                SizedBox(
                  width: 300,
                  child: Row(
                    children: const [
                      Expanded(
                        child: Divider(
                          color: Colors.grey,
                          thickness: 0.5,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.0),
                        child: Text(
                          'または',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 14,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Divider(
                          color: Colors.grey,
                          thickness: 0.5,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                // サインアップボタン
                SizedBox(
                  width: 300,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SignupPage()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryColor,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      elevation: 2,
                    ),
                    child: const Text(
                      'アカウント作成',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                // お試し利用ボタン
                Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: SizedBox(
                    width: 300,
                    child: OutlinedButton(
                      onPressed: () => _handleTryDemoMode(context),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: primaryColor,
                        side: const BorderSide(color: primaryColor, width: 1.5),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: const Text(
                        'お試し利用',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ),

                // 利用規約とプライバシーポリシーへのリンク
                const Padding(
                  padding: EdgeInsets.only(top: 24.0, bottom: 16.0),
                  child: Text(
                    '利用開始をもって利用規約とプライバシーポリシーに同意したものとみなします',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
