import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'genkit_client.dart';
import 'widgets/chat_input_widget.dart';
import 'services/chat_service.dart'; // Import ChatService

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
  late final ChatService _chatService; // Declare ChatService

  @override
  void initState() {
    super.initState();
    _genkitClient = GenkitClient(dio: dio);
    _chatService = ChatService(
        genkitClient: _genkitClient,
        context: context); // Initialize ChatService
  }

  // Use ChatService's sendMessage method
  void _handleSend(String inputText, String prePrompt) async {
    await _chatService.sendMessage(inputText, prePrompt);
    _controller.clear();
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
