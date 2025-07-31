import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Represents the state of the persistent tab
enum TabRoute {
  /// Lifestyle tab
  lifestyle('/Lifestyle'),

  /// Chatroom tab
  chatroom('/Chatroom');

  const TabRoute(this.path);

  /// The path associated with the tab route
  final String path;

  /// Returns the TabRoute from a given path
  static TabRoute fromPath(String path) {
    return TabRoute.values.firstWhere(
      (tabRoute) => tabRoute.path == path,
      orElse: () => TabRoute.lifestyle,
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
  /// Constructor initializes the state with the default tab
  PersistentTabStateNotifier() : super(TabRoute.lifestyle);
  static const String _lastTabPathKey = 'last_visited_tab_path';

  /// Load the last visited tab from persistent storage
  Future<void> loadLastVisitedTab() async {
    try {
      final sharedPreferences = await SharedPreferences.getInstance();
      final lastVisitedTabPath = sharedPreferences.getString(_lastTabPathKey);

      if (lastVisitedTabPath != null) {
        state = TabRoute.fromPath(lastVisitedTabPath);
      }
    } on Exception catch (error) {
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
    } on Exception catch (error) {
      // Handle error gracefully
      print('Failed to save last visited tab: $error');
    }
  }
}
