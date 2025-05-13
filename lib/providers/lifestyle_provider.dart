import 'package:balance_ai_agent/models/lifestyle.dart';
import 'package:balance_ai_agent/services/local_database.dart';
import 'package:flutter/foundation.dart';

class LifestyleProvider extends ChangeNotifier {
  Lifestyle? _currentLifestyle;
  final LocalDatabase _db = LocalDatabase.instance;
  bool isLoading = false;

  Lifestyle? get lifestyle => _currentLifestyle;

  // 初期化
  Future<void> loadLifestyle() async {
    isLoading = true;
    notifyListeners();

    try {
      _currentLifestyle = await _db.getLatestLifestyle();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  // 保存
  Future<void> saveLifestyle(String goals, String aspirations) async {
    isLoading = true;
    notifyListeners();

    final lifestyle = Lifestyle(
      goals: goals,
      aspirations: aspirations,
    );

    await _db.saveLifestyle(lifestyle);
    _currentLifestyle = lifestyle;

    isLoading = false;
    notifyListeners();
  }
}
