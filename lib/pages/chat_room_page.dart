import 'dart:convert';
import 'dart:math';

import 'package:balance_ai_agent/models/lifestyle.dart';
import 'package:balance_ai_agent/pages/login_signup_page.dart';
import 'package:balance_ai_agent/widgets/app_bottom_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_chat_ui/flutter_chat_ui.dart';

import 'lifestyle_page.dart';
import 'package:balance_ai_agent/widgets/custom_app_bar.dart';
import 'package:dio/dio.dart';
import 'package:balance_ai_agent/services/genkit_client.dart';
import 'package:firebase_auth/firebase_auth.dart';

String randomString() {
  final random = Random.secure();
  final values = List<int>.generate(16, (i) => random.nextInt(255));
  return base64UrlEncode(values);
}

class ChatRoomPage extends StatefulWidget {
  const ChatRoomPage({super.key, this.lifestyle});

  final Lifestyle? lifestyle;

  @override
  ChatRoomPageState createState() => ChatRoomPageState();
}

class ChatRoomPageState extends State<ChatRoomPage> {
  final List<types.Message> _messages = [];
  final _user = const types.User(id: '82091008-a484-4a89-ae75-a22bf8d6f3ac');
  final _agent = const types.User(id: 'agentId');
  final dio = Dio();
  late final GenkitClient _genkitClient;

  @override
  void initState() {
    super.initState();
    _genkitClient = GenkitClient(dio: dio);

    // Add lifestyle information as a message if it's not null
    if (widget.lifestyle != null) {
      final lifestyleMessage = types.TextMessage(
        author: _agent, // Or _user, depending on who "owns" the lifestyle
        createdAt: DateTime.now().millisecondsSinceEpoch,
        id: randomString(),
        text:
            '- 願望 -\n${widget.lifestyle!.aspirations}\n\n- 目標 -\n${widget.lifestyle!.goals}\n\n素晴らしい願望と目標ですね!\n\nところで，あなたは今，何をしようとしているのですか？',
      );
      _addMessage(lifestyleMessage);
    }
  }

  void _addMessage(types.Message message) {
    setState(() {
      _messages.insert(0, message);
    });
  }

  Future<void> _handleSendPressed(types.PartialText message) async {
    if (message.text.isEmpty) {
      return;
    }
    final textMessage = types.TextMessage(
      author: _user,
      createdAt: DateTime.now().millisecondsSinceEpoch,
      id: randomString(),
      text: message.text,
    );

    _addMessage(textMessage);

    final responseText = await _genkitClient.generateChatResponse(
        message.text, widget.lifestyle);
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
        appBar: CustomAppBar(),
        body: Chat(
          user: _user,
          messages: _messages,
          onSendPressed: _handleSendPressed,
        ),
        bottomNavigationBar: const AppBottomNavBar(currentIndex: 1),
      );
}
