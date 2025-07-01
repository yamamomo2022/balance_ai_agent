import 'dart:convert';
import 'dart:math';

import 'package:balance_ai_agent/providers/lifestyle_provider.dart';
import 'package:balance_ai_agent/services/genkit_client.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:provider/provider.dart';

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

  @override
  void initState() {
    super.initState();
    _genkitClient = GenkitClient(dio: dio);

    // ビルド後に実行するようにスケジュール
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initializeData();
    });
  }

  Future<void> _initializeData() async {
    final provider = Provider.of<LifestyleProvider>(context, listen: false);
    try {
      await provider.loadLifestyle();
    } catch (e) {
      print('Failed to load lifestyle: $e');
    }

    // 既存のデータがあれば、それをテキストフィールドに設定
    if (provider.lifestyle != null) {
      final lifestyleMessage = types.TextMessage(
        author: _agent, // Or _user, depending on who "owns" the lifestyle
        createdAt: DateTime.now().millisecondsSinceEpoch,
        id: randomString(),
        text:
            '- 願望 -\n${provider.lifestyle!.aspirations}\n\n- 目標 -\n${provider.lifestyle!.goals}\n\n素晴らしい願望と目標ですね!\n\nところで，あなたは今，何をしようとしているのですか？',
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

    final provider = Provider.of<LifestyleProvider>(context, listen: false);

    final responseText = await _genkitClient.generateChatResponse(
        message.text, provider.lifestyle);
    final agentMessage = types.TextMessage(
      author: _agent,
      createdAt: DateTime.now().millisecondsSinceEpoch,
      id: randomString(),
      text: responseText,
    );

    _addMessage(agentMessage);
  }

  /// 会話履歴をクリアして初期データを再ロードします
  void _handleResetConversation() {
    setState(_messages.clear);
    _initializeData();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Stack(children: [
          Chat(
            user: _user,
            messages: _messages,
            onSendPressed: _handleSendPressed,
            theme: const DefaultChatTheme(backgroundColor: Colors.transparent),
          ),
          Positioned(
              top: 20, // 上からの距離
              right: 20, // 右からの距離
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: _handleResetConversation,
                  borderRadius: BorderRadius.circular(30),
                  child: Container(
                    width: 56,
                    height: 56,
                    decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 98, 185, 195), // テーマカラー
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 4,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: const Center(
                      child: Icon(
                        Icons.refresh,
                        color: Colors.white,
                        size: 24,
                      ),
                    ),
                  ),
                ),
              )),
        ]),
      );
}
