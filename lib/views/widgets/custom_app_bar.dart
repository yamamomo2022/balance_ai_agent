import 'package:balance_ai_agent/utility/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// A custom AppBar with a gradient background and shadow effects.
class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  /// constructor
  const CustomAppBar({
    super.key,
    this.showBackButton = false,
    this.onBackPressed,
    this.backRootRouteName,
  });

  /// Whether to show the back button.
  final bool showBackButton;

  /// Callback when the back button is pressed.
  final VoidCallback? onBackPressed;

  /// The name of the root route to navigate back to.
  final String? backRootRouteName;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: showBackButton
          ? IconButton(
              icon: const Icon(Icons.arrow_back, size: 32),
              onPressed: () {
                if (onBackPressed != null) {
                  onBackPressed!();
                } else if (backRootRouteName != null) {
                  context.goNamed(backRootRouteName!);
                } else {
                  context.pop();
                }
              },
            )
          : null,
      title: const Text('だいたいあん'),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 16, top: 8, bottom: 8),
          child: IconButton(
            icon: const Icon(Icons.settings, size: 32),
            onPressed: () {
              context.goNamed('Setting');
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
}
