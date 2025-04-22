import 'package:flutter/material.dart';

class TextPageSkeletonWidget extends StatelessWidget {
  const TextPageSkeletonWidget({super.key});

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
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 24,
          children: [
            Text(
              'Page de texte',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            Column(
              spacing: 12,
              children: [
                Text(
                  'Cette page permet d’introduire un voyage, de raconter une anecdote en détails, ou de faire tout ce que je vous voulez.',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontStyle: FontStyle.italic,
                        color: Theme.of(context)
                            .colorScheme
                            .surfaceContainerHighest,
                      ),
                ),
                Container(
                  height: 200,
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
                  'En plus de ça, vous pouvez ajouter une image pour illustrer vos propos !',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontStyle: FontStyle.italic,
                        color: Theme.of(context)
                            .colorScheme
                            .surfaceContainerHighest,
                      ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
