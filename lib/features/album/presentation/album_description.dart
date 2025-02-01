import 'package:flutter/material.dart';

class AlbumDescription extends StatelessWidget {
  const AlbumDescription({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Information
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            CircleAvatar(
              backgroundColor: Theme.of(context).colorScheme.surfaceContainer,
              radius: 25,
              child: CircleAvatar(
                backgroundImage: AssetImage('assets/avatar/mathilde.png'),
                radius: 24,
              ),
            ),
            SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Crée par Mathilde',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                ),
                Text(
                  '12 pages utilisées sur 24',
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                ),
              ],
            )
          ],
        ),

        SizedBox(height: 8),

        // Description
        SizedBox(
          width: 300,
          child: Text(
            'Ce voyage en Italie a été un véritable moment de bonheur : une immersion totale dans la dolce vita. Chaque photo raconte une histoire, pleine de saveurs, de rencontres inoubliables et de paysages à couper le souffle. Un album qui capture l’âme de l’Italie, entre tradition et beauté intemporelle.',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Theme.of(context).colorScheme.onSurface,
                ),
            softWrap: true,
          ),
        ),
      ],
    );
  }
}
