import 'package:flutter/material.dart';

typedef OnSendCallback = void Function(String inputText);

class ChatInputWidget extends StatelessWidget {
  final TextEditingController controller;
  final OnSendCallback onSend;

  const ChatInputWidget({
    Key? key,
    required this.controller,
    required this.onSend,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: controller,
              decoration: const InputDecoration(
                hintText: 'Enter text to send',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          const SizedBox(width: 8),
          ElevatedButton(
            onPressed: () {
              final inputText = controller.text;
              onSend(inputText);
            },
            child: const Icon(Icons.send),
          ),
        ],
      ),
    );
  }
}
