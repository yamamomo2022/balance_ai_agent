import 'dart:convert';
import 'dart:math';

import 'package:balance_ai_agent/pages/login_signup_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_chat_ui/flutter_chat_ui.dart';

import 'lifestyle_page.dart';
import 'package:balance_ai_agent/widgets/custom_app_bar.dart';
import 'package:dio/dio.dart';
import 'package:balance_ai_agent/genkit_client.dart';
import 'package:balance_ai_agent/services/chat_service.dart'; // Import ChatService

String randomString() {
  final random = Random.secure();
  final values = List<int>.generate(16, (i) => random.nextInt(255));
  return base64UrlEncode(values);
}

class ChatRoomPage extends StatefulWidget {
  const ChatRoomPage({super.key});

  @override
  ChatRoomPageState createState() => ChatRoomPageState();
}

class ChatRoomPageState extends State<ChatRoomPage> {
  final List<types.Message> _messages = [];
  final _user = const types.User(id: '82091008-a484-4a89-ae75-a22bf8d6f3ac');
  final _agent = const types.User(id: 'agentId');
  final dio = Dio();
  late final GenkitClient _genkitClient;
  late final ChatService _chatService; // Declare ChatService

  @override
  void initState() {
    super.initState();
    _genkitClient = GenkitClient(dio: dio);
    _chatService = ChatService(genkitClient: _genkitClient, context: context);
  }

  void _addMessage(types.Message message) {
    setState(() {
      _messages.insert(0, message);
    });
  }

  Future<void> _handleSendPressed(types.PartialText message) async {
    final textMessage = types.TextMessage(
      author: _user,
      createdAt: DateTime.now().millisecondsSinceEpoch,
      id: randomString(),
      text: message.text,
    );

    _addMessage(textMessage);

    final responseText = await _genkitClient.generateChatResponse(message.text);
    // Agent's reply (parrot)
    final agentMessage = types.TextMessage(
      author: _agent,
      createdAt: DateTime.now().millisecondsSinceEpoch,
      id: randomString(),
      text: responseText,
    );

    _addMessage(agentMessage);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: CustomAppBar(
          actions: [
            IconButton(
              icon: const Icon(Icons.assignment_outlined),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const LifestylePage()),
                );
              },
            ),
          ],
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              SizedBox(
                height: 128,
                child: DrawerHeader(
                  child: Text('Menu'),
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 114, 219, 184),
                  ),
                ),
              ),
              ListTile(
                title: Row(
                  children: [
                    Icon(Icons.login),
                    SizedBox(width: 8),
                    Text('Login'),
                  ],
                ),
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const LoginSignupPage()),
                  );
                },
              ),
            ],
          ),
        ),
        body: Chat(
          user: _user,
          messages: _messages,
          onSendPressed: _handleSendPressed,
        ),
      );
}
