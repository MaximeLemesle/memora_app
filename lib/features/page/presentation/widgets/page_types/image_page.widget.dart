import 'package:flutter/material.dart';
import 'package:memora_app/features/page/domain/entities/page.entity.dart';

class ImagePageWidget extends StatelessWidget {
  final PageEntity page;

  const ImagePageWidget({super.key, required this.page});

  @override
  Widget build(BuildContext context) {
    final title = page.title ?? '';
    final image = page.images ?? [];
    final legend = page.texts ?? [];

    return Container(
      height: 450,
      width: 300,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Theme.of(context).colorScheme.surface,
        border: Border.all(
          color: Theme.of(context).colorScheme.surfaceContainer,
          width: 1.5,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 24,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            Column(
              spacing: 12,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: Image.network(
                    image[0],
                    fit: BoxFit.cover,
                    height: 300,
                    width: double.infinity,
                  ),
                ),
                Text(
                  legend[0],
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
