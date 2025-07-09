import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// アプリのナビゲーションバーを定義するウィジェット
/// StatefulNavigationShellを使用して、タブの状態を管理します。
///
/// - [navigationShell]: タブの状態を管理するためのStatefulNavigationShell
class AppNavigationBar extends StatelessWidget {
  /// コンストラクタ
  const AppNavigationBar({
    required this.navigationShell,
    super.key,
  });

  // NavigationShellを受け取る
  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: NavigationBar(
        selectedIndex: navigationShell.currentIndex,
        destinations: const [
          NavigationDestination(icon: Icon(Icons.edit_note), label: 'Home'),
          NavigationDestination(icon: Icon(Icons.chat), label: 'chat'),
          NavigationDestination(icon: Icon(Icons.settings), label: 'settings'),
        ],
        onDestinationSelected: (index) {
          navigationShell.goBranch(index,
              initialLocation: index == navigationShell.currentIndex);
        },
      ),
    );
  }
}
