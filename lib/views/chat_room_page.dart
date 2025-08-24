import 'package:balance_ai_agent/utility/app_theme.dart';
import 'package:balance_ai_agent/views/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// チャットルームページ
class ChatRoomPage extends ConsumerWidget {
  /// コンストラクタ
  ChatRoomPage({super.key});

  final List<types.Message> _messages = [];
  final _user = const types.User(id: '82091008-a484-4a89-ae75-a22bf8d6f3ac');

  @override
  Widget build(BuildContext context, WidgetRef ref) => Scaffold(
        appBar: const CustomAppBar(),
        body: Stack(children: [
          Chat(
            user: _user,
            messages: _messages,
            onSendPressed: (types.PartialText partialText) {},
            theme:
                const DefaultChatTheme(backgroundColor: AppTheme.transparent),
          ),
          Positioned(
              top: 20, // 上からの距離
              right: 20, // 右からの距離
              child: Material(
                color: AppTheme.transparent,
                child: InkWell(
                  onTap: () => {},
                  borderRadius: BorderRadius.circular(30),
                  child: Container(
                    width: 56,
                    height: 56,
                    decoration: const BoxDecoration(
                      color: AppTheme.secondaryColor, // テーマカラー
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 4,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: const Center(
                      child: Icon(
                        Icons.refresh,
                        color: AppTheme.whiteColor,
                        size: 24,
                      ),
                    ),
                  ),
                ),
              )),
        ]),
      );
}
