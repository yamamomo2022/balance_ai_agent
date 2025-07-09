import 'package:balance_ai_agent/firebase_options.dart';
import 'package:balance_ai_agent/providers/lifestyle_provider.dart';
import 'package:balance_ai_agent/providers/user_provider.dart';
import 'package:balance_ai_agent/views/chat_room_page.dart';
import 'package:balance_ai_agent/views/login_signup_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // flavor に応じて .env ファイルをロード
  const envFile = kReleaseMode ? '.env.production' : '.env.development';
  await dotenv.load(fileName: envFile);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => UserProvider()),
          ChangeNotifierProvider(create: (_) => LifestyleProvider()),
        ],
        child: MaterialApp.router(
          routerConfig: _router,
          debugShowCheckedModeBanner: false,
          title: 'Balance AI Agent',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
            useMaterial3: true,
          ),
        ));
  }
}

class AuthWrapper extends StatefulWidget {
  const AuthWrapper({super.key});

  @override
  State<AuthWrapper> createState() => _AuthWrapperState();
}

class _AuthWrapperState extends State<AuthWrapper> {
  @override
  void initState() {
    super.initState();
    // Listen to auth state changes
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (!mounted) return;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(
      builder: (context, userProvider, _) {
        return userProvider.isLoggedIn
            ? const ChatRoomPage()
            : const LoginSignupPage();
      },
    );
  }
}

/// The route configuration.
final GoRouter _router = GoRouter(
  initialLocation: '/home',
  routes: [
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return const LoginSignupPage();
      },
      routes: [
        GoRoute(
          path: 'chatRoom',
          builder: (BuildContext context, GoRouterState state) {
            return const ChatRoomPage();
          },
        ),
      ],
    ),
  ],
);
