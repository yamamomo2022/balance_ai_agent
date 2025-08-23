import 'package:balance_ai_agent/providers/persistent_tab_state_notifier.dart';
import 'package:balance_ai_agent/views/chat_room_page.dart';
import 'package:balance_ai_agent/views/lifestyle_list_page.dart';
import 'package:balance_ai_agent/views/setting_page.dart';
import 'package:balance_ai_agent/views/signup_page.dart';
import 'package:balance_ai_agent/views/widgets/app_navigation_bar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

final appRouterProvider = Provider<GoRouter>((ref) {
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
                path: '/LifestyleList',
                name: 'LifestyleList',
                pageBuilder: (context, state) => const NoTransitionPage(
                  child: LifestyleListPage(),
                ),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/ChatRoom',
                name: 'ChatRoom',
                pageBuilder: (context, state) => NoTransitionPage(
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
          state.fullPath == '/LifestyleList' || state.fullPath == '/ChatRoom';

      if (isTabRoute && state.fullPath != lastVisitedTabPath) {
        return lastVisitedTabPath;
      }
      return '/Lifestyle';
    },
  );
});
