import 'package:flutter/material.dart';
import 'models/lifestyle.dart';
import 'services/chat_service.dart';
import 'genkit_client.dart';
import 'package:dio/dio.dart';
import 'widgets/custom_app_bar.dart';

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
  late final GenkitClient _genkitClient;
  late final ChatService _chatService;
  final dio = Dio();

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
    _genkitClient = GenkitClient(dio: dio);
    // 最初のメッセージとして事前プロンプトを表示
    if (prePrompt.isNotEmpty) {
      setState(() {
        messages.add('【事前プロンプト】\n$prePrompt');
      });
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _chatService = ChatService(genkitClient: _genkitClient, context: context);
  }

  @override
  void dispose() {
    messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Lifestyle AI Agent'),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
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
            onPressed: () async {
              if (messageController.text.trim().isNotEmpty) {
                await _chatService.sendMessage(
                    messageController.text, prePrompt);
                messageController.clear();
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('メッセージを入力してください。')),
                );
              }
            },
            child: const Icon(Icons.send),
          ),
        ],
      ),
    );
  }
}
