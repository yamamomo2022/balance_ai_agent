import 'package:flutter/material.dart';
import '../models/lifestyle.dart'; // Lifestyle クラスの定義ファイルをインポート
import 'lifestyle_ai_agent_page.dart';
import '../widgets/custom_app_bar.dart';

class LifestylePage extends StatefulWidget {
  const LifestylePage({Key? key}) : super(key: key);

  @override
  _LifestylePageState createState() => _LifestylePageState();
}

class _LifestylePageState extends State<LifestylePage> {
  final TextEditingController investmentController =
      TextEditingController(text: '旅行、趣味、スキルアップなどの体験への投資についてご入力ください。');
  final TextEditingController savingsController =
      TextEditingController(text: '節約術や貯蓄計画、効率的な家計管理についてご入力ください。');
  final TextEditingController growthController =
      TextEditingController(text: '学習、趣味、メンタルヘルス向上など自己成長に関するアイディアをご入力ください。');
  final TextEditingController goalsController =
      TextEditingController(text: '具体的な目標設定や達成のための戦略についてご入力ください。');

  @override
  void dispose() {
    investmentController.dispose();
    savingsController.dispose();
    growthController.dispose();
    goalsController.dispose();
    super.dispose();
  }

  void _saveLifestyle() {
    final lifestyle = Lifestyle(
      investment: investmentController.text,
      savings: savingsController.text,
      growth: growthController.text,
      goals: goalsController.text,
    );

    // ここで lifestyle オブジェクトを使用した処理を記述
    // 例: コンソールに出力
    print('Lifestyle Saved: ${lifestyle.toMap()}');
    // または、SnackBarで通知する例
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('ライフスタイル情報を保存しました。')),
    );
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => LifestyleAIAgentPage(lifestyle: lifestyle)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Lifestyle Page'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: const Text(
                '体験投資',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: investmentController,
              maxLines: 5,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 24),
            Center(
              child: const Text(
                '節約・貯蓄',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: savingsController,
              maxLines: 5,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 24),
            Center(
              child: const Text(
                '自己成長',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: growthController,
              maxLines: 5,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 24),
            Center(
              child: const Text(
                '目標設定',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: goalsController,
              maxLines: 5,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: _saveLifestyle,
              child: const Text('保存'),
            ),
          ],
        ),
      ),
    );
  }
}
