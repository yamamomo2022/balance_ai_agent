import 'package:balance_ai_agent/views/Lifestyle_page.dart';
import 'package:balance_ai_agent/views/chat_room_page.dart';
import 'package:balance_ai_agent/views/setting_page.dart';
import 'package:balance_ai_agent/views/widgets/app_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// The root navigator key for the entire app.
final rootNavigatorKey = GlobalKey<NavigatorState>();

/// The navigator keys for each tab in the app.
final lifestyleNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'Lifestyle');

/// The navigator key for the chat room tab.
final chatRoomNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'ChatRoom');

/// The navigator key for the settings tab.
final settingNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'setting');

/// The route configuration.
final GoRouter appRouter = GoRouter(
  navigatorKey: rootNavigatorKey,
  initialLocation: '/Lifestyle',
  routes: [
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return AppNavigationBar(navigationShell: navigationShell);
      },
      branches: [
        StatefulShellBranch(navigatorKey: lifestyleNavigatorKey, routes: [
          GoRoute(
            path: '/Lifestyle',
            pageBuilder: (constext, state) => const NoTransitionPage(
              child: LifestylePage(),
            ),
          ),
        ]),
        StatefulShellBranch(
          navigatorKey: chatRoomNavigatorKey,
          routes: [
            GoRoute(
              path: '/ChatRoom',
              pageBuilder: (constext, state) => const NoTransitionPage(
                child: ChatRoomPage(),
              ),
            ),
          ],
        ),
        StatefulShellBranch(
          navigatorKey: settingNavigatorKey,
          routes: [
            GoRoute(
              path: '/Setting',
              pageBuilder: (constext, state) => const NoTransitionPage(
                child: SettingPage(),
              ),
            ),
          ],
        ),
      ],
    )
  ],
);
