import 'package:balance_ai_agent/pages/base_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthForm extends StatefulWidget {
  const AuthForm({
    super.key,
    required this.isLogin,
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

  void _submitForm() async {
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
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const BasePage()),
        );
      } on FirebaseAuthException catch (e) {
        String errorMessage = 'An error occurred.';
        if (e.code == 'weak-password') {
          errorMessage = 'The password provided is too weak.';
        } else if (e.code == 'email-already-in-use') {
          errorMessage = 'The account already exists for that email.';
        } else if (e.code == 'user-not-found') {
          errorMessage = 'No user found for that email.';
        } else if (e.code == 'wrong-password') {
          errorMessage = 'Wrong password provided for that user.';
        }

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(errorMessage)),
        );
      } catch (e) {
        print(e);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('An unexpected error occurred.')),
        );
      }
    }
  }

  // パスワードリセット処理
  void _handlePasswordReset(BuildContext context) async {
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
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('パスワードリセットメールを送信しました'),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('パスワードリセットに失敗しました: ${e.toString()}'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: SizedBox(
          width: 300,
          child: Column(
            children: [
              TextFormField(
                autofocus: false,
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
