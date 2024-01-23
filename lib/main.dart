import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gtext/gtext.dart';
import 'package:todo_listapp_r5/config/constants/environment.dart';
import 'package:todo_listapp_r5/config/theme/app_theme.dart';
import 'package:todo_listapp_r5/firebase_options.dart';
import 'package:todo_listapp_r5/presentation/screens/screens.dart';

void main() async {
  await Environment.initEnvironment();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  GText.init(enableCaching: false, to: 'en');
  initializeDateFormatting('es', null).then((_) {
    runApp(const ProviderScope(child: MainApp()));
  });
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme().getTheme(),
      home: const HomeScreen(),
    );
  }
}
