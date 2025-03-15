import 'package:balance_ai_agent/pages/chat_room_page.dart';
import 'package:balance_ai_agent/pages/lifestyle_page.dart';
import 'package:balance_ai_agent/pages/setting_page.dart';
import 'package:flutter/material.dart';

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
  setting(
    title: '設定',
    icon: Icons.settings,
    page: SettingPage(),
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
