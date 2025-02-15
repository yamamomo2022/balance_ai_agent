import 'package:flutter/material.dart';

typedef OnSendCallback = void Function(String inputText, String prePrompt);

class ChatInputWidget extends StatelessWidget {
  final TextEditingController controller;
  final OnSendCallback onSend;
  final String prePrompt; // 事前プロンプトを追加

  const ChatInputWidget({
    super.key,
    required this.controller,
    required this.onSend,
    this.prePrompt = '', // デフォルト値は空文字列
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        // Row を Column に変更
        children: [
          SizedBox(
            // SizedBox で TextField の高さを制限
            height: 50,
            width: 300,
            child: TextField(
              controller: controller,
              decoration: const InputDecoration(
                hintText: 'Enter text to send',
              ),
            ),
          ),
          const SizedBox(height: 8),
          ElevatedButton(
            onPressed: () {
              final inputText = controller.text;
              if (inputText.isNotEmpty) {
                onSend(inputText, prePrompt); // 事前プロンプトも渡す
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
