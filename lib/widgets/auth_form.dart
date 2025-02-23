import 'package:flutter/material.dart';
import 'package:balance_ai_agent/pages/chat_room_page.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthForm extends StatefulWidget {
  const AuthForm({super.key, required this.bottomText});
  final String bottomText;

  @override
  State<AuthForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();
  bool _obscurePassword = true;
  String emailAddress = ''; // Add this line
  String password = ''; // Add this line

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: SizedBox(
          width: 300, // 幅を指定
          child: Column(
            children: [
              TextFormField(
                autofocus: true,
                cursorColor: const Color.fromARGB(255, 93, 190, 163),
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
                  // Add this line
                  emailAddress = value;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                obscureText: _obscurePassword,
                cursorColor: const Color.fromARGB(255, 93, 190, 163),
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
                    return 'Please enter your password';
                  }
                  return null;
                },
                onChanged: (value) {
                  // Add this line
                  password = value;
                },
              ),
              const SizedBox(height: 32),
              SizedBox(
                width: 300,
                child: ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      try {
                        final credential = await FirebaseAuth.instance
                            .createUserWithEmailAndPassword(
                          email: emailAddress,
                          password: password,
                        );
                        print(
                            'User created: ${credential.user?.email}'); // Add this line
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const ChatRoomPage()),
                        );
                      } on FirebaseAuthException catch (e) {
                        if (e.code == 'weak-password') {
                          print('The password provided is too weak.');
                        } else if (e.code == 'email-already-in-use') {
                          print('The account already exists for that email.');
                        }
                      } catch (e) {
                        print(e);
                      }
                    }
                  },
                  child: Text(
                    widget.bottomText,
                    style: TextStyle(fontSize: 16),
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
