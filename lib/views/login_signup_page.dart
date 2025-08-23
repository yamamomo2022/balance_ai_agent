import 'package:balance_ai_agent/utility/app_theme.dart';
import 'package:balance_ai_agent/views/signup_page.dart';
import 'package:balance_ai_agent/views/widgets/auth_form.dart';
import 'package:flutter/material.dart';

/// ログイン・サインアップページ
class LoginSignupPage extends StatelessWidget {
  /// コンストラクタ
  const LoginSignupPage({
    super.key,
    this.showDeletedMessage = false,
  });
  final bool showDeletedMessage;

  @override
  Widget build(BuildContext context) {
    // アカウント削除メッセージの表示
    if (showDeletedMessage) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('アカウントが削除されました'),
            backgroundColor: AppTheme.successColor,
          ),
        );
      });
    }

    // テーマカラーの定義は削除済み（AppThemeを使用）

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: AppTheme.loginBackgroundGradient,
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // 天秤のイラスト
                const Icon(
                  Icons.balance,
                  size: 80,
                  color: AppTheme.primaryColor,
                ),
                const SizedBox(height: 16),
                // アプリ名
                Card(
                  margin: const EdgeInsets.symmetric(horizontal: 24),
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(20),
                    child: AuthForm(isLogin: true),
                  ),
                ),
                const SizedBox(height: 24),
                // 区切り線
                const SizedBox(
                  width: 300,
                  child: Row(
                    children: [
                      Expanded(
                        child: Divider(
                          color: Colors.grey,
                          thickness: 0.5,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16),
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
                      backgroundColor: AppTheme.primaryColor,
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

                // 利用規約とプライバシーポリシーへのリンク
                const SizedBox(
                  width: 300,
                  child: Padding(
                    padding: EdgeInsets.only(top: 24, bottom: 16),
                    child: Text(
                      '利用開始をもって利用規約とプライバシーポリシーに同意したものとみなします',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 12,
                      ),
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
