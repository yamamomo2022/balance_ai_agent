import 'package:balance_ai_agent/views/widgets/auth_form.dart';
import 'package:flutter/material.dart';

class SignupPage extends StatelessWidget {
  const SignupPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
        ),
        body: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(child: AuthForm(isLogin: false)), // sign up
          ],
        ));
  }
}
