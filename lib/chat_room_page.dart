import 'package:flutter/material.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:uuid/uuid.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final List<types.Message> _messages = [];
  final types.User _user =
      const types.User(id: '82091a39-a3a4-4731-96ea-72e94a6886f8');

  void _addMessage(types.TextMessage message) {
    setState(() {
      _messages.insert(0, message);
    });
  }

  @override
  Widget build(BuildContext context) {
    // Example text message creation; modify as needed.
    final textMessage = types.TextMessage(
      author: _user,
      createdAt: DateTime.now().millisecondsSinceEpoch,
      id: const Uuid().v4(),
      text: 'Hello, world!', // Replace with the desired text.
    );
    _addMessage(textMessage);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat'),
      ),
      body: Chat(
        messages: _messages,
        user: _user,
        onSendPressed: (message) {
          // TODO: Implement send message action
        },
      ),
    );
  }
}
