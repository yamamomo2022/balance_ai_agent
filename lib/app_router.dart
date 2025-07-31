import 'package:balance_ai_agent/providers/persistent_tab_state_notifier.dart';
import 'package:balance_ai_agent/views/chat_room_page.dart';
import 'package:balance_ai_agent/views/lifestyle_page.dart';
import 'package:balance_ai_agent/views/setting_page.dart';
import 'package:balance_ai_agent/views/signup_page.dart';
import 'package:balance_ai_agent/views/widgets/app_navigation_bar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

final appRouterProvider = Provider<GoRouter>((ref) {
  final persistentTabStateNotifier =
      ref.read(persistentTabStateProvider.notifier);

  return GoRouter(
    initialLocation: '/Lifestyle',
    routes: [
      GoRoute(
          path: '/Setting',
          name: 'Setting',
          pageBuilder: (context, state) => const NoTransitionPage(
                child: SettingPage(),
              ),
          routes: [
            GoRoute(
              path: 'Signup',
              name: 'Signup',
              pageBuilder: (context, state) => const NoTransitionPage(
                child: SignupPage(),
              ),
            )
          ]),
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return AppNavigationBar(navigationShell: navigationShell);
        },
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/Lifestyle',
                name: 'Lifestyle',
                pageBuilder: (context, state) => const NoTransitionPage(
                  child: LifestylePage(),
                ),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/ChatRoom',
                name: 'ChatRoom',
                pageBuilder: (context, state) => const NoTransitionPage(
                  child: ChatRoomPage(),
                ),
              ),
            ],
          ),
        ],
      )
    ],
    redirect: (context, state) async {
      final lastVisitedTabPath = ref.read(persistentTabStateProvider).path;
      final isTabRoute =
          state.fullPath == '/Lifestyle' || state.fullPath == '/ChatRoom';

      // 初回のみリダイレクト（例: クエリパラメータやstate.extraで判定してもOK）
      if (isTabRoute &&
          state.fullPath != lastVisitedTabPath &&
          state.extra != 'redirected') {
        // GoRouterのstate.extraを使ってリダイレクト済みか判定
        return lastVisitedTabPath;
      }
      return null;
    },
  );
});
