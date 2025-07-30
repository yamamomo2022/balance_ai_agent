import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Provider for the last accessed tab path
/// This is used to remember which tab was last active when the app is reopened.
final lastTabPathProvider = StateProvider<String?>((ref) => '/Lifestyle');
