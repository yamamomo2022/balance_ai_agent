import 'package:balance_ai_agent/app_router.dart';
import 'package:balance_ai_agent/firebase_options.dart';
import 'package:balance_ai_agent/providers/lifestyle_provider.dart';
import 'package:balance_ai_agent/providers/user_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:provider/provider.dart' as provider;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // flavor に応じて .env ファイルをロード
  const envFile = kReleaseMode ? '.env.production' : '.env.development';
  await dotenv.load(fileName: envFile);

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
    return provider.MultiProvider(
        providers: [
          provider.ChangeNotifierProvider(create: (_) => UserProvider()),
          provider.ChangeNotifierProvider(create: (_) => LifestyleProvider()),
        ],
        child: MaterialApp.router(
          routerConfig: goRouter,
          debugShowCheckedModeBanner: false,
          title: 'Balance AI Agent',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
            useMaterial3: true,
          ),
        ));
  }
}
