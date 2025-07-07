import 'package:balance_ai_agent/models/lifestyle.dart';
import 'package:balance_ai_agent/view_models/lifestyle_view_model.dart';
import 'package:flutter/foundation.dart';

class LifestyleProvider extends ChangeNotifier {
  final LifestyleViewModel _viewModel = LifestyleViewModel();

  Lifestyle? get lifestyle => _viewModel.lifestyle;
  bool get isLoading => _viewModel.isLoading;

  // 初期化
  Future<void> loadLifestyle() async {
    await _viewModel.loadLifestyle();
    notifyListeners();
  }

  // 保存
  Future<void> saveLifestyle(String goals, String aspirations) async {
    await _viewModel.saveLifestyle(goals, aspirations);
    notifyListeners();
  }
}
