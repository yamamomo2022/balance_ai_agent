import 'package:flutter/material.dart';
import 'chat_page.dart';
import "lifestyle_page.dart";
import 'widgets/custom_app_bar.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Balance AI Agent',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: CustomAppBar(),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min, // 内容分だけの高さにする
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => LifestylePage()));
              },
              child: const Text('Go to Lifestyle Page'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ChatPage()));
              },
              child: const Text('Go to Chat Page'),
            ),
          ],
        ),
      ),
    );
  }
}
