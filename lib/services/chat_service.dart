import 'package:flutter/material.dart';
import 'package:balance_ai_agent/genkit_client.dart';

class ChatService {
  final GenkitClient genkitClient;
  final BuildContext context; // Add context

  ChatService({required this.genkitClient, required this.context});

  Future<void> sendMessage(String inputText, String prePrompt) async {
    if (inputText.isNotEmpty) {
      try {
        final responseText =
            await genkitClient.generateChatResponse(prePrompt + inputText);
        print('Sending text: $responseText');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Sent: $responseText')),
        );
      } catch (e) {
        print('Error occurred: $e'); // エラーをログに記録
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('An error occurred. Please try again.')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter some text')),
      );
    }
  }
}
