import 'package:flutter/material.dart';
import 'package:balance_ai_agent/genkit_client.dart';
import 'package:dio/dio.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
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

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // TextEditingController を追加してテキストフィールドの入力値を管理
  final TextEditingController _controller = TextEditingController();

  final dio = Dio(BaseOptions(
    connectTimeout: Duration(minutes: 1),
    // 他のオプションも必要に応じて設定
  ));
  late final GenkitClient _genkitClient;

  @override
  void initState() {
    super.initState();
    _genkitClient = GenkitClient(dio: dio);
  }

  // 入力されたテキストを送信するメソッド
  void _sendText() async {
    // final text = _controller.text;
    final text = await _genkitClient.generatetext();
    if (text.isNotEmpty) {
      // ここでは例として、コンソール出力と SnackBar 表示を行っています。
      print('Sending text: $text');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Sent: $text')),
      );
      // 送信後、テキストフィールドをクリア
      _controller.clear();
    } else {
      // 入力が空の場合の通知
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter some text')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              width: 300,
              child: TextField(
                controller: _controller,
                decoration: const InputDecoration(
                  hintText: 'Enter text to send',
                ),
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _sendText,
              child: const Icon(Icons.send),
            ),
          ],
        ),
      ),
    );
  }
}
