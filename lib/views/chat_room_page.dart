import 'dart:math';

import 'package:balance_ai_agent/utility/app_theme.dart';
import 'package:balance_ai_agent/views/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_core/flutter_chat_core.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';

class ChatRoomPage extends StatefulWidget {
  const ChatRoomPage({super.key});

  @override
  ChatRoomPageState createState() => ChatRoomPageState();
}

/// チャットルームページ
class ChatRoomPageState extends State<ChatRoomPage> {
  ChatRoomPageState();

  final _chatController = InMemoryChatController();

  @override
  void dispose() {
    _chatController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: const CustomAppBar(),
      body: Stack(children: [
        Chat(
          chatController: _chatController,
          currentUserId: 'user1',
          onMessageSend: (text) {
            _chatController.insertMessage(
              TextMessage(
                // Better to use UUID or similar for the ID - IDs must be unique
                id: '${Random().nextInt(1000) + 1}',
                authorId: 'user1',
                createdAt: DateTime.now().toUtc(),
                text: text,
              ),
            );
          },
          resolveUser: (UserID id) async {
            return User(id: id, name: 'John Doe');
          },
        ),
        Positioned(
            top: 20, // 上からの距離
            right: 20, // 右からの距離
            child: Material(
              color: AppTheme.transparent,
              child: InkWell(
                onTap: () => {},
                borderRadius: BorderRadius.circular(30),
                child: Container(
                  width: 56,
                  height: 56,
                  decoration: const BoxDecoration(
                    color: AppTheme.secondaryColor, // テーマカラー
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
                      color: AppTheme.whiteColor,
                      size: 24,
                    ),
                  ),
                ),
              ),
            )),
      ]));
}
