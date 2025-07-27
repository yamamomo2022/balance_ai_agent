import 'package:balance_ai_agent/utility/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// A custom AppBar with a gradient background and shadow effects.
class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  /// constructor
  const CustomAppBar({super.key, this.title});

  /// The title widget to display in the AppBar.
  final Widget? title;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: title,
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 16, top: 8, bottom: 8),
          child: IconButton(
            icon: const Icon(Icons.settings, size: 32),
            onPressed: () {
              context.go('/Setting');
            },
          ),
        ),
      ],
      flexibleSpace: Container(
        decoration: const BoxDecoration(
          gradient: AppTheme.appBarGradient,
        ),
      ),
      elevation: 5,
      scrolledUnderElevation: 10, // スクロール時の高さ
      shadowColor: AppTheme.shadowColor, // 影の色
      surfaceTintColor: AppTheme.transparent, // サーフェスの色合い
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
