import 'package:flutter/material.dart';
import 'package:memora_app/features/page/domain/entities/page.entity.dart';

class TextPageWidget extends StatelessWidget {
  final PageEntity page;

  const TextPageWidget({super.key, required this.page});

  @override
  Widget build(BuildContext context) {
    final title = page.title ?? '';
    final image = page.images ?? [];
    final texts = page.texts ?? [];

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
              children: [
                Text(
                  texts[0],
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: Image.network(
                    image[0],
                    fit: BoxFit.cover,
                    height: 150,
                    width: double.infinity,
                  ),
                ),
                Text(
                  texts[1],
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
