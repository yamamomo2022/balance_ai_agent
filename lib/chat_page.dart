import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'genkit_client.dart';
import 'widgets/chat_input_widget.dart';
import 'services/chat_service.dart'; // Import ChatService
import 'widgets/custom_app_bar.dart';
import 'lifestyle_page.dart';

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
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _chatService = ChatService(genkitClient: _genkitClient, context: context);
  }

  // Use ChatService's sendMessage method
  void _handleSend(String inputText, String prePrompt) async {
    await _chatService.sendMessage(inputText, prePrompt);
    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        actions: [
          IconButton(
            icon: const Icon(Icons.assignment_outlined),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const LifestylePage()),
              );
            },
          ),
        ],
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
