import 'package:flutter/material.dart';
import 'models/lifestyle.dart';

class LifestyleAIAgentPage extends StatefulWidget {
  final Lifestyle lifestyle;
  const LifestyleAIAgentPage({Key? key, required this.lifestyle})
      : super(key: key);

  @override
  _LifestyleAIAgentPageState createState() => _LifestyleAIAgentPageState();
}

class _LifestyleAIAgentPageState extends State<LifestyleAIAgentPage> {
  final List<String> messages = [];
  final TextEditingController messageController = TextEditingController();

  // 事前プロンプト（ライフスタイル情報）を文字列に整形
  String get prePrompt {
    return '体験投資: ${widget.lifestyle.investment}\n'
        '節約・貯蓄: ${widget.lifestyle.savings}\n'
        '自己成長: ${widget.lifestyle.growth}\n'
        '目標設定: ${widget.lifestyle.goals}\n';
  }

  @override
  void initState() {
    super.initState();
    // 最初のメッセージとして事前プロンプトを表示
    messages.add('【事前プロンプト】\n$prePrompt');
  }

  void _sendMessage() {
    if (messageController.text.trim().isEmpty) return;
    setState(() {
      messages.add("あなた: ${messageController.text}");
      // ここで生成AIへのリクエストを実施、今回はエコーする例
      messages.add("AI: ${messageController.text}");
    });
    messageController.clear();
  }

  @override
  void dispose() {
    messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Chat with AI Agent'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Expanded(
          //   child: ListView.builder(
          //     padding: const EdgeInsets.all(16),
          //     itemCount: messages.length,
          //     itemBuilder: (context, index) {
          //       return Padding(
          //         padding: const EdgeInsets.symmetric(vertical: 4),
          //         child: Text(
          //           messages[index],
          //           style: const TextStyle(fontSize: 16),
          //         ),
          //       );
          //     },
          //   ),
          // ),
          Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 300),
              child: TextField(
                controller: messageController,
                decoration: const InputDecoration(
                  hintText: 'Enter text to send',
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {},
            child: const Icon(Icons.send),
          ),
        ],
      ),
    );
  }
}
