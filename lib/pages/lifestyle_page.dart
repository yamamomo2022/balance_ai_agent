import 'package:flutter/material.dart';
import 'package:balance_ai_agent/models/lifestyle.dart'; // Lifestyle クラスの定義ファイルをインポート
import 'package:balance_ai_agent/widgets/custom_app_bar.dart';
import 'chat_room_page.dart';

class LifestylePage extends StatefulWidget {
  const LifestylePage({Key? key}) : super(key: key);

  @override
  _LifestylePageState createState() => _LifestylePageState();
}

class _LifestylePageState extends State<LifestylePage> {
  final TextEditingController goalsController =
      TextEditingController(text: '具体的な目標設定や達成のための戦略についてご入力ください。');
  final TextEditingController aspirationsController =
      TextEditingController(text: '学習、趣味、メンタルヘルス向上など自己成長に関するアイディアをご入力ください。');

  @override
  void dispose() {
    aspirationsController.dispose();
    goalsController.dispose();
    super.dispose();
  }

  void _saveLifestyle() {
    final lifestyle = Lifestyle(
      goals: goalsController.text,
      aspirations: aspirationsController.text,
    );

    // ここで lifestyle オブジェクトを使用した処理を記述
    // 例: コンソールに出力
    print('Lifestyle Saved: ${lifestyle.toMap()}');
    // または、SnackBarで通知する例
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('ライフスタイル情報を保存しました。')),
    );
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => ChatRoomPage()));
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
                '目標',
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
            const SizedBox(height: 24),
            Center(
              child: const Text(
                '願望',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: aspirationsController,
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
