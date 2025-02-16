import 'package:flutter/material.dart';
import 'chat_page.dart';
import "lifestyle_page.dart";

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
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Balance AI Agent'),
    );
  }
}

class MyHomePage extends StatelessWidget {
  final String title;
  const MyHomePage({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromARGB(255, 114, 219, 184),
                Color.fromARGB(255, 87, 151, 199)
              ], // グラデーションの色を指定
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        elevation: 0, // 影の強さを指定
        // backgroundColor: Colors.transparent, // 背景色を透明にする
        title: Text(title,
            style: const TextStyle(
                color: Color.fromARGB(255, 44, 56, 229),
                fontFamily: "Roboto",
                fontSize: 24,
                fontWeight: FontWeight.bold)),
      ),
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
