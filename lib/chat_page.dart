import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'genkit_client.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});
  final String title = 'Chat Page';

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  // Controller to manage input in the text field
  final TextEditingController _controller = TextEditingController();

  final dio = Dio();
  late final GenkitClient _genkitClient;

  @override
  void initState() {
    super.initState();
    _genkitClient = GenkitClient(dio: dio);
  }

  // Method to send the input text
  void _sendText() async {
    final inputText = _controller.text;
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
            SizedBox(
              width: 300,
              child: TextField(
                controller: _controller,
                decoration: const InputDecoration(
                  hintText: 'Enter text to send',
                ),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _sendText,
              child: const Icon(Icons.send),
            ),
          ],
        ),
      ),
    );
  }
}
