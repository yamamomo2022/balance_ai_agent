import 'package:balance_ai_agent/models/lifestyle.dart';
import 'package:balance_ai_agent/view_models/lifestyle_view_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'lifestyle_provider.g.dart';

/// Provides the current user's lifestyle information.
@riverpod
class LifestyleNotifier extends _$LifestyleNotifier {
  @override
  Future<Lifestyle?> build() async {
    final lifestyleViewModel = LifestyleViewModel();
    await lifestyleViewModel.loadLifestyle();
    return lifestyleViewModel.lifestyle;
  }

  /// Saves the user's lifestyle information.
  Future<void> saveLifestyle(String goals, String aspirations) async {
    final lifestyleViewModel = LifestyleViewModel();
    await lifestyleViewModel.saveLifestyle(goals, aspirations);
    state = AsyncValue.data(lifestyleViewModel.lifestyle);
  }
}
