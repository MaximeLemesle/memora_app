import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:memora_app/config/theme/app_theme.dart';
import 'package:memora_app/features/home/home_page.dart';
import 'package:memora_app/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Memora',
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system,
      theme: lightMode,
      routes: {'/home_page': (context) => const HomePage()},
      initialRoute: '/home_page',
    );
  }
}
