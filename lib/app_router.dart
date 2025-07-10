import 'package:balance_ai_agent/views/Lifestyle_page.dart';
import 'package:balance_ai_agent/views/chat_room_page.dart';
import 'package:balance_ai_agent/views/setting_page.dart';
import 'package:balance_ai_agent/views/widgets/app_navigation_bar.dart';
import 'package:go_router/go_router.dart';

/// The route configuration.
final GoRouter appRouter = GoRouter(initialLocation: '/LifestylePage', routes: [
  StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return AppNavigationBar(navigationShell: navigationShell);
      },
      branches: [
        StatefulShellBranch(routes: [
          GoRoute(
            path: '/LifestylePage',
            pageBuilder: (constext, state) => const NoTransitionPage(
              child: LifestylePage(),
            ),
          ),
          GoRoute(
            path: '/ChatRoomPage',
            pageBuilder: (constext, state) => const NoTransitionPage(
              child: ChatRoomPage(),
            ),
          ),
          GoRoute(
            path: '/SettingPage',
            pageBuilder: (constext, state) => const NoTransitionPage(
              child: SettingPage(),
            ),
          ),
        ])
      ])
]);
