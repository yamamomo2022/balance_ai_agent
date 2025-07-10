import 'package:balance_ai_agent/providers/lifestyle_provider.dart';
import 'package:balance_ai_agent/utility/app_theme.dart';
import 'package:balance_ai_agent/views/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LifestylePage extends StatefulWidget {
  const LifestylePage({super.key});

  @override
  LifestylePageState createState() => LifestylePageState();
}

class LifestylePageState extends State<LifestylePage> {
  final TextEditingController aspirationsController = TextEditingController();
  final TextEditingController goalsController = TextEditingController();
  bool _isEditMode = false; // 編集モード管理用の変数を追加

  @override
  void initState() {
    super.initState();

    // ビルド後に実行するようにスケジュール
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initializeData();
    });
  }

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
      if (_isEditMode) {
        aspirationsController.text = aspirationsController.text;
        goalsController.text = goalsController.text;
      } else if (aspirationsController.text.isNotEmpty ||
          goalsController.text.isNotEmpty) {
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
    try {
      // Providerを使ってデータを保存
      final provider = Provider.of<LifestyleProvider>(context, listen: false);

      // 最新のものと同じであれば，保存しない
      if (provider.lifestyle != null &&
          provider.lifestyle!.aspirations == aspirationsController.text &&
          provider.lifestyle!.goals == goalsController.text) {
        return;
      }

      provider.saveLifestyle(
        goalsController.text,
        aspirationsController.text,
      );

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('保存しました。')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('エラーが発生しました: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: Consumer<LifestyleProvider>(builder: (context, provider, child) {
        if (provider.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        return SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 20),
              // 願望のテキストフィールド (編集モードに応じて有効/無効)
              const Center(
                child: Text(
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
              const Center(
                child: Text(
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
                  onPressed: (int index) {
                    _toggleEditMode(index == 0); // 0=編集モード, 1=保存モード
                  },
                  borderRadius: const BorderRadius.all(Radius.circular(8)),
                  selectedBorderColor: _isEditMode
                      ? AppTheme.editModeColor
                      : AppTheme.saveModeColor,
                  selectedColor: AppTheme.whiteColor,
                  fillColor: _isEditMode
                      ? AppTheme.editModeColor
                      : AppTheme.saveModeColor,
                  color: AppTheme.editModeColor,
                  constraints: const BoxConstraints(
                    minHeight: 40,
                    minWidth: 120,
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
