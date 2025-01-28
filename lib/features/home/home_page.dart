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
      body: Padding(
        padding: EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Mes albums',
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
            ),
            SizedBox(height: 8),
            Container(
              // TODO : Add size in percent
              height: 450,
              width: 300,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Theme.of(context).colorScheme.onSurface,
                ),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Center(
                child: Text(
                  'Aucun album pour le moment',
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: MainNavBar(),
    );
  }
}
