import 'package:flutter/material.dart';
import 'package:balance_ai_agent/pages/lifestyle_page.dart';
import 'package:balance_ai_agent/pages/chat_room_page.dart';
import 'package:balance_ai_agent/pages/self_image_generation_page.dart';

enum TabItem {
  lifestyle(
    title: 'ライフスタイル',
    icon: Icons.edit_note,
    page: LifestylePage(),
  ),
  chat(
    title: 'チャット',
    icon: Icons.chat,
    page: ChatRoomPage(),
  ),
  selfImageGeneration(
    title: '自画像生成',
    icon: Icons.person_outline,
    page: SelfImageGenerationPage(),
  );

  const TabItem({
    required this.title,
    required this.icon,
    required this.page,
  });

  final String title;
  final IconData icon;
  final Widget page;
}
