import 'package:balance_ai_agent/providers/user_provider.dart';
import 'package:balance_ai_agent/utility/app_theme.dart';
import 'package:balance_ai_agent/utility/show_snack_bar.dart';
import 'package:balance_ai_agent/views/login_signup_page.dart';
import 'package:balance_ai_agent/views/widgets/custom_app_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  late final UserProvider userProvider;

  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool _isLoading = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    userProvider = Provider.of<UserProvider>(context, listen: false);
  }

  /// アカウント削除処理
  Future<void> _deleteAccount(BuildContext context) async {
    // ゲストモードの場合は削除処理を実行しない
    if (userProvider.isGuestMode) {
      return;
    }

    // 確認ダイアログを表示
    final userConfirmed = await showDialog<bool>(
          context: context,
          builder: (BuildContext dialogContext) {
            return AlertDialog(
              title: const Text('アカウント削除'),
              content: const Text(
                  'アカウントを削除すると、すべてのデータが完全に削除されます。この操作は取り消せません。削除してもよろしいですか？'),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.of(dialogContext).pop(false),
                  child: const Text('キャンセル'),
                ),
                TextButton(
                  onPressed: () => Navigator.of(dialogContext).pop(true),
                  child: const Text(
                    '削除する',
                    style: TextStyle(color: AppTheme.errorColor),
                  ),
                ),
              ],
            );
          },
        ) ??
        false;

    if (userConfirmed) {
      setState(() {
        _isLoading = true;
      });

      try {
        // 現在のユーザーを取得
        final currentUser = _auth.currentUser;
        if (currentUser != null) {
          // ユーザーを削除
          await currentUser.delete();

          // 削除後、ログインページに戻る
          if (context.mounted) {
            Navigator.of(context, rootNavigator: true).pushAndRemoveUntil(
              MaterialPageRoute(
                builder: (context) => const LoginSignupPage(
                  showDeletedMessage: true,
                ),
              ),
              (route) => false,
            );
          }
        }
      } on FirebaseAuthException catch (authError) {
        var errorMessage = 'アカウント削除中にエラーが発生しました';

        // 特定のエラーケースを処理
        if (authError.code == 'requires-recent-login') {
          errorMessage = '再認証が必要です。一度ログアウトして再度ログインしてからお試しください';
        }

        if (context.mounted) {
          showSnackBar(
            context,
            errorMessage,
            backgroundColor: AppTheme.errorColor,
          );
        }
      } catch (genericError) {
        if (context.mounted) {
          showSnackBar(
            context,
            'アカウント削除中にエラーが発生しました: $genericError',
            backgroundColor: AppTheme.errorColor,
          );
        }
      } finally {
        if (mounted) {
          setState(() {
            _isLoading = false;
          });
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // ゲストモードかどうかを確認
    final isGuestMode = userProvider.isGuestMode;

    return Scaffold(
      appBar: CustomAppBar(
        title: const Text('Settings'),
        showBackButton: true,
        backRootRouteName: 'Lifestyle',
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
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
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        children: [
                          // アカウント情報表示
                          ListTile(
                            leading: Icon(
                              isGuestMode ? Icons.person_outline : Icons.person,
                              color: AppTheme.primaryColor,
                            ),
                            title: const Text('アカウント情報'),
                            subtitle: isGuestMode
                                ? const Text('お試しモードで利用中')
                                : Text(_auth.currentUser?.email ?? ''),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 30),
                  Center(
                    child: ElevatedButton(
                      onPressed: () => _deleteAccount(context),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppTheme.errorColor,
                        foregroundColor: AppTheme.whiteColor,
                        minimumSize: const Size(240, 48),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text(
                        'アカウントを削除する',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 30),
                  // サインアップボタン
                  Center(
                    child: ElevatedButton(
                      onPressed: () => context.goNamed('Signup'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppTheme.primaryColor,
                        foregroundColor: AppTheme.whiteColor,
                        minimumSize: const Size(240, 48),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text(
                        'サインアップ',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
