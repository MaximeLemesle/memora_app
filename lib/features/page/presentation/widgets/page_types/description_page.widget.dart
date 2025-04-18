import 'package:flutter/material.dart';
import 'package:memora_app/features/page/domain/entities/page.entity.dart';

class DescriptionPageWidget extends StatelessWidget {
  final PageEntity page;

  const DescriptionPageWidget({super.key, required this.page});

  @override
  Widget build(BuildContext context) {
    final title = page.title ?? '';
    final description = page.description ?? [];

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
                  description[0],
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                Container(
                  height: 150,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                Text(
                  description[1],
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
