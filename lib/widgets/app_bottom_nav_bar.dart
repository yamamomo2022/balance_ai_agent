import 'package:balance_ai_agent/pages/self_image_generation_page.dart';
import 'package:flutter/material.dart';
import 'package:balance_ai_agent/pages/chat_room_page.dart';
import 'package:balance_ai_agent/pages/lifestyle_page.dart';
import 'package:balance_ai_agent/enums/tab_item.dart';

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
      items: [
        BottomNavigationBarItem(
          icon: Icon(TabItem.lifestyle.icon),
          label: TabItem.lifestyle.title,
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.chat),
          label: TabItem.lifestyle.title,
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person_outline),
          label: TabItem.lifestyle.title,
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
                MaterialPageRoute<void>(
                  builder: (BuildContext context) => const LifestylePage(),
                ),
              );
            }
          case 1:
            if (context.widget is! ChatRoomPage) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute<void>(
                  builder: (BuildContext context) => const ChatRoomPage(),
                ),
              );
            }
          case 2:
            if (context.widget is! SelfImageGenerationPage) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute<void>(
                  builder: (BuildContext context) =>
                      const SelfImageGenerationPage(),
                ),
              );
            }
        }
      },
    );
  }
}
