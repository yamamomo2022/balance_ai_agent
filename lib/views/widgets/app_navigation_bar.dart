import 'package:balance_ai_agent/providers/persistent_tab_state_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

/// アプリのナビゲーションバーを定義するウィジェット
/// StatefulNavigationShellを使用して、タブの状態を管理します。
///
/// - [navigationShell]: タブの状態を管理するためのStatefulNavigationShell
class AppNavigationBar extends ConsumerWidget {
  /// コンストラクタ
  const AppNavigationBar({
    required this.navigationShell,
    super.key,
  });

  // NavigationShellを受け取る
  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: NavigationBar(
        selectedIndex: navigationShell.currentIndex,
        destinations: const [
          NavigationDestination(
              icon: Icon(Icons.edit_note), label: 'Lifestyle'),
          NavigationDestination(icon: Icon(Icons.chat), label: 'Chat'),
        ],
        onDestinationSelected: (index) {
          // 選択されたタブのインデックスに基づいてルートを更新
          final tabRoute = index == 0
              ? TabRoute.lifestyle
              : TabRoute.chatroom; // 選択されたタブに応じてルートを設定
          ref
              .read(persistentTabStateProvider.notifier)
              .updateCurrentTab(tabRoute);

          navigationShell.goBranch(index,
              initialLocation: index == navigationShell.currentIndex);
        },
      ),
    );
  }
}
