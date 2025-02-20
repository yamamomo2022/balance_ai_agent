import 'package:flutter/material.dart';
import 'package:balance_ai_agent/widgets/auth_form.dart';

class SignupPage extends StatelessWidget {
  const SignupPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
        ),
        body: Center(child: const LoginForm()));
  }
}
