import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'genkit_client.dart';
import 'widgets/chat_input_widget.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});
  final String title = 'Chat Page';

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _controller = TextEditingController();
  final dio = Dio();
  late final GenkitClient _genkitClient;

  @override
  void initState() {
    super.initState();
    _genkitClient = GenkitClient(dio: dio);
  }

  // 新たに送信処理を関数化
  void _handleSend(String inputText) async {
    if (inputText.isNotEmpty) {
      try {
        final responseText =
            await _genkitClient.generateChatResponse(inputText);
        print('Sending text: $responseText');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Sent: $responseText')),
        );
        // Clear text field after sending
        _controller.clear();
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      }
    } else {
      // Notify when input is empty
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
            ChatInputWidget(
              controller: _controller,
              onSend: _handleSend,
            ),
          ],
        ),
      ),
    );
  }
}
