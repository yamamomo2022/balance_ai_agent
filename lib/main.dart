import 'package:balance_ai_agent/app_router.dart';
import 'package:balance_ai_agent/firebase_options.dart';
import 'package:balance_ai_agent/providers/lifestyle_provider.dart';
import 'package:balance_ai_agent/providers/logger_provider.dart';
import 'package:balance_ai_agent/providers/user_provider.dart';
import 'package:balance_ai_agent/services/logger_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // グローバルエラーハンドリングの設定
  FlutterError.onError = (FlutterErrorDetails details) {
    LoggerService.instance.error(
      'Flutter Error: ${details.exception}',
      error: details.exception,
      stackTrace: details.stack,
    );
    if (kDebugMode) {
      FlutterError.presentError(details);
    }
  };

  // 非同期エラーのハンドリング
  PlatformDispatcher.instance.onError = (error, stack) {
    LoggerService.instance.error(
      'Platform Error: $error',
      error: error,
      stackTrace: stack,
    );
    return true;
  };

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // flavor に応じて .env ファイルをロード
  const envFile = kReleaseMode ? '.env.production' : '.env.development';
  await dotenv.load(fileName: envFile);

  // アプリケーション開始をログに記録
  LoggerService.instance.info('Application initialization completed');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => LoggerProvider()..logAppStart()),
          ChangeNotifierProvider(create: (_) => UserProvider()),
          ChangeNotifierProvider(create: (_) => LifestyleProvider()),
        ],
        child: MaterialApp.router(
          routerConfig: appRouter,
          debugShowCheckedModeBanner: false,
          title: 'Balance AI Agent',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
            useMaterial3: true,
          ),
        ));
  }
}
