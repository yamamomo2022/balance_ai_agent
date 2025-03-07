import 'package:balance_ai_agent/pages/self_image_generation_page.dart';
import 'package:flutter/material.dart';
import 'package:balance_ai_agent/pages/chat_room_page.dart';
import 'package:balance_ai_agent/pages/lifestyle_page.dart';

class AppBottomNavBar extends StatelessWidget {
  const AppBottomNavBar({
    super.key,
    required this.currentIndex,
  });

  final int currentIndex;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.edit_note),
          label: 'ライフスタイル',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.chat),
          label: 'チャット',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person_outline),
          label: '自画像生成',
        ),
      ],
      selectedItemColor: Colors.cyan,
      onTap: (index) {
        // Don't navigate if we're already on this page
        if (index == currentIndex) return;

        switch (index) {
          case 0:
            if (context.widget is! LifestylePage) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const LifestylePage()),
              );
            }
          case 1:
            if (context.widget is! ChatRoomPage) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const ChatRoomPage()),
              );
            }
          case 2:
            if (context.widget is! SelfImageGenerationPage) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => const SelfImageGenerationPage()),
              );
            }
        }
      },
    );
  }
}
