import 'package:flutter/material.dart';
import 'package:balance_ai_agent/widgets/auth_form.dart';
import 'chat_room_page.dart';
import 'signup_page.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginSignupPage extends StatelessWidget {
  const LoginSignupPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.balance_rounded,
              size: 120,
              color: Colors.blueGrey,
            ),
            const SizedBox(height: 16),
            AuthForm(isLogin: true), // Login
            SizedBox(
              width: 300,
              child: Row(
                children: const [
                  Expanded(child: Divider()),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text('Or'),
                  ),
                  Expanded(child: Divider()),
                ],
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: 300,
              child: ElevatedButton(
                onPressed: () async {
                  // 匿名で使用する処理
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ChatRoomPage()),
                  );
                  try {
                    final userCredential =
                        await FirebaseAuth.instance.signInAnonymously();
                    print("Signed in with temporary account.");
                  } on FirebaseAuthException catch (e) {
                    switch (e.code) {
                      case "operation-not-allowed":
                        print(
                            "Anonymous auth hasn't been enabled for this project.");
                        break;
                      default:
                        print("Unknown error.");
                    }
                    // ユーザーにエラーメッセージを表示するためのUI要素を追加
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                          content: Text(
                              "Anonymous auth hasn't been enabled for this project.")),
                    );
                  }
                },
                child: const Text(
                  'Use Anonymously',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
            const SizedBox(height: 32),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Does not have account?",
                    style: TextStyle(fontSize: 16)),
                const SizedBox(width: 16),
                InkWell(
                  // GestureDetector で Text をラップ
                  onTap: () {
                    // サインアップ画面に遷移する処理
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SignupPage()),
                    );
                  },
                  child: const Text(
                    // TextButton の代わりに Text を使用
                    'Sign Up',
                    style: TextStyle(
                        fontSize: 16, color: Colors.blueGrey), // スタイルを調整
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
