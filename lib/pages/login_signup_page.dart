import 'package:balance_ai_agent/widgets/auth_form.dart';
import 'package:flutter/material.dart';

import 'signup_page.dart';

class LoginSignupPage extends StatelessWidget {
  final bool showDeletedMessage;

  const LoginSignupPage({
    super.key,
    this.showDeletedMessage = false,
  });

  @override
  Widget build(BuildContext context) {
    // 削除メッセージの表示
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
                const Text(
                  'だいたいあん',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF0E5E6F),
                  ),
                ),
                const SizedBox(height: 8),
                // アプリ説明
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 40),
                  child: Text(
                    '理想への扉を開く、多彩な選択肢',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.blueGrey,
                      fontSize: 16,
                    ),
                  ),
                ),
                const SizedBox(height: 40),
                // ログインフォーム
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
