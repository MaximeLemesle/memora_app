import 'package:flutter/material.dart';

class ImagePageSkeletonWidget extends StatelessWidget {
  const ImagePageSkeletonWidget({super.key});

  @override
  Widget build(BuildContext context) {
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
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 24,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 24,
        children: [
          Text(
            'Page image',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          Flexible(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: 250,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surfaceContainer,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Center(
                    child: Icon(
                      Icons.image,
                      size: 48,
                      color: Theme.of(context).colorScheme.outline,
                    ),
                  ),
                ),
                Text(
                  'Cette page permet d’ajouter une image et une légende à votre histoire.',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontStyle: FontStyle.italic,
                        color: Theme.of(context)
                            .colorScheme
                            .surfaceContainerHighest,
                      ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
