import 'package:flutter/material.dart';
import 'package:memora_app/core/widgets/main_app_bar.widget.dart';

class NewAlbumPage extends StatelessWidget {
  const NewAlbumPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBar(variant: AppBarVariant.actionAppBar),
      body: SizedBox.expand(
        child: Column(
          children: [
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.add_photo_alternate_outlined,
                      size: 48,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Ajouter une photo de couverture',
                      style: Theme.of(context).textTheme.titleSmall,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
