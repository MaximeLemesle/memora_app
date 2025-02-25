import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:memora_app/config/theme/app_theme.dart';
import 'package:memora_app/features/home/presentation/pages/home.page.dart';
import 'package:memora_app/features/landing/presentation/landing.page.dart';
import 'package:memora_app/firebase_options.dart';
import 'package:memora_app/features/auth/presentation/login.page.dart';
import 'package:memora_app/features/auth/presentation/signup.page.dart';

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
      routes: {
        '/landing_page': (context) => const LandingPage(),
        '/home_page': (context) => const HomePage(),
        '/login_page': (context) => const LoginPage(),
        '/signup_page': (context) => const SignUpPage()
      },
      initialRoute: '/landing_page',
    );
  }
}
