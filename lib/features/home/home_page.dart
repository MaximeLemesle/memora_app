import 'package:flutter/material.dart';
import 'package:memora_app/core/widgets/main_app_bar.dart';
import 'package:memora_app/core/widgets/main_nav_bar.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MainAppBar(
        title: 'Bonjour,',
        name: 'Maxime',
      ),
      body: Center(
        child: Text('Hello World!'),
      ),
      bottomNavigationBar: MainNavBar(),
    );
  }
}
