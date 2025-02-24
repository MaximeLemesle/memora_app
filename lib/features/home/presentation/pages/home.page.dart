import 'package:flutter/material.dart';
import 'package:memora_app/features/album/presentation/widgets/album_list.widget.dart';
import 'package:memora_app/core/widgets/main_app_bar.widget.dart';
import 'package:memora_app/core/widgets/main_nav_bar.widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MainAppBar(
        title: 'Bonjour,',
        name: 'Maxime',
      ),
      body: SizedBox.expand(
        child: Stack(
          children: [
            Padding(
              padding: EdgeInsets.only(left: 24, top: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                spacing: 6,
                children: [
                  Text(
                    'Mes albums',
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                  ),
                  AlbumList(),
                ],
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: MainNavBar(),
            ),
          ],
        ),
      ),
    );
  }
}
