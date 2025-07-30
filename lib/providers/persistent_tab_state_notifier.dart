import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum TabRoute {
  Lifestyle('/Lifestyle'),
  Chatroom('/Chatroom');

  const TabRoute(this.path);
  final String path;

  static TabRoute fromPath(String path) {
    return TabRoute.values.firstWhere(
      (tabRoute) => tabRoute.path == path,
      orElse: () => TabRoute.Lifestyle,
    );
  }
}

/// Notifier to manage the persistent state of the selected tab
final persistentTabStateProvider =
    StateNotifierProvider<PersistentTabStateNotifier, TabRoute>((ref) {
  return PersistentTabStateNotifier();
});

/// Notifier to manage the persistent state of the selected tab
class PersistentTabStateNotifier extends StateNotifier<TabRoute> {
  PersistentTabStateNotifier() : super(TabRoute.Lifestyle);
  static const String _lastTabPathKey = 'last_visited_tab_path';

  Future<void> loadLastVisitedTab() async {
    try {
      final sharedPreferences = await SharedPreferences.getInstance();
      final lastVisitedTabPath = sharedPreferences.getString(_lastTabPathKey);

      if (lastVisitedTabPath != null) {
        state = TabRoute.fromPath(lastVisitedTabPath);
      }
    } catch (error) {
      print('Error loading last visited tab: $error');
    }
  }

  /// Update current tab and persist to storage
  Future<void> updateCurrentTab(TabRoute newTabRoute) async {
    state = newTabRoute;
    await _saveLastVisitedTab(newTabRoute);
  }

  /// Save the current tab to persistent storage
  Future<void> _saveLastVisitedTab(TabRoute tabRoute) async {
    try {
      final sharedPreferences = await SharedPreferences.getInstance();
      await sharedPreferences.setString(_lastTabPathKey, tabRoute.path);
    } catch (error) {
      // Handle error gracefully
      print('Failed to save last visited tab: $error');
    }
  }
}
