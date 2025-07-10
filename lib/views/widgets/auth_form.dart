import 'package:balance_ai_agent/utility/show_snack_bar.dart';
import 'package:balance_ai_agent/views/lifestyle_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthForm extends StatefulWidget {
  const AuthForm({
    required this.isLogin,
    super.key,
  });

  final bool isLogin;

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();
  bool _obscurePassword = true;
  String _emailAddress = '';
  String _password = '';

  void _navigateToBasePage(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const LifestylePage()),
    );
  }

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      try {
        if (widget.isLogin) {
          // Sign-in logic
          final credential =
              await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: _emailAddress,
            password: _password,
          );
          print('User signed in: ${credential.user?.email}');
        } else {
          // Sign-up logic
          final credential =
              await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: _emailAddress,
            password: _password,
          );
          print('User created: ${credential.user?.email}');
        }

        // Navigate to chat room after successful authentication
        if (mounted) {
          _navigateToBasePage(context);
        }
      } on FirebaseAuthException catch (e) {
        var errorMessage = 'An error occurred.';
        if (e.code == 'weak-password') {
          errorMessage = 'The password provided is too weak.';
        } else if (e.code == 'email-already-in-use') {
          errorMessage = 'The account already exists for that email.';
        } else if (e.code == 'user-not-found') {
          errorMessage = 'No user found for that email.';
        } else if (e.code == 'wrong-password') {
          errorMessage = 'Wrong password provided for that user.';
        }

        if (mounted) {
          showSnackBar(context, errorMessage);
        }
      } catch (e) {
        print(e);
        if (mounted) {
          showSnackBar(context, 'An unexpected error occurred.');
        }
      }
    }
  }

  // パスワードリセット処理
  Future<void> _handlePasswordReset(BuildContext context) async {
    if (_emailAddress.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('パスワードをリセットするには、メールアドレスを入力してください'),
        ),
      );
      return;
    }

    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: _emailAddress);
      if (context.mounted) {
        showSnackBar(context, 'パスワードリセットメールを送信しました');
      }
    } catch (e) {
      if (context.mounted) {
        // エラーメッセージを表示
        showSnackBar(context, 'パスワードリセットに失敗しました: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Form(
        key: _formKey,
        child: SizedBox(
          width: 300,
          child: Column(
            children: [
              TextFormField(
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  if (!value.contains('@')) {
                    return 'Please enter a valid email';
                  }
                  return null;
                },
                onChanged: (value) {
                  setState(() {
                    _emailAddress = value;
                  });
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                obscureText: _obscurePassword,
                decoration: InputDecoration(
                  labelText: 'Password',
                  border: const OutlineInputBorder(),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscurePassword
                          ? Icons.visibility_off
                          : Icons.visibility,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscurePassword = !_obscurePassword;
                      });
                    },
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'パスワードを入力してください';
                  }
                  return null;
                },
                onChanged: (value) {
                  setState(() {
                    _password = value;
                  });
                },
              ),
              const SizedBox(height: 8),
              if (widget.isLogin)
                TextButton(
                  onPressed: () => _handlePasswordReset(context),
                  child: const Text('パスワードをリセット'),
                ),
              const SizedBox(height: 16),
              SizedBox(
                width: 300,
                child: ElevatedButton(
                  onPressed: _submitForm,
                  child: Text(
                    widget.isLogin ? 'ログイン' : 'サインアップ',
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
