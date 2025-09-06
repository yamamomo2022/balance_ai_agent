import 'package:balance_ai_agent/app_router.dart';
import 'package:balance_ai_agent/firebase_options.dart';
import 'package:balance_ai_agent/utility/logger.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // アプリケーション開始ログ
  logger.i('Balance AI Agent application starting...');

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  logger.i('Firebase initialized successfully');

  // firebase auth
  final auth = FirebaseAuth.instance;
  try {
    if (auth.currentUser == null) {
      await auth.signInAnonymously();
    }
  } on FirebaseAuthException catch (e) {
    switch (e.code) {
      case 'operation-not-allowed':
        logger.e("Anonymous auth hasn't been enabled for this project.");
      default:
        logger.e('Unknown Firebase auth error', error: e);
    }
  }

  logger.i('Starting Balance AI Agent application');
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final goRouter = ref.watch(appRouterProvider);
    return MaterialApp.router(
      routerConfig: goRouter,
      debugShowCheckedModeBanner: false,
      title: 'Balance AI Agent',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
    );
  }
}
