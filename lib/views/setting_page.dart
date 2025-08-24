import 'package:balance_ai_agent/utility/app_theme.dart';
import 'package:balance_ai_agent/views/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';

/// 設定画面
class SettingPage extends StatelessWidget {
  /// コンストラクタ
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        showBackButton: true,
        backRootRouteName: 'Lifestyle',
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: SizedBox(
                height: 64,
                width: double.infinity,
                child: ListTile(
                    leading: const Icon(
                      Icons.person,
                      color: AppTheme.primaryColor,
                    ),
                    title: const Text('ログイン / サインアップ'),
                    onTap: () => {}),
              ),
            ),
            const SizedBox(height: 10),
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: SizedBox(
                height: 64,
                width: double.infinity,
                child: ListTile(
                    leading: const Icon(
                      Icons.delete_forever,
                      color: AppTheme.primaryColor,
                    ),
                    title: const Text('アカウント削除'),
                    onTap: () => {}),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
