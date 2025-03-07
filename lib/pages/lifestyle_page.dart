import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:balance_ai_agent/providers/lifestyle_provider.dart';

class LifestylePage extends StatefulWidget {
  const LifestylePage({super.key});

  @override
  _LifestylePageState createState() => _LifestylePageState();
}

class _LifestylePageState extends State<LifestylePage> {
  final TextEditingController aspirationsController = TextEditingController();
  final TextEditingController goalsController = TextEditingController();
  bool _isEditMode = false; // 編集モード管理用の変数を追加

  // 既存のコードは同じ...

  @override
  Future<void> _initializeData() async {
    // Providerから保存されたデータを読み込む
    final provider = Provider.of<LifestyleProvider>(context, listen: false);
    await provider.loadLifestyle();

    // 既存のデータがあれば、それをテキストフィールドに設定
    if (provider.lifestyle != null) {
      setState(() {
        aspirationsController.text = provider.lifestyle!.aspirations;
        goalsController.text = provider.lifestyle!.goals;
      });
    } else {
      // デフォルト値を設定
      aspirationsController.text = '世界一のストライカーになる!';
      goalsController.text = 'チームメイトからボールを奪ってシュートを決める!';
    }
    setState(() {
      _isEditMode = false; // 初期状態は閲覧モード
    });
  }

  // トグル機能を実装
  void _toggleEditMode(bool isEdit) {
    setState(() {
      _isEditMode = isEdit;
      if (!_isEditMode) {
        // 保存モードに切り替えた場合、保存処理を実行
        _saveLifestyle();
      }
    });
  }

  @override
  void dispose() {
    aspirationsController.dispose();
    goalsController.dispose();
    super.dispose();
  }

  void _saveLifestyle() {
    // Providerを使ってデータを保存
    final provider = Provider.of<LifestyleProvider>(context, listen: false);
    provider.saveLifestyle(
      goalsController.text,
      aspirationsController.text,
    );

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('保存しました。')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<LifestyleProvider>(builder: (context, provider, child) {
        if (provider.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        return SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 20),
              // 願望のテキストフィールド (編集モードに応じて有効/無効)
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
                enabled: _isEditMode, // 編集モードのみ編集可能
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 24),

              // 目標のテキストフィールド (編集モードに応じて有効/無効)
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
                enabled: _isEditMode, // 編集モードのみ編集可能
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 32),

              // トグルボタンの実装
              Center(
                child: ToggleButtons(
                  direction: Axis.horizontal,
                  onPressed: (int index) {
                    _toggleEditMode(index == 0); // 0=編集モード, 1=保存モード
                  },
                  borderRadius: const BorderRadius.all(Radius.circular(8)),
                  selectedBorderColor: _isEditMode ? Colors.blue : Colors.green,
                  selectedColor: Colors.white,
                  fillColor: _isEditMode ? Colors.blue : Colors.green,
                  color: Colors.blue,
                  constraints: const BoxConstraints(
                    minHeight: 40.0,
                    minWidth: 120.0,
                  ),
                  isSelected: [_isEditMode, !_isEditMode],
                  children: const [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.edit),
                          SizedBox(width: 4),
                          Text('編集'),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.save),
                          SizedBox(width: 4),
                          Text('保存'),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
