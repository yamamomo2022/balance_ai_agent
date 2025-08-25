import 'package:balance_ai_agent/views/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_core/flutter_chat_core.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:uuid/uuid.dart';

/// チャットルームページ
class ChatRoomPage extends StatefulWidget {
  /// コンストラクタ
  const ChatRoomPage({super.key});

  @override
  ChatRoomPageState createState() => ChatRoomPageState();
}

/// チャットルームページの状態
class ChatRoomPageState extends State<ChatRoomPage> {
  /// コンストラクタ
  ChatRoomPageState();

  final _chatController = InMemoryChatController();

  final _currentUserId = 'user1';

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
          currentUserId: _currentUserId,
          onMessageSend: (text) {
            _chatController.insertMessage(
              TextMessage(
                id: const Uuid().v4(),
                authorId: _currentUserId,
                createdAt: DateTime.now().toUtc(),
                text: text,
              ),
            );
          },
          resolveUser: (UserID id) async {
            return User(id: id, name: 'John Doe');
          },
        )
      ]));
}
